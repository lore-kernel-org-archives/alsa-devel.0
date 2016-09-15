From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: rt5663: refine error handling
Date: Thu, 15 Sep 2016 17:42:21 +0200
Message-ID: <20160915154238.3004097-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, Jack Yu <jack.yu@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The newly added rt5663 codec driver introduces a couple of warnings
when built with -Wmaybe-uninitialized:

codecs/rt5663.c: In function 'rt5663_set_tdm_slot':
codecs/rt5663.c:2680:2: error: 'reg' may be used uninitialized in this function [-Werror=maybe-uninitialized]
codecs/rt5663.c: In function 'rt5663_set_dai_pll':
codecs/rt5663.c:2556:12: error: 'shift' may be used uninitialized in this function [-Werror=maybe-uninitialized]
codecs/rt5663.c:2596:2: error: 'mask' may be used uninitialized in this function [-Werror=maybe-uninitialized]

We can avoid those warnings by always returning an error
from the switch() statements instead of falling through
with an uninitialized variable when we hit an unexpected
case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: df7c52168ee1 ("ASoC: add rt5663 codec driver")
---
 sound/soc/codecs/rt5663.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 7963a2736a91..8078abcaf728 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1831,6 +1831,7 @@ static int rt5663_i2s_use_asrc(struct snd_soc_dapm_widget *source,
 		break;
 	default:
 		dev_err(codec->dev, "Unknown CODEC_TYPE\n");
+		return 1;
 	}
 
 	if (da_asrc_en || ad_asrc_en)
@@ -2579,6 +2580,7 @@ static int rt5663_set_dai_pll(struct snd_soc_dai *dai, int pll_id, int source,
 		break;
 	default:
 		dev_err(codec->dev, "Unknown CODEC_TYPE\n");
+		return -EINVAL;
 	}
 
 	switch (source) {
@@ -2674,6 +2676,7 @@ static int rt5663_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		break;
 	default:
 		dev_err(codec->dev, "Unknown CODEC_TYPE\n");
+		return -EINVAL;
 	}
 
 	snd_soc_update_bits(codec, reg, RT5668_TDM_MODE_MASK |
-- 
2.9.0
