From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [RFC PATCH 2/2] ASoC: codec: wm8960: Relax bit clock
	computation
Date: Wed, 15 Mar 2017 17:33:06 +0200
Message-ID: <1489591986-6302-3-git-send-email-daniel.baluta@nxp.com>
References: <1489591986-6302-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10040.outbound.protection.outlook.com [40.107.1.40])
 by alsa0.perex.cz (Postfix) with ESMTP id B8348267002
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 16:33:23 +0100 (CET)
In-Reply-To: <1489591986-6302-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
Cc: shengjiu.wang@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, ckeepax@opensource.wolfsonmicro.com
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
 sound/soc/codecs/wm8960.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index cb2ff2d..1669b45 100644
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
  * @_i: sysclk_divs index for found sysclk
@@ -620,14 +624,14 @@ static const int bclk_divs[] = {
  * Returns:
  * -1, in case no sysclk frequency available found
  *  0, in case an exact match is found. See @_i, @_j, @_k
- *
+ * >0, in case a relaxed match is found. See @_i, @_j, @_k
  */
 int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 		      int *_i, int *_j, int *_k)
 {
 	int sysclk, bclk, lrclk;
 	int i, j, k;
-	int diff;
+	int diff, closest = mclk;
 
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
@@ -648,6 +652,12 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 					*_k = k;
 					break;
 				}
+				if (diff > 0 && closest > diff) {
+					*_i = i;
+					*_j = j;
+					*_k = k;
+					closest = diff;
+				}
 			}
 			if (k != ARRAY_SIZE(bclk_divs))
 				break;
@@ -656,10 +666,16 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 			break;
 	}
 
+	/* exact match */
 	if (i != ARRAY_SIZE(sysclk_divs))
 		return 0;
 
-	return -1;
+	/* no match */
+	if (closest == mclk)
+		return -1;
+
+	/* relaxed match */
+	return 1;
 }
 
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
@@ -668,6 +684,7 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 	int sysclk, bclk, lrclk, freq_out, freq_in;
 	u16 iface1 = snd_soc_read(codec, WM8960_IFACE1);
 	int i, j, k;
+	int best_sysclk_div, best_dac_div, best_bclk_div = -1;
 	int ret;
 
 	if (!(iface1 & (1<<6))) {
@@ -705,10 +722,14 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 		ret = wm8960_configure_sysclk(wm8960, freq_out, &i, &j, &k);
 		if (ret == 0)
 			goto configure_clock;
-		else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
+		else if (ret < 0 && wm8960->clk_id != WM8960_SYSCLK_AUTO) {
 			dev_err(codec->dev, "failed to configure clock\n");
 			return -EINVAL;
 		}
+		/* there is still hope, keep this if no PLL out available */
+		best_sysclk_div	= i;
+		best_dac_div	= j;
+		best_bclk_div	= k;
 	}
 	/* get a available pll out frequency and set pll */
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
@@ -736,8 +757,14 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
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
