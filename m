From: jianqun <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH 0/2] add rockchip i2s driver
Date: Tue,  1 Jul 2014 16:37:38 +0800
Message-ID: <1404203860-30712-1-git-send-email-xjq@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kfx-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

This patch is to add driver for I2S controller in RK3xxx SoCs.

Jianqun Xu (2):
  ASoC: dt-bindings: add rockchip i2s bindings
  ASoC: add driver for Rockchip RK3xxx I2S controller

 .../devicetree/bindings/sound/rockchip-i2s.txt     |   45 ++
 sound/soc/Kconfig                                  |    1 +
 sound/soc/Makefile                                 |    1 +
 sound/soc/rockchip/Kconfig                         |   16 +
 sound/soc/rockchip/Makefile                        |    6 +
 sound/soc/rockchip/i2s.h                           |  222 +++++++
 sound/soc/rockchip/pcm.h                           |   14 +
 sound/soc/rockchip/rockchip_i2s.c                  |  622 ++++++++++++++++++++
 sound/soc/rockchip/rockchip_pcm.c                  |   64 ++
 9 files changed, 991 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-i2s.txt
 create mode 100644 sound/soc/rockchip/Kconfig
 create mode 100644 sound/soc/rockchip/Makefile
 create mode 100644 sound/soc/rockchip/i2s.h
 create mode 100644 sound/soc/rockchip/pcm.h
 create mode 100644 sound/soc/rockchip/rockchip_i2s.c
 create mode 100644 sound/soc/rockchip/rockchip_pcm.c

-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
