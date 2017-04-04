From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] ASoC: codec: wm9860: Refactor PLL out freq search
Date: Tue, 4 Apr 2017 19:45:13 +0300
Message-ID: <1491324314-27067-2-git-send-email-daniel.baluta@nxp.com>
References: <1491324314-27067-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491324314-27067-1-git-send-email-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, shengjiu.wang@nxp.com, viorel.suman@nxp.com, mihai.serban@nxp.com
List-Id: alsa-devel@alsa-project.org

Add a separate function for deriving (sysclk, lrclk, bclk)
when the clock is auto or pll.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/codecs/wm8960.c | 93 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ce159f1..36c8454 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -672,10 +672,70 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 	return *bclk_idx;
 }
 
+/**
+ * wm8960_configure_pll - checks if there is a PLL out frequency available
+ *	The PLL out frequency must be chosen such that:
+ *		- sysclk      = lrclk * dac_divs
+ *		- freq_out    = sysclk * sysclk_divs
+ *		- 10 * sysclk = bclk * bclk_divs
+ *
+ * @codec: codec structure
+ * @freq_in: input frequency used to derive freq out via PLL
+ * @sysclk_idx: sysclk_divs index for found sysclk
+ * @dac_idx: dac_divs index for found lrclk
+ * @bclk_idx: bclk_divs index for found bclk
+ *
+ * Returns:
+ *  -1, in case no PLL frequency out available was found
+ * >=0, in case we could derive bclk, lrclk, sysclk from PLL out using
+ *      (@sysclk_idx, @dac_idx, @bclk_idx) dividers
+ */
+static
+int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
+			 int *sysclk_idx, int *dac_idx, int *bclk_idx)
+{
+	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
+	int sysclk, bclk, lrclk, freq_out;
+	int diff, best_freq_out;
+	int i, j, k;
+
+	bclk = wm8960->bclk;
+	lrclk = wm8960->lrclk;
+
+	*bclk_idx = -1;
+
+	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
+		if (sysclk_divs[i] == -1)
+			continue;
+		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
+			sysclk = lrclk * dac_divs[j];
+			freq_out = sysclk * sysclk_divs[i];
+
+			for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k) {
+				if (!is_pll_freq_available(freq_in, freq_out))
+					continue;
+
+				diff = sysclk - bclk * bclk_divs[k] / 10;
+				if (diff == 0) {
+					*sysclk_idx = i;
+					*dac_idx = j;
+					*bclk_idx = k;
+					best_freq_out = freq_out;
+					break;
+				}
+			}
+		}
+	}
+
+	if (*bclk_idx != -1)
+		wm8960_set_pll(codec, freq_in, best_freq_out);
+
+	return *bclk_idx;
+}
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
-	int sysclk, bclk, lrclk, freq_out, freq_in;
+	int freq_out, freq_in;
 	u16 iface1 = snd_soc_read(codec, WM8960_IFACE1);
 	int i, j, k;
 	int ret;
@@ -692,8 +752,6 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 	}
 
 	freq_in = wm8960->freq_in;
-	bclk = wm8960->bclk;
-	lrclk = wm8960->lrclk;
 	/*
 	 * If it's sysclk auto mode, check if the MCLK can provide sysclk or
 	 * not. If MCLK can provide sysclk, using MCLK to provide sysclk
@@ -720,33 +778,10 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 			return -EINVAL;
 		}
 	}
-	/* get a available pll out frequency and set pll */
-	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
-		if (sysclk_divs[i] == -1)
-			continue;
-		for (j = 0; j < ARRAY_SIZE(dac_divs); ++j) {
-			sysclk = lrclk * dac_divs[j];
-			freq_out = sysclk * sysclk_divs[i];
-
-			for (k = 0; k < ARRAY_SIZE(bclk_divs); ++k) {
-				if (sysclk == bclk * bclk_divs[k] / 10 &&
-				    is_pll_freq_available(freq_in, freq_out)) {
-					wm8960_set_pll(codec,
-						       freq_in, freq_out);
-					break;
-				} else {
-					continue;
-				}
-			}
-			if (k != ARRAY_SIZE(bclk_divs))
-				break;
-		}
-		if (j != ARRAY_SIZE(dac_divs))
-			break;
-	}
 
-	if (i == ARRAY_SIZE(sysclk_divs)) {
-		dev_err(codec->dev, "failed to configure clock\n");
+	ret = wm8960_configure_pll(codec, freq_in, &i, &j, &k);
+	if (ret < 0) {
+		dev_err(codec->dev, "failed to configure clock via PLL\n");
 		return -EINVAL;
 	}
 
-- 
2.7.4
