From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 1/5] ASoC: fsl_spdif: Use clk_set_rate() for
	spdif root clock only
Date: Wed, 30 Apr 2014 18:54:05 +0800
Message-ID: <05eb492d162ee6173f813dbc6cfda6551de70108.1398853588.git.Guangyu.Chen@freescale.com>
References: <cover.1398853588.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A52326072A
 for <alsa-devel@alsa-project.org>; Wed, 30 Apr 2014 12:52:27 +0200 (CEST)
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

The clock mux for the Freescale S/PDIF controller has eight clock sources
while most of them are from other moudles and even system clocks that do
not allow a rate-changing operation.

So we here only allow the clk_set_rate() and clk_round_rate() happened to
spdif root clock, the private clock for S/PDIF controller.

Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>
---
 sound/soc/fsl/fsl_spdif.c | 15 ++++++++++++---
 sound/soc/fsl/fsl_spdif.h |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index e7be6b3..ed4bf75 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -384,6 +384,10 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* Don't mess up the clocks from other modules */
+	if (clk != STC_TXCLK_SPDIF_ROOT)
+		goto clk_set_bypass;
+
 	/*
 	 * The S/PDIF block needs a clock of 64 * fs * div.  The S/PDIF block
 	 * will divide by (div).  So request 64 * fs * (div+1) which will
@@ -395,6 +399,7 @@ static int spdif_set_sample_rate(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+clk_set_bypass:
 	dev_dbg(&pdev->dev, "expected clock rate = %d\n",
 			(64 * sample_rate * div));
 	dev_dbg(&pdev->dev, "actual clock rate = %ld\n",
@@ -1011,7 +1016,7 @@ static struct regmap_config fsl_spdif_regmap_config = {
 
 static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 				struct clk *clk, u64 savesub,
-				enum spdif_txrate index)
+				enum spdif_txrate index, bool round)
 {
 	const u32 rate[] = { 32000, 44100, 48000 };
 	u64 rate_ideal, rate_actual, sub;
@@ -1019,7 +1024,10 @@ static u32 fsl_spdif_txclk_caldiv(struct fsl_spdif_priv *spdif_priv,
 
 	for (div = 1; div <= 128; div++) {
 		rate_ideal = rate[index] * (div + 1) * 64;
-		rate_actual = clk_round_rate(clk, rate_ideal);
+		if (round)
+			rate_actual = clk_round_rate(clk, rate_ideal);
+		else
+			rate_actual = clk_get_rate(clk);
 
 		arate = rate_actual / 64;
 		arate /= div;
@@ -1072,7 +1080,8 @@ static int fsl_spdif_probe_txclk(struct fsl_spdif_priv *spdif_priv,
 		if (!clk_get_rate(clk))
 			continue;
 
-		ret = fsl_spdif_txclk_caldiv(spdif_priv, clk, savesub, index);
+		ret = fsl_spdif_txclk_caldiv(spdif_priv, clk, savesub, index,
+					     i == STC_TXCLK_SPDIF_ROOT);
 		if (savesub == ret)
 			continue;
 
diff --git a/sound/soc/fsl/fsl_spdif.h b/sound/soc/fsl/fsl_spdif.h
index 605a10b..4ec27fc 100644
--- a/sound/soc/fsl/fsl_spdif.h
+++ b/sound/soc/fsl/fsl_spdif.h
@@ -157,6 +157,8 @@ enum spdif_gainsel {
 #define STC_TXCLK_DIV(x)		((((x) - 1) << STC_TXCLK_DIV_OFFSET) & STC_TXCLK_DIV_MASK)
 #define STC_TXCLK_SRC_MAX		8
 
+#define STC_TXCLK_SPDIF_ROOT		1
+
 /* SPDIF tx rate */
 enum spdif_txrate {
 	SPDIF_TXRATE_32000 = 0,
-- 
1.8.4
