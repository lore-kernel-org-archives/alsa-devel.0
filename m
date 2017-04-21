From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 1/2] ASoC: codec: wm9860: avoid
	maybe-uninitialized warning
Date: Fri, 21 Apr 2017 16:07:34 +0300
Message-ID: <1492780055-4892-2-git-send-email-daniel.baluta@nxp.com>
References: <1492780055-4892-1-git-send-email-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0063.outbound.protection.outlook.com [104.47.34.63])
 by alsa0.perex.cz (Postfix) with ESMTP id 3ADCE266F00
 for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2017 15:07:47 +0200 (CEST)
In-Reply-To: <1492780055-4892-1-git-send-email-daniel.baluta@nxp.com>
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

Fixes: 84fdc00d519f ("ASoC: codec: wm9860: Refactor PLL out freq search")
Fixes: 303e8954af8d ("ASoC: codec: wm8960: Stop when a matching PLL freq is found")
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Arnd,

I agree that your code was more both humans and gcc anyhow
for consistency with wm8960_configure_sysclk function I preferred
to keep the "if(..) break" statements.

 sound/soc/codecs/wm8960.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index ace69da..8c87153 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -702,7 +702,7 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 	bclk = wm8960->bclk;
 	lrclk = wm8960->lrclk;
 
-	*bclk_idx = -1;
+	best_freq_out = -EINVAL;
 
 	for (i = 0; i < ARRAY_SIZE(sysclk_divs); ++i) {
 		if (sysclk_divs[i] == -1)
@@ -731,10 +731,7 @@ int wm8960_configure_pll(struct snd_soc_codec *codec, int freq_in,
 			break;
 	}
 
-	if (*bclk_idx != -1)
-		wm8960_set_pll(codec, freq_in, best_freq_out);
-
-	return *bclk_idx;
+	return best_freq_out;
 }
 static int wm8960_configure_clocking(struct snd_soc_codec *codec)
 {
@@ -783,11 +780,12 @@ static int wm8960_configure_clocking(struct snd_soc_codec *codec)
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
