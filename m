From: Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v1 0/2] Patches to add support pdm controller for rk3328
Date: Tue, 13 Jun 2017 15:27:45 +0800
Message-ID: <1497338867-52684-1-git-send-email-sugar.zhang@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Sugar Zhang <sugar.zhang-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liang Chen <cl-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

These patches to add support pdm for rk3328 socs.


Sugar Zhang (2):
  ASoC: rockchip: add support for pdm controller
  arm64: dts: rk3328: add pdm node

 .../devicetree/bindings/sound/rockchip,pdm.txt     |  39 ++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  55 +++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_pdm.c                  | 516 +++++++++++++++++++++
 sound/soc/rockchip/rockchip_pdm.h                  |  83 ++++
 6 files changed, 704 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,pdm.txt
 create mode 100644 sound/soc/rockchip/rockchip_pdm.c
 create mode 100644 sound/soc/rockchip/rockchip_pdm.h

-- 
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
