From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v1 04/15] ASoC: fsl_ssi: Clear FIFO directly in
	fsl_ssi_config()
Date: Tue, 19 Dec 2017 09:00:08 -0800
Message-ID: <1513702819-42310-5-git-send-email-nicoleotsuka@gmail.com>
References: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f68.google.com (mail-pl0-f68.google.com
 [209.85.160.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 33165266D09
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 18:01:11 +0100 (CET)
Received: by mail-pl0-f68.google.com with SMTP id z5so7324156plo.10
 for <alsa-devel@alsa-project.org>; Tue, 19 Dec 2017 09:01:11 -0800 (PST)
In-Reply-To: <1513702819-42310-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, broonie@kernel.org
Cc: mail@maciej.szmigiero.name, kernel@pengutronix.de, lgirdwood@gmail.com, alsa-devel@alsa-project.org, caleb@crome.org, linux-kernel@vger.kernel.org, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The FIFO clear helper function is just one line of code now.
So it could be cleaned up by removing it and calling regmap
directly.

Meanwhile, FIFO clear could be applied to all use cases, not
confined to AC97. So this patch also moves FIFO clear in the
trigger() to fsl_ssi_config() and removes the AC97 check.

Note that SOR register is safe from offline_config HW limit.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_ssi.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6dda2e0..0f09caf 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -406,17 +406,6 @@ static void fsl_ssi_rxtx_config(struct fsl_ssi *ssi, bool enable)
 }
 
 /**
- * Clear remaining data in the FIFO to avoid dirty data or channel slipping
- */
-static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
-{
-	bool tx = !is_rx;
-
-	regmap_update_bits(ssi->regs, REG_SSI_SOR,
-			   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
-}
-
-/**
  * Exclude bits that are used by the opposite stream
  *
  * When both streams are active, disabling some bits for the current stream
@@ -484,7 +473,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 
 	/* Online configure single direction while SSI is running */
 	if (enable) {
-		fsl_ssi_fifo_clear(ssi, vals->scr & SSI_SCR_RE);
+		/* Clear FIFO to prevent dirty data or channel slipping */
+		regmap_update_bits(ssi->regs, REG_SSI_SOR,
+				   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 
 		regmap_update_bits(regs, REG_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, REG_SSI_STCR, vals->stcr, vals->stcr);
@@ -506,6 +497,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		regmap_update_bits(regs, REG_SSI_SRCR, srcr, 0);
 		regmap_update_bits(regs, REG_SSI_STCR, stcr, 0);
 		regmap_update_bits(regs, REG_SSI_SIER, sier, 0);
+
+		/* Clear FIFO to prevent dirty data or channel slipping */
+		regmap_update_bits(ssi->regs, REG_SSI_SOR,
+				   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 	}
 
 config_done:
@@ -1086,7 +1081,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	struct regmap *regs = ssi->regs;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -1111,14 +1105,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 		return -EINVAL;
 	}
 
-	/* Clear corresponding FIFO */
-	if (fsl_ssi_is_ac97(ssi)) {
-		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			regmap_write(regs, REG_SSI_SOR, SSI_SOR_TX_CLR);
-		else
-			regmap_write(regs, REG_SSI_SOR, SSI_SOR_RX_CLR);
-	}
-
 	return 0;
 }
 
-- 
2.7.4
