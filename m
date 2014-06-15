From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: [PATCH 2/2] ASoC: fsl_spdif: Add support for output
	sample rates 96kHz and 192kHz
Date: Mon, 16 Jun 2014 02:56:42 +0300
Message-ID: <1402876602-2942-2-git-send-email-anssi.hannula@iki.fi>
References: <1402876602-2942-1-git-send-email-anssi.hannula@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail3.ippnet.fi (mail3.ippnet.fi [62.197.168.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 4058F2652DA
 for <alsa-devel@alsa-project.org>; Mon, 16 Jun 2014 01:57:11 +0200 (CEST)
In-Reply-To: <1402876602-2942-1-git-send-email-anssi.hannula@iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org

Add support for the output sample rates 96kHz and 192kHz.

Tested with a Cubox-i imx6 system and an Onkyo TX-SR607 receiver.

Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
---

Unless there was some special reason to not have this?

It seems to work at least.

 sound/soc/fsl/fsl_spdif.c | 14 +++++++++++---
 sound/soc/fsl/fsl_spdif.h |  8 ++++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index b912d45a2a4c..71f6a117f46e 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -96,7 +96,7 @@ struct fsl_spdif_priv {
 	struct platform_device *pdev;
 	struct regmap *regmap;
 	bool dpll_locked;
-	u16 txrate[SPDIF_TXRATE_MAX];
+	u32 txrate[SPDIF_TXRATE_MAX];
 	u8 txclk_df[SPDIF_TXRATE_MAX];
 	u8 sysclk_df[SPDIF_TXRATE_MAX];
 	u8 txclk_src[SPDIF_TXRATE_MAX];
@@ -390,6 +390,14 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 		rate = SPDIF_TXRATE_48000;
 		csfs = IEC958_AES3_CON_FS_48000;
 		break;
+	case 96000:
+		rate = SPDIF_TXRATE_96000;
+		csfs = IEC958_AES3_CON_FS_96000;
+		break;
+	case 192000:
+		rate = SPDIF_TXRATE_192000;
+		csfs = IEC958_AES3_CON_FS_192000;
+		break;
 	default:
 		dev_err(&pdev->dev, "unsupported sample rate %d\n", sample_rate);
 		return -EINVAL;
@@ -1046,7 +1054,7 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 				struct clk *clk, u64 savesub,
 				enum spdif_txrate index, bool round)
 {
-	const u32 rate[] = { 32000, 44100, 48000 };
+	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
 	bool is_sysclk = clk == spdif_priv->sysclk;
 	u64 rate_ideal, rate_actual, sub;
 	u32 sysclk_dfmin, sysclk_dfmax;
@@ -1105,7 +1113,7 @@ out:
 static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 				enum spdif_txrate index)
 {
-	const u32 rate[] = { 32000, 44100, 48000 };
+	const u32 rate[] = { 32000, 44100, 48000, 96000, 192000 };
 	struct platform_device *pdev = spdif_priv->pdev;
 	struct device *dev = &pdev->dev;
 	u64 savesub = 100000, ret;
diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index 16fde4b927d3..5f5a3c41db25 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -164,8 +164,10 @@ enum spdif_txrate {
 	SPDIF_TXRATE_32000 = 0,
 	SPDIF_TXRATE_44100,
 	SPDIF_TXRATE_48000,
+	SPDIF_TXRATE_96000,
+	SPDIF_TXRATE_192000,
 };
-#define SPDIF_TXRATE_MAX		(SPDIF_TXRATE_48000 + 1)
+#define SPDIF_TXRATE_MAX		(SPDIF_TXRATE_192000 + 1)
 
 
 #define SPDIF_CSTATUS_BYTE		6
@@ -175,7 +177,9 @@ enum spdif_txrate {
 
 #define FSL_SPDIF_RATES_PLAYBACK	(SNDRV_PCM_RATE_32000 |	\
 					 SNDRV_PCM_RATE_44100 |	\
-					 SNDRV_PCM_RATE_48000)
+					 SNDRV_PCM_RATE_48000 |	\
+					 SNDRV_PCM_RATE_96000 |	\
+					 SNDRV_PCM_RATE_192000)
 
 #define FSL_SPDIF_RATES_CAPTURE		(SNDRV_PCM_RATE_16000 | \
 					 SNDRV_PCM_RATE_32000 |	\
-- 
1.8.4.5
