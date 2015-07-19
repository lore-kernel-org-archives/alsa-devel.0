From: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 0/2] Add codec machine driver for rockchip platform
Date: Sun, 19 Jul 2015 19:33:47 +0800
Message-ID: <1437305629-24133-1-git-send-email-zhengxing@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, zhengxing <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

From: zhengxing <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>


Hi,
  The simple-card is not common at present, soc maybe need own machine
driver for jack detection.
  Add drivers for two families of rockchip-bases chromebooks. These
machine drives don't use simplecard because we need custom jack
detection plumbing.

- use ts3a227e for ext jack detection with max98090
- call rt5645_set_jack_detect function via rt5645 codec driver

Thanks.


Changes in v3:
Signed-off-by: zhengxing <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

zhengxing (2):
  ASoC: rockchip: Add machine driver for max98090 codec
  ASoC: rockchip: Add machine driver for rt5645/rt5650 codec

 .../bindings/sound/rockchip-max98090.txt           |   19 ++
 .../devicetree/bindings/sound/rockchip-rt5645.txt  |   17 ++
 sound/soc/rockchip/Kconfig                         |   19 ++
 sound/soc/rockchip/Makefile                        |    6 +
 sound/soc/rockchip/rockchip_max98090.c             |  236 ++++++++++++++++++++
 sound/soc/rockchip/rockchip_rt5645.c               |  225 +++++++++++++++++++
 6 files changed, 522 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-max98090.txt
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip-rt5645.txt
 create mode 100644 sound/soc/rockchip/rockchip_max98090.c
 create mode 100644 sound/soc/rockchip/rockchip_rt5645.c

-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
