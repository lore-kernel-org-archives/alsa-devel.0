From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 0/5] ASoC: Add support to Qualcomm msm8916-wcd multi codec
Date: Thu,  8 Sep 2016 14:04:51 +0100
Message-ID: <1473339896-9409-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: robh+dt@kernel.org, mark.rutland@arm.com, tiwai@suse.com, devicetree@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset aims at adding msm8916-wcd multi codec support.
msm8916-wcd codec is found in Qualcomm msm8916 and apq8016 processors.
This codec IP is split in to two parts(Digital & Analog), Analog part
is integrated in to PMIC PM8916 and the digital part is integrated into
Application processor. Register access to the analog part is done via
SPMI interface to PMIC, and registers on the Application processor are
memory mapped. Data transfer between Analog and Digital Die is done via
a internal bus called PDM.

Most of this driver is ported from downstream Andriod v3.10 kernel.
Jack support and Headset button detection code is not added in to this
series.

First two patches add digital and analog codec support and the follow on
patches add routes and multicodec support to the sound card and
finally dts patch for board.

This codec support:
 - 3 Microphones: Primary Mic(Handset mic), Headset Mic and Secondary Mic.
 - 2 Digital Microphones.
 - 2 Mic Bias Circuits.
 - Earpiece
 - Headset
 - Loud Speaker.
 - Jack Detect.
 - Headset Button detection circuit.

Tested this code on v4.8-rc3 with for Headset (Mic and speakers), Secondary Mic
and Loudspeaker on DB410C. DMIC should work too.

Thanks,
srini

Changes since v4:
	- Fixed various C-style related issues reported by Mark
	- Added shutdown call to clear things setup in startup,
	spotted by Mark.
	- Rearranged code to make it more readble suggested by
	Mark.
	- Converted dmic clk to a dapm supply spotted by Mark.
	- Added example in dt bindings to show support of multicodec.
	- Removed two patches from this list as they are already
	 applied in sound tree.

Changes since v3:
	- Split the codec to 2 seperate codecs digital and analog,
	suggested by Mark and Kenneth.
	- Addressed various suggestions from Mark and Kenneth.

Srinivas Kandagatla (5):
  ASoC: codecs: Add msm8916-wcd analog codec
  ASoC: codecs: Add msm8916-wcd digital codec
  ASoC: apq8016-sbc: dt bindings: remove incorrect property
  ASoC: qcom: apq8016-sbc: Add support to multi codec.
  arm64: dts: apq8016-sbc: add analog audio support with multicodec

 .../devicetree/bindings/sound/qcom,apq8016-sbc.txt |   5 +-
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  83 ++
 .../bindings/sound/qcom,msm8916-wcd-digital.txt    |  20 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  63 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   9 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |  45 +-
 sound/soc/codecs/Kconfig                           |   7 +
 sound/soc/codecs/Makefile                          |   5 +-
 sound/soc/codecs/msm8916-wcd-analog.c              | 888 ++++++++++++++++++++
 sound/soc/codecs/msm8916-wcd-digital.c             | 920 +++++++++++++++++++++
 sound/soc/qcom/apq8016_sbc.c                       |  11 +-
 11 files changed, 2043 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt
 create mode 100644 sound/soc/codecs/msm8916-wcd-analog.c
 create mode 100644 sound/soc/codecs/msm8916-wcd-digital.c

-- 
2.7.4
