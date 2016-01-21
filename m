From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH] ASoC: mxs-saif: fix clk_prepare() without matching clk_unprepare()
Date: Thu, 21 Jan 2016 14:55:56 +0000
Message-ID: <1453388156-1901-1-git-send-email-mans@mansr.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The clk_prepare() call in hw_params() has no matching clk_unprepare(),
leaving the clk with an ever-increasing prepare count.  Moreover,
hw_params() can be called multiple times which would again leave us
with a runaway prepare count.  Fix this by moving the clk_prepare()
call to the startup() function and adding a shutdown() function with
a matching clk_unprepare() as these operations are already correctly
bracketed by soc-core.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 sound/soc/mxs/mxs-saif.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index c866ade28ad0..a6c7b8d87cd2 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -381,9 +381,19 @@ static int mxs_saif_startup(struct snd_pcm_substream *substream,
 	__raw_writel(BM_SAIF_CTRL_CLKGATE,
 		saif->base + SAIF_CTRL + MXS_CLR_ADDR);
 
+	clk_prepare(saif->clk);
+
 	return 0;
 }
 
+static void mxs_saif_shutdown(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *cpu_dai)
+{
+	struct mxs_saif *saif = snd_soc_dai_get_drvdata(cpu_dai);
+
+	clk_unprepare(saif->clk);
+}
+
 /*
  * Should only be called when port is inactive.
  * although can be called multiple times by upper layers.
@@ -424,8 +434,6 @@ static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	/* prepare clk in hw_param, enable in trigger */
-	clk_prepare(saif->clk);
 	if (saif != master_saif) {
 		/*
 		* Set an initial clock rate for the saif internal logic to work
@@ -611,6 +619,7 @@ static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cmd,
 
 static const struct snd_soc_dai_ops mxs_saif_dai_ops = {
 	.startup = mxs_saif_startup,
+	.shutdown = mxs_saif_shutdown,
 	.trigger = mxs_saif_trigger,
 	.prepare = mxs_saif_prepare,
 	.hw_params = mxs_saif_hw_params,
-- 
2.7.0
