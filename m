From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/2] ASoC: codec: wm8960: Relax bit clock computation when using PLL
Date: Thu, 6 Apr 2017 14:51:54 +0300
Message-ID: <1491479514-24862-3-git-send-email-daniel.baluta@nxp.com>
References: <1491479514-24862-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1491479514-24862-1-git-send-email-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com, shengjiu.wang@nxp.com, viorel.suman@nxp.com, mihai.serban@nxp.com
List-Id: alsa-devel@alsa-project.org

Bitclk is derived from sysclk using bclk_divs.
Sysclk can be derived in two ways:
	(1) directly from MLCK
	(2) MCLK via PLL

Commit 3c01b9ee2ab9d0d ("ASoC: codec: wm8960: Relax bit clock
computation")
relaxed bitclk computation when sysclk is directly derived from MCLK.

Lets do the same thing when sysclk is derived via PLL.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8960.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ace69da..8ab9fa2 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -679,6 +679,10 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
  *		- freq_out    = sysclk * sysclk_divs
  *		- 10 * sysclk = bclk * bclk_divs
  *
+ *	If we cannot find an exact match for (sysclk, lrclk, bclk)
+ *	triplet, we relax the bclk such that bclk is chosen as the
+ *	closest available frequency greater than expected bclk.
+ *
  * @codec: codec structure
  * @freq_in: input frequency used to derive freq out via PLL
  * @sysclk_idx: sysclk_divs index for found sysclk
@@ -696,13 +700,14 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	int sysclk, bclk, lrclk, freq_out;
-	int diff, best_freq_out;
+	int diff, closest, best_freq_out = 0;
 	int i, j, k;
 
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
+	closest = freq_in;
 
-	*bclk_idx = -1;
+	*bclk_idx = *dac_idx = *sysclk_idx = -1;
 
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
 		if (sysclk_divs[i] == -1)
@@ -723,6 +728,13 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 					best_freq_out = freq_out;
 					break;
 				}
+				if (diff > 0 && closest > diff) {
+					*sysclk_idx = i;
+					*dac_idx = j;
+					*bclk_idx = k;
+					closest = diff;
+					best_freq_out = freq_out;
+				}
 			}
 			if (k != ARRAY_SIZE(bclk_divs))
 				break;
-- 
2.7.4
