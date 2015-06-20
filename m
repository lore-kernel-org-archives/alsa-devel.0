From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: fsl_spdif: Check for
	clk_prepare_enable() error
Date: Sat, 20 Jun 2015 18:18:06 -0300
Message-ID: <1434835086-27176-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f46.google.com (mail-qg0-f46.google.com
 [209.85.192.46])
 by alsa0.perex.cz (Postfix) with ESMTP id EB12B260526
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 23:18:27 +0200 (CEST)
Received: by qgal13 with SMTP id l13so44878646qga.3
 for <alsa-devel@alsa-project.org>; Sat, 20 Jun 2015 14:18:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so we should better check its return value
and propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 8e93221..489fa86 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -482,13 +482,18 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 		mask = SCR_TXFIFO_AUTOSYNC_MASK | SCR_TXFIFO_CTRL_MASK |
 			SCR_TXSEL_MASK | SCR_USRC_SEL_MASK |
 			SCR_TXFIFO_FSEL_MASK;
-		for (i = 0; i < SPDIF_TXRATE_MAX; i++)
-			clk_prepare_enable(spdif_priv->txclk[i]);
+		for (i = 0; i < SPDIF_TXRATE_MAX; i++) {
+			ret = clk_prepare_enable(spdif_priv->txclk[i]);
+			if (ret)
+				goto disable_txclk;
+		}
 	} else {
 		scr = SCR_RXFIFO_FSEL_IF8 | SCR_RXFIFO_AUTOSYNC;
 		mask = SCR_RXFIFO_FSEL_MASK | SCR_RXFIFO_AUTOSYNC_MASK|
 			SCR_RXFIFO_CTL_MASK | SCR_RXFIFO_OFF_MASK;
-		clk_prepare_enable(spdif_priv->rxclk);
+		ret = clk_prepare_enable(spdif_priv->rxclk);
+		if (ret)
+			goto err;
 	}
 	regmap_update_bits(regmap, REG_SPDIF_SCR, mask, scr);
 
@@ -497,6 +502,9 @@ static int fsl_spdif_startup(struct snd_pcm_substream *substream,
 
 	return 0;
 
+disable_txclk:
+	for (i--; i >= 0; i--)
+		clk_disable_unprepare(spdif_priv->txclk[i]);
 err:
 	clk_disable_unprepare(spdif_priv->coreclk);
 
-- 
1.9.1
