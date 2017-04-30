From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec: wm8960: Relax bit clock
	computation when using PLL" to the asoc tree
Date: Sun, 30 Apr 2017 22:15:24 +0900
Message-ID: <E1d4ohA-00054i-Pg@finisterre>
References: <1493212192-7930-3-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 451A72664EB
 for <alsa-devel@alsa-project.org>; Sun, 30 Apr 2017 15:15:41 +0200 (CEST)
In-Reply-To: <1493212192-7930-3-git-send-email-daniel.baluta@nxp.com>
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
Cc: alsa-devel@alsa-project.org, arnd@arndb.de, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codec: wm8960: Relax bit clock computation when using PLL

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

>From 82bab88910ee358305a2f31ab30dad59f1b6421c Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 26 Apr 2017 16:09:52 +0300
Subject: [PATCH] ASoC: codec: wm8960: Relax bit clock computation when using
 PLL

Bitclk is derived from sysclk using bclk_divs.
Sysclk can be derived in two ways:
	(1) directly from MLCK
	(2) MCLK via PLL

Commit 3c01b9ee2ab9d0d ("ASoC: codec: wm8960: Relax bit clock
computation")
relaxed bitclk computation when sysclk is directly derived from MCLK.

Lets do the same thing when sysclk is derived via PLL.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index d899623fb101..9ed455700954 100644
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
@@ -696,12 +700,14 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	int sysclk, bclk, lrclk, freq_out;
-	int diff;
+	int diff, closest, best_freq_out;
 	int i, j, k;
 
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
+	closest = freq_in;
 
+	best_freq_out = -EINVAL;
 	*sysclk_idx = *dac_idx = *bclk_idx = -1;
 
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
@@ -722,10 +728,18 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 					*bclk_idx = k;
 					return freq_out;
 				}
+				if (diff > 0 && closest > diff) {
+					*sysclk_idx = i;
+					*dac_idx = j;
+					*bclk_idx = k;
+					closest = diff;
+					best_freq_out = freq_out;
+				}
 			}
 		}
 	}
-	return -EINVAL;
+
+	return best_freq_out;
 }
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 {
-- 
2.11.0
