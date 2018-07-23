From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/12] mfd: Add support to WCD9335 Audio Codec
Date: Mon, 23 Jul 2018 16:53:58 +0100
Message-ID: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC.
It is integrated in multiple Qualcomm SoCs like: MSM8996, MSM8976,
and MSM8956 chipsets.

WCD9335 had multiple functional blocks, like: Soundwire controller,
interrupt mux, pin controller, Audio codec, MBHC, MAD(Mic activity Detection),
Ultrasonic proximity and pen detection, Battery-voltage monitoring and
Codec processing engine.

Currently this patchset has been only tested with SLIMbus interface due
to hardware avaiablity, but it can be easily made to work with both SLIMbus
and I2C/I2S.    

This patchset adds very basic playback and capture support witout much
fancy features. New features will be added once the basic support is in.
This patchset is tested on top of linux-next on DB820c for both playback
and capture paths.

This patchset also depends on the SLIMbus Stream apis which is already merged
via char-misc tree for 4.19.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is my test branch incase someone want to try this out:
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Thanks,
Srini

Srinivas Kandagatla (12):
  mfd: dt-bindings: Add wcd9335 mfd bindings
  mfd: wcd9335: add support to wcd9335 core
  mfd: wcd9335: add wcd irq support
  ASoC: dt-bindings: add dt bindings for wcd9335 audio codec
  ASoC: core: add support to snd_soc_dai_get_channel_map()
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: apq8096: Add support to Analog audio via WCD9335 slim

 .../devicetree/bindings/mfd/qcom,wcd9335.txt       |  130 +
 .../devicetree/bindings/sound/qcom,wcd9335.txt     |   21 +
 drivers/mfd/Kconfig                                |   18 +
 drivers/mfd/Makefile                               |    4 +
 drivers/mfd/wcd9335-core.c                         |  278 ++
 drivers/mfd/wcd9335-irq.c                          |  172 +
 include/dt-bindings/mfd/wcd9335.h                  |   43 +
 include/linux/mfd/wcd9335/registers.h              |  580 +++
 include/linux/mfd/wcd9335/wcd9335.h                |   43 +
 include/sound/soc-dai.h                            |    8 +
 sound/soc/codecs/Kconfig                           |    5 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/wcd-clsh.c                        | 1010 ++++
 sound/soc/codecs/wcd-clsh.h                        |   69 +
 sound/soc/codecs/wcd9335.c                         | 4981 ++++++++++++++++++++
 sound/soc/qcom/apq8096.c                           |   68 +
 sound/soc/soc-core.c                               |   22 +
 17 files changed, 7454 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/qcom,wcd9335.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
 create mode 100644 drivers/mfd/wcd9335-core.c
 create mode 100644 drivers/mfd/wcd9335-irq.c
 create mode 100644 include/dt-bindings/mfd/wcd9335.h
 create mode 100644 include/linux/mfd/wcd9335/registers.h
 create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
 create mode 100644 sound/soc/codecs/wcd-clsh.c
 create mode 100644 sound/soc/codecs/wcd-clsh.h
 create mode 100644 sound/soc/codecs/wcd9335.c

-- 
2.16.2
