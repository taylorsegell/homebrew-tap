class Pouch < Formula
  desc "Only the skills this project needs."
  homepage "https://github.com/taylorsegell/pouch"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/taylorsegell/pouch/releases/download/v0.1.0/pouch-aarch64-apple-darwin.tar.xz"
      sha256 "efa05185c641ad48ff3dc7b319575819a635e17b2509504256faa74711fbe8b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/taylorsegell/pouch/releases/download/v0.1.0/pouch-x86_64-apple-darwin.tar.xz"
      sha256 "3eabf132cd8dfbf23a6acbd1109185a6927992c656ff4a9534e20010cad8c930"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/taylorsegell/pouch/releases/download/v0.1.0/pouch-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0e9e6fd0cabab54e3adc0018f9275b8f879eb035820343985e0bf6f08cfbf1c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/taylorsegell/pouch/releases/download/v0.1.0/pouch-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "215840dd1e943ea856dbf20d58a3ba80e8ca6c9cc4280c44ca1067f330208bcd"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pouch"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pouch"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pouch"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pouch"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
