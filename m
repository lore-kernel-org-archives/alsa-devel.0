From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/2] ASoC: codec: wm8960: Relax bit clock computation when using PLL
Date: Fri, 21 Apr 2017 16:07:35 +0300
Message-ID: <1492780055-4892-3-git-send-email-daniel.baluta@nxp.com>
References: <1492780055-4892-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492780055-4892-1-git-send-email-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, tiwai@suse.com, ckeepax@opensource.wolfsonmicro.com, arnd@arndb.de, lgirdwood@gmail.com
Cc: patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>
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
---
Here, I forced the following harmless initialization:

	*sysclk_idx = *dac_idx = *bclk_idx = -1;

otherwise I would trigger a gcc false positive warning:

sound/soc/codecs/wm8960.c: In function 'wm8960_configure_clocking':
sound/soc/codecs/wm8960.c:810:46: warning: 'j' may be used uninitialized
in this function [-Wmaybe-uninitialized]
  snd_soc_update_bits(codec, WM8960_CLOCK1, 0x7 << 6, j << 6);
                                            ~~^~~~
sound/soc/codecs/wm8960.c:806:44: warning: 'i' may be used uninitialized
in this function [-Wmaybe-uninitialized]
snd_soc_update_bits(codec, WM8960_CLOCK1, 3 << 1, i << 1);
                                          ~~^~~~




 sound/soc/codecs/wm8960.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 8c87153..60700d5 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -679,6 +679,10 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
  *		- freq_out    = sysclk * sysclk_divs
  *		- 10 * sysclk = bclk * bclk_divs
  *
+ * 	If we cannot find an exact match for (sysclk, lrclk, bclk)
+ * 	triplet, we relax the bclk such that bclk is chosen as the
+ * 	closest available frequency greater than expected bclk.
+ *
  * @codec: codec structure
  * @freq_in: input frequency used to derive freq out via PLL
  * @sysclk_idx: sysclk_divs index for found sysclk
@@ -696,13 +700,15 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	int sysclk, bclk, lrclk, freq_out;
-	int diff, best_freq_out;
+	int diff, closest, best_freq_out;
 	int i, j, k;
 
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
+	closest = freq_in;
 
 	best_freq_out = -EINVAL;
+	*sysclk_idx = *dac_idx = *bclk_idx = -1;
 
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
 		if (sysclk_divs[i] == -1)
@@ -723,6 +729,13 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
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
