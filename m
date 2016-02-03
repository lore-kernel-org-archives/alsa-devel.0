From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] ASoC: mxs-saif: check BUSY bit in hw_params() only if not mclk_in_use
Date: Wed,  3 Feb 2016 13:18:20 +0000
Message-ID: <1454505500-30384-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If something else, typically a codec, has enabled mclk, the BUSY
bit may be set when hw_params() is called without this being an
error.  This check thus causes intermittent failures to configure
the sound device when used in such a manner.  Fix this by making
the test conditional on !saif->mclk_in_use.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 sound/soc/mxs/mxs-saif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index a6c7b8d87cd2..13631003cb7c 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -418,7 +418,7 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	stat = __raw_readl(saif->base + SAIF_STAT);
-	if (stat & BM_SAIF_STAT_BUSY) {
+	if (!saif->mclk_in_use && (stat & BM_SAIF_STAT_BUSY)) {
 		dev_err(cpu_dai->dev, "error: busy\n");
 		return -EBUSY;
 	}
-- 
2.7.0
