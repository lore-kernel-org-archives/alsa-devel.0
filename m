From: Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v3 0/15] Those patches is used for dw_hdmi audio support
Date: Tue,  3 Feb 2015 09:56:58 -0500
Message-ID: <1422975418-13302-1-git-send-email-ykk@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Yao <mark.yao-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, Yakir Yang <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dbehr-ph2c+iIn4itg9hUCZPvPmw@public.gmane.org, mmind00-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


We found Designware hdmi driver only support audio clock config, we can not play sound through it.
To add Designware HDMI Audio support, we make those patch set:
1): fixed dw_hdmi irq bug, add irq control to suspend/resume interfaces.
2): add suspend/resume callback for dw_hdmi rockchip driver.
3): Warp irq control in functions.
4): Combine hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
5): Adjust n/cts config order.
6): Set ncts_atomic_write & cts_manual, according to dw_hdmi document.
7): Add audio support for more display resolutions(eg. 800x600).
8): Add audio support for No-CEA display resolutions.
9): Add Audio Sample Channel Status config interfaces to dw_hdmi driver.
10): add audio clock control interfaces o dw_hdmi driver.
11): creat "dw_hdmi-audio" platform device in dw_hdmi driver.
12): add codec driver for hdmi audio, callback dw_hdmi audio config functions.
13): add sound driver for hdmi audio, creat hdmi audio sound card.
14): add dt-bings file and add hdmi_audio node to corresponding dt file.


Changes in v3:
- Clear Hotplug interrupts before dw_hdmi_fb_register
- Wrap irq control in fucntions
- Setting the .pm member instead of suspend/resume
- Add ID registers parse and record
- Combine hdmi_set_clock_regenerator_n() and hdmi_regenerate_cts()
- Only adjust the n/cts setting order
- Set ncts_atomic_write & cts_manual
- Determine whether sample channel should set by desig_id.
- Delete hdmi_audio_config interface and modify audio clock control functions
- Remove audio_config & get_connect_status callback functions
  and add write/read/mod register callback functions
- Keep audio format config function in dw-hdmi-audio driver
  and remove audio_config & get_connect_status functions,
  move jack control to dw-hdmi-audio completely.
- Delete the operation of jack in rockchip-hdmi-audio driver,
  get ready to switch to simple-audio-card driver.
- modify cpu-of-node to i2s-controller

Changes in v2:
- Add irq control to suspend/resume interfaces
- Add suspend/resume support for dw_hdmi_rockchip driver
- add more n/cts combinations for more display resolutions
- enable audio support for No-CEA display mode
- Add audio sample channel status setting
- Add audio config interfaces to dw_hdmi driver
- Update the audio control interfaces
- Update dw_hdmi audio control interfaces, and adjust jack report process
- give "codec-name" & "codec-dai-name" an const name
- remove codec-name and codec-dai-name
- rename rockchip,rockchip-hdmi-audio.txt to rockchip,rockchip-dw-hdmi-audio.txt

Yakir Yang (15):
  drm: bridge/dw_hdmi: add irq control to suspend/resume
  drm: bridge/dw_hdmi: wrap irq control in fucntions
  drm: rockchip/dw_hdmi_rockchip: add resume/suspend support
  drm: bridge/dw_hdmi: add indentification registers parse and record
  drm: bridge/dw_hdmi: combine hdmi_set_clock_regenerator_n() and
    hdmi_regenerate_cts()
  drm: bridge/dw_hdmi: adjust n/cts setting order
  drm: bridge/dw_hdmi: set ncts_atomic_write & cts_manual
  drm: bridge/dw_hdmi: add audio support for more display resolutions
  drm: bridge/dw_hdmi: enable audio support for No-CEA display
    resolutions
  drm: bridge/dw_hdmi: add audio sample channel status setting
  drm: bridge/dw_hdmi: add audio clock control interfaces
  drm: bridge/dw_hdmi: creat dw-hdmi-audio platform device
  ASoC: dw-hdmi-audio: add codec driver for dw hdmi audio
  ASoC: rockchip-hdmi-audio: add sound driver for hdmi audio
  dt-bindings: Add documentation for Rockchip dw-hdmi-audio

 .../sound/rockchip,rockchip-dw-hdmi-audio.txt      |  12 +
 drivers/gpu/drm/bridge/dw_hdmi.c                   | 361 ++++++++++++++++++---
 drivers/gpu/drm/bridge/dw_hdmi.h                   |  49 +++
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c        |  16 +
 include/drm/bridge/dw_hdmi.h                       |  17 +
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/dw-hdmi-audio.c                   | 333 +++++++++++++++++++
 sound/soc/codecs/dw-hdmi-audio.h                   |  79 +++++
 sound/soc/rockchip/Kconfig                         |   9 +
 sound/soc/rockchip/Makefile                        |   2 +
 sound/soc/rockchip/rockchip_hdmi_audio.c           | 168 ++++++++++
 12 files changed, 1013 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rockchip-dw-hdmi-audio.txt
 create mode 100644 sound/soc/codecs/dw-hdmi-audio.c
 create mode 100644 sound/soc/codecs/dw-hdmi-audio.h
 create mode 100644 sound/soc/rockchip/rockchip_hdmi_audio.c

-- 
2.1.2


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
