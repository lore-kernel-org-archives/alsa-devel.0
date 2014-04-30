From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 4/5] ASoC: fsl_spdif: Print actual sample rate
	for debug
Date: Wed, 30 Apr 2014 18:54:08 +0800
Message-ID: <862e22353c7cde177639b40f8a967f0bf9d94bb5.1398853588.git.Guangyu.Chen@freescale.com>
References: <cover.1398853588.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 by alsa0.perex.cz (Postfix) with ESMTP id C12E4261A0D
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 12:52:38 +0200 (CEST)
In-Reply-To: <cover.1398853588.git.Guangyu.Chen@freescale.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

People would simply know what the driver gets the best for the current
sample rate playback.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index 1abfb00..074b355 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -75,6 +75,7 @@ struct fsl_spdif_priv {
 	struct platform_device *pdev;
 	struct regmap *regmap;
 	bool dpll_locked;
+	u16 txrate[SPDIF_TXRATE_MAX];
 	u8 txclk_df[SPDIF_TXRATE_MAX];
 	u8 sysclk_df[SPDIF_TXRATE_MAX];
 	u8 txclk_src[SPDIF_TXRATE_MAX];
@@ -418,7 +419,8 @@ clk_set_bypass:
 	regmap_update_bits(regmap, REG_SPDIF_STC,
 			   STC_SYSCLK_DF_MASK, STC_SYSCLK_DF(sysclk_df));
 
-	dev_dbg(&pdev->dev, "set sample rate to %d\n", sample_rate);
+	dev_dbg(&pdev->dev, "set sample rate to %dHz for %dHz playback\n",
+			spdif_priv->txrate[rate], sample_rate);
 
 	return 0;
 }
@@ -1049,6 +1051,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 				savesub = 0;
 				spdif_priv->txclk_df[index] = txclk_df;
 				spdif_priv->sysclk_df[index] = sysclk_df;
+				spdif_priv->txrate[index] = arate;
 				goto out;
 			} else if (arate / rate[index] == 1) {
 				/* A little bigger than expect */
@@ -1059,6 +1062,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 				savesub = sub;
 				spdif_priv->txclk_df[index] = txclk_df;
 				spdif_priv->sysclk_df[index] = sysclk_df;
+				spdif_priv->txrate[index] = arate;
 			} else if (rate[index] / arate == 1) {
 				/* A little smaller than expect */
 				sub = (rate[index] - arate) * 100000;
@@ -1068,6 +1072,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 				savesub = sub;
 				spdif_priv->txclk_df[index] = txclk_df;
 				spdif_priv->sysclk_df[index] = sysclk_df;
+				spdif_priv->txrate[index] = arate;
 			}
 		}
 	}
@@ -1118,6 +1123,8 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 	if (spdif_priv->txclk[index] == spdif_priv->sysclk)
 		dev_dbg(&pdev->dev, "use sysclk df %d for %dHz sample rate\n",
 				spdif_priv->sysclk_df[index], rate[index]);
+	dev_dbg(&pdev->dev, "the best rate for %dHz sample rate is %dHz\n",
+			rate[index], spdif_priv->txrate[index]);
 
 	return 0;
 }
-- 
1.8.4
