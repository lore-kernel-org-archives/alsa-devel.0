From: srinivas.kandagatla@linaro.org
Subject: [PATCH v3 0/3] ASoC: codecs: msm8916-wcd-digital: Fix dmic support
Date: Wed,  2 Aug 2017 15:17:45 +0200
Message-ID: <20170802131748.10958-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset fixes dmic support in the codec driver, first and second
patch fixes the mclk rate for the codec and the third patch adds missing
selection of DMIC in CIC filter source path.

Tested on DB410c with Audio Mezz board which has got dmic on it.

Changes since v2:
	- added cic selection to dapm route

Srinivas Kandagatla (3):
  ASoC: codecs: msm8916-wcd-digital: add support to set_sysclk
  ASoC: qcom: apq8016-sbc: set default mclk rate
  ASoC: codecs: msm8916-wcd-digital: add CIC filter source selection
    path

 sound/soc/codecs/msm8916-wcd-digital.c | 35 ++++++++++++++++++++++++++++++++--
 sound/soc/qcom/apq8016_sbc.c           | 23 ++++++++++++++++++----
 2 files changed, 52 insertions(+), 6 deletions(-)

-- 
2.9.3
