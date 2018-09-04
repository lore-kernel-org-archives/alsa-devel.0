From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 00/13] ASoC: Add support to WCD9335 Audio Codec
Date: Tue,  4 Sep 2018 11:24:47 +0100
Message-ID: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Thankyou for reviewing v2 patchset, here is v3 addressing comments from v2.

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
, capture paths and MBHC.

Some parts of the code has been inherited from Qualcomm andriod kernel,
so credits to various authors.

WCD9335 can be interfaced via I2S/I2C or SLIMbus. 

Here is my test branch incase someone want to try this out:
https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=wcd9335

Thanks,
Srini

Changes since v2 (https://lwn.net/Articles/761107/)
 - Updated dt bindings according to Robs Comments.
 - Added MBHC support with new bindings
 - Moved mfd irq in to single file as suggested by Lee Jones.
 - Addressed various minor comments on mfd driver by Lee Jones.
 - Rebased on top of 4.19-rc1
 - renamed clsh as clsh-v2 as its v2 block

Srinivas Kandagatla (13):
  ASoC: dt-bindings: update wcd9335 bindings.
  mfd: wcd9335: add support to wcd9335 core
  mfd: wcd9335: add wcd irq support
  ASoC: wcd9335: add support to wcd9335 codec
  ASoC: wcd9335: add CLASS-H Controller support
  ASoC: wcd9335: add basic controls
  ASoC: wcd9335: add playback dapm widgets
  ASoC: wcd9335: add capture dapm widgets
  ASoC: wcd9335: add audio routings
  ASoC: dt-bindings: Add WCD9335 MBHC specific properties
  ASoC: wcd9335: add mbhc support
  ASoC: apq8096: add slim support
  ASoC: apq8096: add headset JACK support

 .../bindings/sound/qcom,wcd9335.txt           |   30 +-
 drivers/mfd/Kconfig                           |   14 +
 drivers/mfd/Makefile                          |    4 +
 drivers/mfd/wcd9335-core.c                    |  369 ++
 include/linux/mfd/wcd9335/registers.h         |  627 ++
 include/linux/mfd/wcd9335/wcd9335.h           |   65 +
 sound/soc/codecs/Kconfig                      |    5 +
 sound/soc/codecs/Makefile                     |    2 +
 sound/soc/codecs/wcd-clsh-v2.c                |  577 ++
 sound/soc/codecs/wcd-clsh-v2.h                |   49 +
 sound/soc/codecs/wcd9335.c                    | 5234 +++++++++++++++++
 sound/soc/qcom/apq8096.c                      |  122 +-
 12 files changed, 7092 insertions(+), 6 deletions(-)
 create mode 100644 drivers/mfd/wcd9335-core.c
 create mode 100644 include/linux/mfd/wcd9335/registers.h
 create mode 100644 include/linux/mfd/wcd9335/wcd9335.h
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.c
 create mode 100644 sound/soc/codecs/wcd-clsh-v2.h
 create mode 100644 sound/soc/codecs/wcd9335.c

-- 
2.18.0
