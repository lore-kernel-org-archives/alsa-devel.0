From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: wm8962: Don't automatically enable
	and disable FLL
Date: Thu, 16 Feb 2012 22:30:08 -0800
Message-ID: <1329460209-30495-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7D1F4103A63
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 07:30:48 +0100 (CET)
In-Reply-To: <1329460209-30495-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensourc.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Only enable and disable the FLL when explicitly told to, supporting some
additional use cases and making the driver behaviour more standard.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |   72 ++++-----------------------------------------
 1 files changed, 6 insertions(+), 66 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index d2a68d6..a328b7b 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -1832,65 +1832,6 @@ SOC_SINGLE_TLV("SPKOUTR Mixer DACR Volume", WM8962_SPEAKER_MIXER_5,
 	       4, 1, 0, inmix_tlv),
 };
 
-static int sysclk_event(struct snd_soc_dapm_widget *w,
-			struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	struct wm8962_priv *wm8962 = snd_soc_codec_get_drvdata(codec);
-	unsigned long timeout;
-	int src;
-	int fll;
-
-	/* Ignore attempts to run the event during startup */
-	if (codec->dapm.bias_level == SND_SOC_BIAS_OFF)
-		return 0;
-
-	src = snd_soc_read(codec, WM8962_CLOCKING2) & WM8962_SYSCLK_SRC_MASK;
-
-	switch (src) {
-	case 0:      /* MCLK */
-		fll = 0;
-		break;
-	case 0x200:  /* FLL */
-		fll = 1;
-		break;
-	default:
-		dev_err(codec->dev, "Unknown SYSCLK source %x\n", src);
-		return -EINVAL;
-	}
-
-	switch (event) {
-	case SND_SOC_DAPM_PRE_PMU:
-		if (fll) {
-			try_wait_for_completion(&wm8962->fll_lock);
-
-			snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
-					    WM8962_FLL_ENA, WM8962_FLL_ENA);
-
-			timeout = msecs_to_jiffies(5);
-			timeout = wait_for_completion_timeout(&wm8962->fll_lock,
-							      timeout);
-
-			if (wm8962->irq && timeout == 0)
-				dev_err(codec->dev,
-					"Timed out starting FLL\n");
-		}
-		break;
-
-	case SND_SOC_DAPM_POST_PMD:
-		if (fll)
-			snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
-					    WM8962_FLL_ENA, 0);
-		break;
-
-	default:
-		BUG();
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int cp_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
@@ -2176,8 +2117,7 @@ SND_SOC_DAPM_INPUT("DMICDAT"),
 SND_SOC_DAPM_SUPPLY("MICBIAS", WM8962_PWR_MGMT_1, 1, 0, NULL, 0),
 
 SND_SOC_DAPM_SUPPLY("Class G", WM8962_CHARGE_PUMP_B, 0, 1, NULL, 0),
-SND_SOC_DAPM_SUPPLY("SYSCLK", WM8962_CLOCKING2, 5, 0, sysclk_event,
-		    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+SND_SOC_DAPM_SUPPLY("SYSCLK", WM8962_CLOCKING2, 5, 0, NULL, 0),
 SND_SOC_DAPM_SUPPLY("Charge Pump", WM8962_CHARGE_PUMP_1, 0, 0, cp_event,
 		    SND_SOC_DAPM_POST_PMU),
 SND_SOC_DAPM_SUPPLY("TOCLK", WM8962_ADDITIONAL_CONTROL_1, 0, 0, NULL, 0),
@@ -2888,8 +2828,7 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	struct _fll_div fll_div;
 	unsigned long timeout;
 	int ret;
-	int fll1 = snd_soc_read(codec, WM8962_FLL_CONTROL_1) & WM8962_FLL_ENA;
-	int sysclk = snd_soc_read(codec, WM8962_CLOCKING2) & WM8962_SYSCLK_ENA;
+	int fll1 = 0;
 
 	/* Any change? */
 	if (source == wm8962->fll_src && Fref == wm8962->fll_fref &&
@@ -2912,6 +2851,9 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 	if (ret != 0)
 		return ret;
 
+	/* Parameters good, disable so we can reprogram */
+	snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1, WM8962_FLL_ENA, 0);
+
 	switch (fll_id) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
@@ -2950,12 +2892,10 @@ static int wm8962_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	try_wait_for_completion(&wm8962->fll_lock);
 
-	if (sysclk)
-		fll1 |= WM8962_FLL_ENA;
 
 	snd_soc_update_bits(codec, WM8962_FLL_CONTROL_1,
 			    WM8962_FLL_FRAC | WM8962_FLL_REFCLK_SRC_MASK |
-			    WM8962_FLL_ENA, fll1);
+			    WM8962_FLL_ENA, fll1 | WM8962_FLL_ENA);
 
 	dev_dbg(codec->dev, "FLL configured for %dHz->%dHz\n", Fref, Fout);
 
-- 
1.7.9.rc1
