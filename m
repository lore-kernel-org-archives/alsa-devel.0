From: Alexander Sverdlin <subaparts@yandex.ru>
Subject: [PATCH] ASoC: Improve EP93xx I2S clocks management.
Date: Sat, 05 Mar 2011 03:57:15 +0300
Message-ID: <1299286635.27359.106.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from forward7.mail.yandex.net (forward7.mail.yandex.net
	[77.88.61.37]) by alsa0.perex.cz (Postfix) with ESMTP id 764D524372
	for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2011 01:57:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Ryan Mallon <ryan@bluewatersys.com>
List-Id: alsa-devel@alsa-project.org

From: Alexander Sverdlin <subaparts@yandex.ru>

Improve EP93xx I2S clocks management.
Some freqs values are set not exact as they requested for MCLK and
original code was not able to find divisors for SCLK and LRCLK.
This code just picks up nearest value from 3 possible variants.
This patch makes 44100 and 192000 rates working and fixes
capture function.

Signed-off-by: Alexander Sverdlin <subaparts@yandex.ru>
---
 sound/soc/ep93xx/ep93xx-i2s.c |   19 +++++++++----------
 1 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/sound/soc/ep93xx/ep93xx-i2s.c b/sound/soc/ep93xx/ep93xx-i2s.c
index 0458dd4..3d4c086 100644
--- a/sound/soc/ep93xx/ep93xx-i2s.c
+++ b/sound/soc/ep93xx/ep93xx-i2s.c
@@ -242,7 +242,7 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct ep93xx_i2s_info *info = snd_soc_dai_get_drvdata(dai);
 	unsigned word_len, div, sdiv, lrdiv;
-	int found = 0, err;
+	int err;
 
 	switch (params_format(params)) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -275,15 +275,14 @@ static int ep93xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	 * the codec uses.
 	 */
 	div = clk_get_rate(info->mclk) / params_rate(params);
-	for (sdiv = 2; sdiv <= 4; sdiv += 2)
-		for (lrdiv = 64; lrdiv <= 128; lrdiv <<= 1)
-			if (sdiv * lrdiv == div) {
-				found = 1;
-				goto out;
-			}
-out:
-	if (!found)
-		return -EINVAL;
+	sdiv = 4;
+	if (div > (256 + 512) / 2) {
+		lrdiv = 128;
+	} else {
+		lrdiv = 64;
+		if (div < (128 + 256) / 2)
+			sdiv = 2;
+	}
 
 	err = clk_set_rate(info->sclk, clk_get_rate(info->mclk) / sdiv);
 	if (err)
