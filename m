From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v5 4/8] ASoC: fsl-ssi: remove unnecessary spinlock
Date: Tue, 27 May 2014 10:24:21 +0200
Message-ID: <1401179065-31195-5-git-send-email-mpa@pengutronix.de>
References: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401179065-31195-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, Markus Pargmann <mpa@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Sascha Hauer <s.hauer@pengutronix.de>

The baudclock_locked variable is only used in functions which
are serialized anyway from the core. No need to have a lock
around the variable, so remove it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Tested-By: Michael Grzeschik <mgr@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 930095b..b3033d9 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -163,7 +163,6 @@ struct fsl_ssi_private {
 	bool baudclk_locked;
 	bool use_dual_fifo;
 	u8 i2s_mode;
-	spinlock_t baudclk_lock;
 	struct clk *baudclk;
 	struct clk *clk;
 	unsigned int bitclk_freq;
@@ -495,13 +494,9 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private =
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
-	unsigned long flags;
 
-	if (!dai->active && !fsl_ssi_is_ac97(ssi_private)) {
-		spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
+	if (!dai->active && !fsl_ssi_is_ac97(ssi_private))
 		ssi_private->baudclk_locked = false;
-		spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
-	}
 
 	/* When using dual fifo mode, it is safer to ensure an even period
 	 * size. If appearing to an odd number while DMA always starts its
@@ -532,7 +527,7 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
 	int synchronous = ssi_private->cpu_dai_drv.symmetric_rates, ret;
 	u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
-	unsigned long flags, clkrate, baudrate, tmprate;
+	unsigned long clkrate, baudrate, tmprate;
 	u64 sub, savesub = 100000;
 	unsigned int freq;
 
@@ -603,18 +598,14 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 	else
 		write_ssi_mask(&ssi->srccr, mask, stccr);
 
-	spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
 	if (!ssi_private->baudclk_locked) {
 		ret = clk_set_rate(ssi_private->baudclk, baudrate);
 		if (ret) {
-			spin_unlock_irqrestore(&ssi_private->baudclk_lock,
-					flags);
 			dev_err(cpu_dai->dev, "failed to set baudclk rate\n");
 			return -EINVAL;
 		}
 		ssi_private->baudclk_locked = true;
 	}
-	spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
 
 	return 0;
 }
@@ -899,7 +890,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
-	unsigned long flags;
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -920,11 +910,9 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			fsl_ssi_rx_config(ssi_private, false);
 
 		if (!fsl_ssi_is_ac97(ssi_private) && (read_ssi(&ssi->scr) &
-					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0) {
-			spin_lock_irqsave(&ssi_private->baudclk_lock, flags);
+					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
 			ssi_private->baudclk_locked = false;
-			spin_unlock_irqrestore(&ssi_private->baudclk_lock, flags);
-		}
+
 		break;
 
 	default:
@@ -1257,7 +1245,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
 		ssi_private->fifo_depth = 8;
 
 	ssi_private->baudclk_locked = false;
-	spin_lock_init(&ssi_private->baudclk_lock);
 
 	dev_set_drvdata(&pdev->dev, ssi_private);
 
-- 
2.0.0.rc2
