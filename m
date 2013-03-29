From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH 00/13] mach-mxs header files cleanup
Date: Fri, 29 Mar 2013 16:55:36 +0800
Message-ID: <1364547350-30498-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The series cleans up mach-mxs headers files in order to support
multiplatform build on mxs.

Andrew, Jonathan, Mark,

Can you please give your ACK on the patch you are copied, so that the
series can go via arm-soc as a whole?  Thanks.

Shawn

Shawn Guo (13):
  rtc: stmp3xxx: use stmp_reset_block() instead
  iio: mxs-lradc: remove unneeded mach header inclusion
  ASoC: mxs-saif: remove mach header inclusion
  ARM: mxs: remove empty hardware.h
  ARM: mxs: get reset address from device tree
  ARM: mxs: remove system.c
  ARM: mxs: get ocotp base address from device tree
  ARM: mxs: use debug_ll_io_init for low-level debug
  ARM: mxs: remove mm.c
  ARM: mxs: move mxs_get_ocotp() into mach-mxs.c
  ARM: mxs: remove common.h
  ARM: mxs: merge imx23 and imx28 into one machine_desc
  ARM: mxs: remove unused headers

 arch/arm/boot/dts/imx23.dtsi                 |    3 +-
 arch/arm/boot/dts/imx28.dtsi                 |    3 +-
 arch/arm/mach-mxs/Makefile                   |    4 -
 arch/arm/mach-mxs/include/mach/common.h      |   25 ---
 arch/arm/mach-mxs/include/mach/debug-macro.S |    9 +-
 arch/arm/mach-mxs/include/mach/digctl.h      |   22 ---
 arch/arm/mach-mxs/include/mach/hardware.h    |   23 ---
 arch/arm/mach-mxs/include/mach/mx23.h        |  169 -------------------
 arch/arm/mach-mxs/include/mach/mx28.h        |  225 --------------------------
 arch/arm/mach-mxs/include/mach/mxs.h         |  116 -------------
 arch/arm/mach-mxs/mach-mxs.c                 |  182 +++++++++++++++++----
 arch/arm/mach-mxs/mm.c                       |   52 ------
 arch/arm/mach-mxs/ocotp.c                    |   93 -----------
 arch/arm/mach-mxs/system.c                   |  139 ----------------
 drivers/rtc/rtc-stmp3xxx.c                   |    6 +-
 drivers/staging/iio/adc/mxs-lradc.c          |    3 -
 include/linux/clk/mxs.h                      |   16 ++
 sound/soc/mxs/mxs-saif.c                     |    5 +-
 18 files changed, 180 insertions(+), 915 deletions(-)
 delete mode 100644 arch/arm/mach-mxs/include/mach/common.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/digctl.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/mx23.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/mx28.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/mxs.h
 delete mode 100644 arch/arm/mach-mxs/mm.c
 delete mode 100644 arch/arm/mach-mxs/ocotp.c
 delete mode 100644 arch/arm/mach-mxs/system.c
 create mode 100644 include/linux/clk/mxs.h

-- 
1.7.9.5
