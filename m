From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 1/2] ASoC: codec: wm9860: avoid
	maybe-uninitialized warning
Date: Wed, 26 Apr 2017 16:09:51 +0300
Message-ID: <1493212192-7930-2-git-send-email-daniel.baluta@nxp.com>
References: <1493212192-7930-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0065.outbound.protection.outlook.com [104.47.36.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 38E982673CC
 for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2017 15:10:08 +0200 (CEST)
In-Reply-To: <1493212192-7930-1-git-send-email-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.com, ckeepax@opensource.wolfsonmicro.com, arnd@arndb.de, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Daniel Baluta <daniel.baluta@nxp.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

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
---
Changes since v1:
	* use return instead of break
	* update commit message

 sound/soc/codecs/wm8960.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ace69da..d899623 100644
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
2.7.4
