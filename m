From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 2/2] ASoC: codec: wm8960: Relax bit clock
	computation
Date: Tue, 21 Mar 2017 17:03:25 +0200
Message-ID: <1490108605-20538-3-git-send-email-daniel.baluta@nxp.com>
References: <1490108605-20538-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-eopbgr10087.outbound.protection.outlook.com [40.107.1.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 54F62267176
 for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2017 16:03:41 +0100 (CET)
In-Reply-To: <1490108605-20538-1-git-send-email-daniel.baluta@nxp.com>
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
Changes since v2:
	* do not differentiate between relaxed and exact match

 sound/soc/codecs/wm8960.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 25a4a11..ce159f1 100644
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
@@ -618,8 +622,9 @@ static const int bclk_divs[] = {
  * @bclk_idx: bclk_divs index for found bclk
  *
  * Returns:
- * -1, in case no sysclk frequency available found
- *  0, in case an exact (@sysclk_idx, @dac_idx, @bclk_idx) match is found
+ *  -1, in case no sysclk frequency available found
+ * >=0, in case we could derive bclk and lrclk from sysclk using
+ *      (@sysclk_idx, @dac_idx, @bclk_idx) dividers
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
@@ -655,11 +669,7 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
 		if (j != ARRAY_SIZE(dac_divs))
 			break;
 	}
-
-	if (i != ARRAY_SIZE(sysclk_divs))
-		return 0;
-
-	return -1;
+	return *bclk_idx;
 }
 
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
@@ -703,7 +713,7 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 
 	if (wm8960->clk_id != WM8960_SYSCLK_PLL) {
 		ret = wm8960_configure_sysclk(wm8960, freq_out, &i, &j, &k);
-		if (ret == 0) {
+		if (ret >= 0) {
 			goto configure_clock;
 		} else if (wm8960->clk_id != WM8960_SYSCLK_AUTO) {
 			dev_err(codec->dev, "failed to configure clock\n");
-- 
2.7.4
