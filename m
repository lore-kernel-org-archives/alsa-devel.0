From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codec: wm9860: avoid
	maybe-uninitialized warning" to the asoc tree
Date: Sun, 30 Apr 2017 22:15:28 +0900
Message-ID: <E1d4ohE-00055i-Cr@finisterre>
References: <1493212192-7930-2-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A83266BC1
 for <alsa-devel@alsa-project.org>; Sun, 30 Apr 2017 15:15:41 +0200 (CEST)
In-Reply-To: <1493212192-7930-2-git-send-email-daniel.baluta@nxp.com>
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

   ASoC: codec: wm9860: avoid maybe-uninitialized warning

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

>From 66772eda0edbfbbbe7767a6b5d07e09dae84403d Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Wed, 26 Apr 2017 16:09:51 +0300
Subject: [PATCH] ASoC: codec: wm9860: avoid maybe-uninitialized warning

The new PLL configuration code triggers a harmless warning:

sound/soc/codecs/wm8960.c: In function 'wm8960_configure_clocking':
sound/soc/codecs/wm8960.c:735:3: error: 'best_freq_out' may be used
uninitialized in this function [-Werror=maybe-uninitialized]
   wm8960_set_pll(codec, freq_in, best_freq_out);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/wm8960.c:699:12: note: 'best_freq_out' was declared
here

Fix this by reworking the code such that:

1) When there is no PLL freq available return -EINVAL and make
sure *bclk_idx, *dac_idx, *sysclk_idx are initialized with
invalid values.

2) When there is a PLL freq available initialize *bclk_idx,
*dac_idx and *sysclk_idx with correct values and immediately
return the freq available.

Fixes: 84fdc00d519f ("ASoC: codec: wm9860: Refactor PLL out freq search")
Fixes: 303e8954af8d ("ASoC: codec: wm8960: Stop when a matching PLL freq is found")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ace69da97cb8..d899623fb101 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -686,7 +686,7 @@ int wm8960_configure_sysclk(struct wm8960_priv *wm8960, int mclk,
  * @bclk_idx: bclk_divs index for found bclk
  *
  * Returns:
- *  -1, in case no PLL frequency out available was found
+ * < 0, in case no PLL frequency out available was found
  * >=0, in case we could derive bclk, lrclk, sysclk from PLL out using
  *      (@sysclk_idx, @dac_idx, @bclk_idx) dividers
  */
@@ -696,13 +696,13 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	int sysclk, bclk, lrclk, freq_out;
-	int diff, best_freq_out;
+	int diff;
 	int i, j, k;
 
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
 
-	*bclk_idx = -1;
+	*sysclk_idx = *dac_idx = *bclk_idx = -1;
 
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
 		if (sysclk_divs[i] == -1)
@@ -720,21 +720,12 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 					*sysclk_idx = i;
 					*dac_idx = j;
 					*bclk_idx = k;
-					best_freq_out = freq_out;
-					break;
+					return freq_out;
 				}
 			}
-			if (k != ARRAY_SIZE(bclk_divs))
-				break;
 		}
-		if (j != ARRAY_SIZE(dac_divs))
-			break;
 	}
-
-	if (*bclk_idx != -1)
-		wm8960_set_pll(codec, freq_in, best_freq_out);
-
-	return *bclk_idx;
+	return -EINVAL;
 }
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 {
@@ -783,11 +774,12 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 		}
 	}
 
-	ret = wm8960_configure_pll(codec, freq_in, &i, &j, &k);
-	if (ret < 0) {
+	freq_out = wm8960_configure_pll(codec, freq_in, &i, &j, &k);
+	if (freq_out < 0) {
 		dev_err(codec->dev, "failed to configure clock via PLL\n");
-		return -EINVAL;
+		return freq_out;
 	}
+	wm8960_set_pll(codec, freq_in, freq_out);
 
 configure_clock:
 	/* configure sysclk clock */
-- 
2.11.0
