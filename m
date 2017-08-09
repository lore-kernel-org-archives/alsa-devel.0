From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 0/5] ASoC: codecs: msm8916-wcd-analog: Add support to MBHC
Date: Wed,  9 Aug 2017 18:49:22 +0200
Message-ID: <20170809164927.19663-1-srinivas.kandagatla@linaro.org>
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

Damien sent a similar patchset to add support to mechanical detection,
but that patch has issues and will not work on most usecases (for example
after a playback/capture session, multicodec case). So I only picked up
the BIT mask patch from that series.

Tested it on DB410c with Audio Mezz board with 4 pole and 3 pole
and during playback and recording use cases.

Changes since v2(https://lkml.org/lkml/2017/8/2/609):
	- cleaned up code spotted by Damien
	- dropped fix snd_soc_codec_set_jack return error as it alredy applied

Srinivas Kandagatla (5):
  ASoC: codecs: msm8916-wcd-analog: move codec reset to probe
  ASoC: codecs: msm8916-wcd-analog: get micbias voltage from dt
  ASoC: codecs: msm8916-wcd-analog: add MBHC support
  ASoC: qcom: apq8016-sbc: Add support to Headset JACK
  arm64: dts: apq8016-sbc: add mbhc buttons support

 .../bindings/sound/qcom,msm8916-wcd-analog.txt     |  18 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi          |   2 +
 sound/soc/codecs/msm8916-wcd-analog.c              | 407 +++++++++++++++++++--
 sound/soc/qcom/apq8016_sbc.c                       |  34 ++
 4 files changed, 437 insertions(+), 24 deletions(-)

-- 
2.9.3
