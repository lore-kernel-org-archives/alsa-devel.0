From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/4] ALSA: pcm: add support for 352.8KHz and 384KHz sample rate
Date: Thu, 22 Aug 2019 10:56:49 +0100
Message-ID: <20190822095653.7200-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, tiwai@suse.de
Cc: spapothi@codeaurora.org, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset adds missing support to 352.8KHz and 384KHz sample rates in
Qualcomm WCD9335 codec and QDSP dais.

First patch adds these new rates to known list of rates in pcm core and
also adds defines in pcm.h so that drivers can use it.

Changes since v1:
 - Added wcd and qdsp users of these new rates.

Srinivas Kandagatla (3):
  ASoC: wcd9335: Fix primary interpolator max rate
  ASoC: qdsp6: q6afe-dai: Update max rate for slim and tdm dais
  ASoC: qdsp6: q6asm-dai: fix max rates on q6asm dais

Vidyakumar Athota (1):
  ALSA: pcm: add support for 352.8KHz and 384KHz sample rate

 include/sound/pcm.h              |  5 ++
 sound/core/pcm_native.c          |  2 +-
 sound/soc/codecs/wcd9335.c       | 20 ++++---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 92 +++++++++++---------------------
 sound/soc/qcom/qdsp6/q6asm-dai.c | 18 +++----
 5 files changed, 59 insertions(+), 78 deletions(-)

-- 
2.21.0
