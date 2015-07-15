From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH 1/2][linux-next] ASoC: Fix warning while make xmldocs caused by soc-core.c
Date: Wed, 15 Jul 2015 23:02:38 +0900
Message-ID: <1436968959-22488-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org
Cc: Masanari Iida <standby24x7@gmail.com>
List-Id: alsa-devel@alsa-project.org

This patch fix following warning while make xmldocs.
Warning(.//sound/soc/soc-core.c:2148): No description found
for parameter 'ratio'

Add missing ":"

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 8c8ce65..691fcc4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2140,7 +2140,7 @@ EXPORT_SYMBOL_GPL(snd_soc_codec_set_pll);
 /**
  * snd_soc_dai_set_bclk_ratio - configure BCLK to sample rate ratio.
  * @dai: DAI
- * @ratio Ratio of BCLK to Sample rate.
+ * @ratio: Ratio of BCLK to Sample rate.
  *
  * Configures the DAI for a preset BCLK to sample rate ratio.
  */
-- 
2.5.0.rc2.13.g961abca
