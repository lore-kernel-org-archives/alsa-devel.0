From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2 05/16] ASoC: fsl_ssi: Clear FIFO directly in
	fsl_ssi_config()
Date: Wed, 10 Jan 2018 22:43:04 -0800
Message-ID: <1515652995-15996-6-git-send-email-nicoleotsuka@gmail.com>
References: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 3404B266E70
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 07:44:10 +0100 (CET)
Received: by mail-pf0-f195.google.com with SMTP id e76so873495pfk.1
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 22:44:09 -0800 (PST)
In-Reply-To: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

The FIFO clear helper function is just one line of code now.
So it could be cleaned up by removing it and calling regmap
directly.

Meanwhile, FIFO clear could be applied to all use cases, not
confined to AC97. So this patch also moves FIFO clear in the
trigger() to fsl_ssi_config() and removes the AC97 check.

Note that SOR register is safe from offline_config HW limit.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
---
 sound/soc/fsl/fsl_ssi.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index f026386..263c067 100644
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
@@ -442,7 +431,8 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 			   struct fsl_ssi_regvals *vals)
 {
-	bool dir = (&ssi->regvals[TX] == vals) ? TX : RX;
+	bool tx = &ssi->regvals[TX] == vals;
+	bool dir = tx ? TX : RX;
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_regvals *avals;
 	bool aactive;
@@ -484,7 +474,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 
 	/* Online configure single direction while SSI is running */
 	if (enable) {
-		fsl_ssi_fifo_clear(ssi, vals->scr & SSI_SCR_RE);
+		/* Clear FIFO to prevent dirty data or channel slipping */
+		regmap_update_bits(ssi->regs, REG_SSI_SOR,
+				   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 
 		regmap_update_bits(regs, REG_SSI_SRCR, vals->srcr, vals->srcr);
 		regmap_update_bits(regs, REG_SSI_STCR, vals->stcr, vals->stcr);
@@ -506,6 +498,10 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		regmap_update_bits(regs, REG_SSI_SRCR, srcr, 0);
 		regmap_update_bits(regs, REG_SSI_STCR, stcr, 0);
 		regmap_update_bits(regs, REG_SSI_SIER, sier, 0);
+
+		/* Clear FIFO to prevent dirty data or channel slipping */
+		regmap_update_bits(ssi->regs, REG_SSI_SOR,
+				   SSI_SOR_xX_CLR(tx), SSI_SOR_xX_CLR(tx));
 	}
 
 config_done:
@@ -1086,7 +1082,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi *ssi = snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	struct regmap *regs = ssi->regs;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -1111,14 +1106,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
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
