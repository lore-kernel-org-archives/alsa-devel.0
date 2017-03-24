From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec: wm8960: Relax bit clock
	computation" to the asoc tree
Date: Fri, 24 Mar 2017 19:15:58 +0000
Message-ID: <E1crUgo-00060g-Dg@debutante>
References: <1490108605-20538-3-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AC3E26752B
 for <alsa-devel@alsa-project.org>; Fri, 24 Mar 2017 20:16:23 +0100 (CET)
In-Reply-To: <1490108605-20538-3-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: shengjiu.wang@freescale.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, tiwai@suse.com, broonie@kernel.org, viorel.suman@nxp.com, mihai.serban@nxp.com, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec: wm8960: Relax bit clock computation

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 3c01b9ee2ab9d0dffe837c12ed93740516a673d7 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Tue, 21 Mar 2017 17:03:25 +0200
Subject: [PATCH] ASoC: codec: wm8960: Relax bit clock computation

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
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 25a4a11929fe..ce159f13e7a4 100644
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
2.11.0
