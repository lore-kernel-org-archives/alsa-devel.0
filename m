From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v3 15/18] ASoC: fsl-ssi: Allow first stream to set the bitclock
Date: Mon, 14 Apr 2014 15:35:45 +0200
Message-ID: <1397482548-28463-16-git-send-email-mpa@pengutronix.de>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Sascha Hauer <s.hauer@pengutronix.de>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Allow to set the bitlcock exactly once when the ssi unit is
opened and do not touch the clock until both streams are closed
again. We should not unlock the bitclock in the stop trigger
since a trigger could be the result of an underrun and doesn't
mean the bitclock can be reconfigured again.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_ssi.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index e5fa626..e97e30f 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -495,9 +495,6 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 		snd_soc_dai_get_drvdata(rtd->cpu_dai);
 	int ret;
 
-	if (!dai->active && !fsl_ssi_is_ac97(ssi_private))
-		ssi_private->baudclk_locked = false;
-
 	if (fsl_ssi_is_i2s_master(ssi_private)) {
 		ret = clk_prepare_enable(ssi_private->baudclk);
 		if (ret)
@@ -525,6 +522,9 @@ static void fsl_ssi_shutdown(struct snd_pcm_substream *substream,
 
 	if (fsl_ssi_is_i2s_master(ssi_private))
 		clk_disable_unprepare(ssi_private->baudclk);
+
+	if (!dai->active)
+		ssi_private->baudclk_locked = 0;
 }
 
 /**
@@ -562,7 +562,11 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
 			continue;
 
 		tmprate = freq * factor * (i + 2);
-		clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
+
+		if (ssi_private->baudclk_locked)
+			clkrate = clk_get_rate(ssi_private->baudclk);
+		else
+			clkrate = clk_round_rate(ssi_private->baudclk, tmprate);
 
 		do_div(clkrate, factor);
 		afreq = (u32)clkrate / (i + 1);
@@ -912,11 +916,6 @@ static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd,
 			fsl_ssi_tx_config(ssi_private, false);
 		else
 			fsl_ssi_rx_config(ssi_private, false);
-
-		if (!fsl_ssi_is_ac97(ssi_private) && (read_ssi(&ssi->scr) &
-					(CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE)) == 0)
-			ssi_private->baudclk_locked = false;
-
 		break;
 
 	default:
@@ -1241,8 +1240,6 @@ static int fsl_ssi_probe(struct platform_device *pdev)
                 /* Older 8610 DTs didn't have the fifo-depth property */
 		ssi_private->fifo_depth = 8;
 
-	ssi_private->baudclk_locked = false;
-
 	dev_set_drvdata(&pdev->dev, ssi_private);
 
 	if (ssi_private->soc->imx) {
-- 
1.9.1
