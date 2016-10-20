From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v6 0/5] ASoC: Add support to Qualcomm msm8916-wcd multi codec
Date: Thu, 20 Oct 2016 15:20:44 +0100
Message-ID: <1476973249-14547-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kwestfie-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
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

Tested this code on v4.9-rc1 with for Headset (Mic and speakers), Secondary Mic
and Loudspeaker on DB410C. DMIC should work too.
Last DT patch is on top of v4.9-rc1 which get analog audio working. 

Thanks,
srini


Changes since v5:
	- Fixed DT example style and compatible string as suggested by Rob.
	- Added Rob's acks to 2 patches.

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
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  85 ++
 .../bindings/sound/qcom,msm8916-wcd-digital.txt    |  20 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |  61 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   9 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi               |  45 +-
 sound/soc/codecs/Kconfig                           |   7 +
 sound/soc/codecs/Makefile                          |   5 +-
 sound/soc/codecs/msm8916-wcd-analog.c              | 890 ++++++++++++++++++++
 sound/soc/codecs/msm8916-wcd-digital.c             | 923 +++++++++++++++++++++
 sound/soc/qcom/apq8016_sbc.c                       |  11 +-
 11 files changed, 2048 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-digital.txt
 create mode 100644 sound/soc/codecs/msm8916-wcd-analog.c
 create mode 100644 sound/soc/codecs/msm8916-wcd-digital.c

--
2.9.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
