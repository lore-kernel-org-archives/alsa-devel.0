From: Damien Riegel <damien.riegel@savoirfairelinux.com>
Subject: [PATCH v1 0/3] add jack detection to MSM8916 analog
Date: Tue, 25 Jul 2017 13:51:23 -0400
Message-ID: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@savoirfairelinux.com, Damien Riegel <damien.riegel@savoirfairelinux.com>
List-Id: alsa-devel@alsa-project.org

This series adds support for the MBHC (Multi-Button Headset Control) of
the PM8916's analog codec. This IP is capable to identify up to five
buttons on a headset, but for now only the jack detection is supported.
A complete implementation exists in the Android kernel, but it's quite
complex and I'd rather go step by step.

First patch fixes a define that is squatting a bit used by the MBHC.
Second patch is the actual implementation of the jack detection, and
third patch plugs the jack detection in the sound card driver.

Damien Riegel (3):
  ASoC: codecs: msm8916-analog: fix DIG_CLK_CTL_RXD3_CLK_EN define
  ASoC: codecs: msm8916-analog: support jack detection
  ASoC: qcom: apq8016-sbc: enable jack detection

 sound/soc/codecs/msm8916-wcd-analog.c | 105 +++++++++++++++++++++++++++++++++-
 sound/soc/codecs/msm8916-wcd-analog.h |  18 ++++++
 sound/soc/qcom/apq8016_sbc.c          |  16 ++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/msm8916-wcd-analog.h

-- 
2.13.3
