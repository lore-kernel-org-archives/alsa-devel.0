From: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [RFC PATCH 0/6] Those patches is used for dw_hdmi audio.
Date: Mon, 15 Dec 2014 10:11:28 +0800
Message-ID: <1418609494-15820-1-git-send-email-ykk@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Xu Jianqun <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?q?St=C3=A9phane=20Marchesin?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Grant
List-Id: alsa-devel@alsa-project.org


rk3288 use Designware HDMI IP, Designware HDMI supports four interfaces to
config hdmi audio(I2S, S/PDIF, Generic Parallel Audio, AHB Audio DMA), but
rk3288 only support two ways to config hdmi audio(I2S, S/PDIF), So we take
I2S as hdmi audio operation interfaces, and then treat hdmi audio as an
standard ALSA devices(only got platback function).

Four things we have done:
1. modify the audio part of dw_hdmi drivers for rk3288 platform specific.
2. add codec driver for hdmi audio, and creat codec device dynamically in
   hdmi driver probe function, using platform_register_device_full way, so
   that hdmi codec driver can connected with hdmi driver.
3. add sound driver for hdmi audio, creat hdmi audio sound card.
4. add dt-bings file and add hdmi_audio node to corresponding dt file.

[Explanation]:
those patch is depend on patch by Andy Yan
drm: bridge/dw_hdmi: add rockchip rk3288 support
see https://patchwork.kernel.org/patch/5442361/


Yakir Yang (6):
  drm: bridge/dw_hdmi: add hdmi audio config interfaces
  drm: bridge/bridge: add support for rk3288 hdmi-audio
  ASoC: dw-hdmi-audio: add codec driver for dw hdmi audio
  ASoC: rockchip-hdmi-audio: add sound driver for hdmi audio
  dt-bindings: Add documentation for Rockchip hdmi-audio
  ARM: dts: rockchip: add hdmi audio nodes

 .../sound/rockchip,rockchip-hdmi-audio.txt         |  16 +
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  11 +
 arch/arm/boot/dts/rk3288.dtsi                      |   8 +
 drivers/gpu/drm/bridge/dw_hdmi.c                   |  32 +-
 include/drm/bridge/dw_hdmi.h                       |  12 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/dw-hdmi-audio.c                   | 371 +++++++++++++++++++++
 sound/soc/codecs/dw-hdmi-audio.h                   |  82 +++++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_hdmi_audio.c           | 208 ++++++++++++
 12 files changed, 756 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-hdmi-audio.txt
 create mode 100644 sound/soc/codecs/dw-hdmi-audio.c
 create mode 100644 sound/soc/codecs/dw-hdmi-audio.h
 create mode 100644 sound/soc/rockchip/rockchip_hdmi_audio.c

-- 
2.1.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
