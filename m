From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 0/3] ASoC: codecs: msm8916-wcd-analog: Add support to MBHC
Date: Thu, 17 Aug 2017 10:02:08 +0200
Message-ID: <20170817080211.11453-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: damien.riegel@savoirfairelinux.com, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset adds support to MBHC(Multibutton headset control) block in PM8916
analog block. MBHC support comes from 2 blocks first mechanical headset detection
and second headset type, 5 button detection.

This patchset adds support to:
1> Support to NC and NO type of headset Jacks.
2> Mechanical insertion and detection of headset jack.
3> Detect a 3 pole Headphone and a 4 pole Headset.
4> Detect 5 buttons.

Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
and during playback and recording use cases.

Changes since v3(https://lkml.org/lkml/2017/8/2/609):
	- dropped ASoC: codecs: msm8916-wcd-analog: move codec reset to probe
	- fixed rampup time for micbias spotted by Mark.
	- Added tested-by from Dimien
	- Dropped dt patch from this series.

Srinivas Kandagatla (3):
  ASoC: codecs: msm8916-wcd-analog: get micbias voltage from dt
  ASoC: codecs: msm8916-wcd-analog: add MBHC support
  ASoC: qcom: apq8016-sbc: Add support to Headset JACK

 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  18 +-
 sound/soc/codecs/msm8916-wcd-analog.c              | 400 ++++++++++++++++++++-
 sound/soc/qcom/apq8016_sbc.c                       |  34 ++
 3 files changed, 444 insertions(+), 8 deletions(-)

-- 
2.11.0
