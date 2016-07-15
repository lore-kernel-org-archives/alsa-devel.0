From: njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Subject: [PATCH 0/4] Qualcomm IPQ4019 Audio driver addition
Date: Fri, 15 Jul 2016 12:37:02 +0530
Message-ID: <1468566426-19598-1-git-send-email-njaigane@codeaurora.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-A+ZNKFmMK5xy9aJCnZT0Uw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, twp-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, plai-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bgoswami-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pradeepb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, snlakshm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, bselvara-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Jaiganesh Narayanan <njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Jaiganesh Narayanan <njaigane-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

These patches add the support for Qualcomm IPQ4019 ASoC
with the ALSA based audio drivers. The patches are broken

1. Device Tree support
2. Audio clock driver support
3. TLMM / Pinctrl support
4. ALSA based audio drivers

Jaiganesh Narayanan (4):
  qcom: ipq4019: Add ipq4019 ASoC device tree changes
  qcom: ipq4019: ASoC clock driver support
  qcom: ipq4019: ASoC tlmm/pinctrl support
  qcom: ipq4019: Add ASoC driver modules

 .../bindings/sound/qca,ipq4019-audio-adss.txt      |  20 +
 .../bindings/sound/qca,ipq4019-audio.txt           |  13 +
 .../bindings/sound/qca,ipq4019-codec.txt           |  15 +
 .../devicetree/bindings/sound/qca,ipq4019-i2s.txt  |  33 +
 .../devicetree/bindings/sound/qca,ipq4019-i2s1.txt |  29 +
 .../devicetree/bindings/sound/qca,ipq4019-i2s2.txt |  29 +
 .../devicetree/bindings/sound/qca,ipq4019-mbox.txt |  23 +
 .../bindings/sound/qca,ipq4019-pcm-i2s.txt         |  15 +
 .../bindings/sound/qca,ipq4019-pcm-i2s1.txt        |  15 +
 .../bindings/sound/qca,ipq4019-pcm-i2s2.txt        |  15 +
 .../bindings/sound/qca,ipq4019-pcm-spdif.txt       |  15 +
 .../bindings/sound/qca,ipq4019-pcm-tdm.txt         |  15 +
 .../bindings/sound/qca,ipq4019-spdif.txt           |  35 +
 .../bindings/sound/qca,ipq4019-stereo.txt          |  17 +
 .../devicetree/bindings/sound/qca,ipq4019-tdm.txt  |  33 +
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi      | 195 ++++-
 arch/arm/boot/dts/qcom-ipq4019.dtsi                | 247 +++++-
 drivers/clk/qcom/Kconfig                           |   8 +
 drivers/clk/qcom/Makefile                          |   2 +
 drivers/clk/qcom/adcc-ipq4019.c                    | 700 +++++++++++++++++
 drivers/clk/qcom/clk-qcapll.c                      | 197 +++++
 drivers/clk/qcom/clk-qcapll.h                      |  60 ++
 drivers/clk/qcom/clk-rcg.h                         |  68 +-
 drivers/clk/qcom/clk-rcg2.c                        | 699 ++++++++++++++++-
 drivers/clk/qcom/common.c                          |   9 +-
 drivers/clk/qcom/common.h                          |   3 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c             | 116 ++-
 include/dt-bindings/clock/qca,adcc-ipq4019.h       |  45 ++
 include/dt-bindings/clock/qcom,gcc-ipq4019.h       |   4 +-
 include/dt-bindings/sound/ipq4019-audio.h          |  37 +
 sound/soc/qcom/Kconfig                             |  47 ++
 sound/soc/qcom/Makefile                            |   1 +
 sound/soc/qcom/ipq4019/Makefile                    |  16 +
 sound/soc/qcom/ipq4019/ipq4019-adss.c              | 407 ++++++++++
 sound/soc/qcom/ipq4019/ipq4019-adss.h              | 432 +++++++++++
 sound/soc/qcom/ipq4019/ipq4019-codec.c             | 475 ++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-codec.h             |  91 +++
 sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c           | 687 +++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-mbox.c              | 825 +++++++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-mbox.h              | 146 ++++
 sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c           | 609 +++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c         | 664 +++++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c           | 609 +++++++++++++++
 sound/soc/qcom/ipq4019/ipq4019-pcm.h               |  37 +
 sound/soc/qcom/ipq4019/ipq4019-stereo.c            | 313 ++++++++
 sound/soc/qcom/ipq4019/ipq4019.c                   | 121 +++
 46 files changed, 8135 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-audio-adss.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-codec.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-i2s1.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-i2s2.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-mbox.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s1.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-i2s2.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-pcm-tdm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-spdif.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-stereo.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qca,ipq4019-tdm.txt
 create mode 100644 drivers/clk/qcom/adcc-ipq4019.c
 create mode 100644 drivers/clk/qcom/clk-qcapll.c
 create mode 100644 drivers/clk/qcom/clk-qcapll.h
 create mode 100644 include/dt-bindings/clock/qca,adcc-ipq4019.h
 create mode 100644 include/dt-bindings/sound/ipq4019-audio.h
 create mode 100644 sound/soc/qcom/ipq4019/Makefile
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-adss.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-adss.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-codec.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-codec.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-cpu-dai.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-mbox.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-mbox.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm-i2s.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm-spdif.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm-tdm.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-pcm.h
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019-stereo.c
 create mode 100644 sound/soc/qcom/ipq4019/ipq4019.c

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
