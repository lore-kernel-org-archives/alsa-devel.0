From: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Subject: [PATCH v4 0/9] Allwinner H5 and Orange Pi PC2 support
Date: Wed,  8 Feb 2017 02:30:33 +0800
Message-ID: <20170207183042.62699-1-icenowy@aosc.xyz>
Reply-To: icenowy-ymACFijhrKM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCZLPFN5Q4OBB5NE5DCAKGQEXXDVKVY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>
Cc: linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Allwinner H5 is a 64-bit SoC with a design like the 32-bit
H3.

This patchset adds support for it, along with the first available
board -- Orange Pi PC2.

Some drivers are also enabled to be built on ARM64 ARCH_SUNXI
platform, in order to make the internal audio codec work.

Andre Przywara (3):
  arm: dts: sun8i: split Allwinner H3 .dtsi
  arm64: dts: allwinner: add Allwinner H5 .dtsi
  arm64: dts: sunxi: add support for the Orange Pi PC 2 board

Icenowy Zheng (6):
  arm64: allwinner: Kconfig: add essential pinctrl driver for H5
  clk: sunxi-ng: rename sun8i-h3 driver to sunxi-h3-h5
  clk: sunxi-ng: add support for Allwinner H5 SoC
  ARM: dts: sun8i: convert H3 dtsi to use new sunxi-h3-h5 binding header
  dt-bindings: remove transitional headers for Allwinner H3 CCU
  ASoC: sunxi: allow the analog codec driver to be built on ARM64

 .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 789 ++++-----------------
 .../boot/dts/{sun8i-h3.dtsi => sunxi-h3-h5.dtsi}   |  91 +--
 arch/arm64/Kconfig.platforms                       |   5 +-
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 164 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi       | 139 ++++
 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi     |   1 +
 drivers/clk/sunxi-ng/Kconfig                       |   6 +-
 drivers/clk/sunxi-ng/Makefile                      |   2 +-
 .../sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} | 236 +++++-
 .../sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} |  15 +-
 .../clock/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h}    |  11 +-
 .../reset/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h}    |  11 +-
 sound/soc/sunxi/Kconfig                            |   2 +-
 15 files changed, 709 insertions(+), 765 deletions(-)
 rewrite arch/arm/boot/dts/sun8i-h3.dtsi (81%)
 copy arch/arm/boot/dts/{sun8i-h3.dtsi => sunxi-h3-h5.dtsi} (88%)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/allwinner/sunxi-h3-h5.dtsi
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} (76%)
 rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} (82%)
 rename include/dt-bindings/clock/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h} (95%)
 rename include/dt-bindings/reset/{sun8i-h3-ccu.h => sunxi-h3-h5-ccu.h} (94%)

-- 
2.11.0
