From: srinivas.kandagatla@linaro.org
Subject: [PATCH 0/3] ASoC: codecs: msm8916-wcd-digital: Fix dmic support
Date: Mon, 17 Jul 2017 15:54:07 +0200
Message-ID: <20170717135410.26812-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patchset fixes dmic support in the codec driver, first and second
patch fixes the mclk rate for the codec and the third patch adds few
missing register writes to select dmic.

Tested on DB410c with Audio Mezz board which has got dmic on it.

Srinivas Kandagatla (3):
  ASoC: codecs: msm8916-wcd-digital: add support to set_sysclk
  ASoC: qcom: apq8016-sbc: set default mclk rate
  ASoC: codecs: msm8916-wcd-digital: fix dmic support

 sound/soc/codecs/msm8916-wcd-digital.c | 36 ++++++++++++++++++++++++++++++++++
 sound/soc/qcom/apq8016_sbc.c           |  6 ++++++
 2 files changed, 42 insertions(+)

-- 
2.11.0
