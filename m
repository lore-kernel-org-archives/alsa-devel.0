From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/2] ASoC: Add support to Qualcomm msm8916-wcd codec
Date: Fri, 10 Jun 2016 19:18:43 +0100
Message-ID: <1465582725-30183-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, plai@codeaurora.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset aims at adding msm8916-wcd codec support.
msm8916-wcd codec is found in Qualcomm msm8916 and apq8016 processors.
This codec IP is split in to two parts(Digital & Analog), Analog part
is integrated in to PMIC PM8916 and the digital part is integrated into
Application processor. Register access to the analog part is done via
SPMI interface to PMIC, and registers on the Application processor are
memory mapped. Data transfer between Analog and Digital Die is done via
a internal bus called PDM.

Most of this driver is ported from downstream Andriod v3.10 kernel.
Jack support and Headset button detection code is not added in to this series.

This codec support:
 - 3 Microphones: Primary Mic(Handset mic), Headset Mic and Secondary Mic.
 - 2 Digital Microphones.
 - 2 Mic Bias Circuits.
 - Earpiece
 - Headset
 - Loud Speaker.
 - Jack Detect.
 - Headset Button detection circuit.

Tested this code on v4.6-rc2 with lpass driver capture support patches for
Headset (Mic and speakers), Secondary Mic and Loudspeaker on DB410C.
DMIC should work too.

Thanks,
srini

Changes since RFC v2:
 - Fixed error handling on regluator_enable suggested by Kenneth.
 - Fixed compatible strings suggested by Kenneth
 - make max/min rates inline with actual supported rates,
 	spotted by Kenneth
 - Few minor suggestions by Kenneth.

Changes since RFC v1 (https://lkml.org/lkml/2016/2/16/710)
- Lot of code cleanup as suggest by Mark Brown.
- Fixed bindings as suggested by Mark Rutland.
- merged all the patches to one as spliting the patches did not help review.

Srinivas Kandagatla (2):
  ASoC: msm8916: Add codec Device Tree bindings.
  ASoC: msm8916: Add msm8916-wcd codec driver

 .../devicetree/bindings/sound/qcom,msm8916-wcd.txt |  103 ++
 include/dt-bindings/sound/msm8916-wcd.h            |    7 +
 sound/soc/codecs/Kconfig                           |    4 +
 sound/soc/codecs/Makefile                          |    3 +-
 sound/soc/codecs/msm8916-wcd-registers.h           |  710 +++++++++
 sound/soc/codecs/msm8916-wcd.c                     | 1575 ++++++++++++++++++++
 sound/soc/codecs/msm8916-wcd.h                     |  308 ++++
 7 files changed, 2709 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd.txt
 create mode 100644 include/dt-bindings/sound/msm8916-wcd.h
 create mode 100644 sound/soc/codecs/msm8916-wcd-registers.h
 create mode 100644 sound/soc/codecs/msm8916-wcd.c
 create mode 100644 sound/soc/codecs/msm8916-wcd.h

--
2.8.3
