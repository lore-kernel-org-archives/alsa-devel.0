From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 2/2] ASoC: codec: wm8960: Relax bit clock computation
Date: Tue, 21 Mar 2017 12:09:36 +0200
Message-ID: <1490090976-25877-3-git-send-email-daniel.baluta@nxp.com>
References: <1490090976-25877-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490090976-25877-1-git-send-email-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
Cc: ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, shengjiu.wang@freescale.com, mihai.serban@nxp.com, viorel.suman@nxp.com
List-Id: alsa-devel@alsa-project.org

WM8960 derives bit clock from sysclock using BCLKDIV[3:0] of R8
clocking register (See WM8960 datasheet, page 71).

There are use cases, like this:
aplay -Dhw:0,0 -r 48000 -c 1 -f S20_3LE -t raw audio48k20b_3LE1c.pcm

where no BCLKDIV applied to sysclock can give us the exact requested
bitclk, so driver fails to configure clocking and aplay fails to run.

Fix this by relaxing bitclk computation, so that when no exact value
can be derived from sysclk pick the closest value greater than
expected bitclk.

Suggested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
	* use a marker to check if a match is found
	* didn't removed PLL as Charles suggested because there is
	a special PLL mode which explictly uses PLL. We could start
	a discussion on not using PLL when deriving bitclk, but this
	is to be done in another patch.

 sound/soc/codecs/wm8960.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 25a4a11..ce4fcd0 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -611,6 +611,10 @@ static const int bclk_divs[] = {
  *		- lrclk      = sysclk / dac_divs
  *		- 10 * bclk  = sysclk / bclk_divs
  *
+ *	If we cannot find an exact match for (sysclk, lrclk, bclk)
+ *	triplet, we relax the bclk such that bclk is chosen as the
+ *	closest available frequency greater than expected bclk.
+ *
  * @wm8960_priv: wm8960 codec private data
  * @mclk: MCLK used to derive sysclk
  * @sysclk_idx: sysclk_divs index for found sysclk
@@ -620,6 +624,7 @@ static const int bclk_divs[] = {
  * Returns:
  * -1, in case no sysclk frequency available found
  *  0, in case an exact (@sysclk_idx, @dac_idx, @bclk_idx) match is found
+ * >0, in case a relaxed (@sysclk_idx, @dac_idx, @bclk_idx) match is found
  */
 static
 int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
@@ -627,7 +632,10 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 {
 	int sysclk, bclk, lrclk;
 	int i, j, k;
-	int diff;
+	int diff, closest = mclk;
+
+	/* marker for no match */
+	*bclk_idx = -1;
 
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
@@ -648,6 +656,12 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 					*bclk_idx = k;
 					break;
 				}
+				if (diff > 0 && closest > diff) {
+					*sysclk_idx = i;
+					*dac_idx = j;
+					*bclk_idx = k;
+					closest = diff;
+				}
 			}
 			if (k != ARRAY_SIZE(bclk_divs))
 				break;
@@ -656,10 +670,16 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 			break;
 	}
 
+	/* exact match */
 	if (i != ARRAY_SIZE(sysclk_divs))
 		return 0;
 
-	return -1;
+	/* no match */
+	if (*bclk_idx == -1)
+		return -1;
+
+	/* relaxed match */
+	return 1;
 }
 
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
@@ -668,6 +688,7 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 	int sysclk, bclk, lrclk, freq_out, freq_in;
 	u16 iface1 = snd_soc_read(codec, WM8960_IFACE1);
 	int i, j, k;
+	int best_sysclk_div, best_dac_div, best_bclk_div = -1;
 	int ret;
 
 	if (!(iface1 & (1<<6))) {
@@ -705,10 +726,16 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 		ret = wm8960_configure_sysclk(wm8960, freq_out, &i, &j, &k);
 		if (ret == 0) {
 			goto configure_clock;
-		} else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
+		} else if (ret < 0 && wm8960->clk_id != WM8960_SYSCLK_AUTO) {
 			dev_err(codec->dev, "failed to configure clock\n");
 			return -EINVAL;
 		}
+		/* there is still hope, keep this in case no PLL out avail */
+		if (ret > 0) {
+			best_sysclk_div = i;
+			best_dac_div	= j;
+			best_bclk_div	= k;
+		}
 	}
 	/* get a available pll out frequency and set pll */
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
@@ -736,8 +763,14 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 	}
 
 	if (i == ARRAY_SIZE(sysclk_divs)) {
-		dev_err(codec->dev, "failed to configure clock\n");
-		return -EINVAL;
+		if (best_bclk_div != -1) {
+			i = best_sysclk_div;
+			j = best_dac_div;
+			k = best_bclk_div;
+		} else {
+			dev_err(codec->dev, "failed to configure clock\n");
+			return -EINVAL;
+		}
 	}
 
 configure_clock:
-- 
2.7.4
