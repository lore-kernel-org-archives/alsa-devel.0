From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: codec: wm9860: avoid maybe-uninitialized
	warning
Date: Wed, 19 Apr 2017 19:04:20 +0200
Message-ID: <20170419170449.2965453-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id D20A3266B23
 for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2017 19:04:51 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Daniel Baluta <daniel.baluta@nxp.com>
List-Id: alsa-devel@alsa-project.org

The new PLL configuration code triggers a harmless warning:

sound/soc/codecs/wm8960.c: In function 'wm8960_configure_clocking':
sound/soc/codecs/wm8960.c:735:3: error: 'best_freq_out' may be used uninitialized in this function [-Werror=maybe-uninitialized]
   wm8960_set_pll(codec, freq_in, best_freq_out);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
sound/soc/codecs/wm8960.c:699:12: note: 'best_freq_out' was declared here

I think the warning was introduced by Daniel's bugfix. I've come up
with a way to simplify the code in a way that is more readable to
both humans and to gcc, which gets us rid of the warning.

Fixes: 84fdc00d519f ("ASoC: codec: wm9860: Refactor PLL out freq search")
Fixes: 303e8954af8d ("ASoC: codec: wm8960: Stop when a matching PLL freq is found")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/wm8960.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ace69da97cb8..ba0f80504c6b 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -696,14 +696,12 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
 	int sysclk, bclk, lrclk, freq_out;
-	int diff, best_freq_out;
+	int diff;
 	int i, j, k;
 
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
 
-	*bclk_idx = -1;
-
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
 		if (sysclk_divs[i] == -1)
 			continue;
@@ -720,22 +718,14 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
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
+
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 {
 	struct wm8960_priv *wm8960 = snd_soc_codec_get_drvdata(codec);
@@ -783,11 +773,12 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
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
2.9.0
