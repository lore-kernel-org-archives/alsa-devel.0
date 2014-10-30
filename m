From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 10/14] ASoC: wm9713: Cleanup printk usage
Date: Thu, 30 Oct 2014 21:01:07 +0100
Message-ID: <1414699271-22797-11-git-send-email-lars@metafoo.de>
References: <1414699271-22797-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-209.synserver.de (smtp-out-209.synserver.de
 [212.40.185.209])
 by alsa0.perex.cz (Postfix) with ESMTP id E792926536C
 for <alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 21:01:20 +0100 (CET)
In-Reply-To: <1414699271-22797-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Use dev_err()/dev_warn() instead of printk(KERN_ERR/KERN_WARNING. This is
common practice and makes it easy to find out which device generated the
message. While we are at it also align the error messages with the other
AC'97 drivers.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/wm9713.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index bddee30..38e17d4 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -689,7 +689,8 @@ struct _pll_div {
  * to allow rounding later */
 #define FIXED_PLL_SIZE ((1 << 22) * 10)
 
-static void pll_factors(struct _pll_div *pll_div, unsigned int source)
+static void pll_factors(struct snd_soc_codec *codec,
+	struct _pll_div *pll_div, unsigned int source)
 {
 	u64 Kpart;
 	unsigned int K, Ndiv, Nmod, target;
@@ -724,7 +725,7 @@ static void pll_factors(struct _pll_div *pll_div, unsigned int source)
 
 	Ndiv = target / source;
 	if ((Ndiv < 5) || (Ndiv > 12))
-		printk(KERN_WARNING
+		dev_warn(codec->dev,
 			"WM9713 PLL N value %u out of recommended range!\n",
 			Ndiv);
 
@@ -768,7 +769,7 @@ static int wm9713_set_pll(struct snd_soc_codec *codec,
 		return 0;
 	}
 
-	pll_factors(&pll_div, freq_in);
+	pll_factors(codec, &pll_div, freq_in);
 
 	if (pll_div.k == 0) {
 		reg = (pll_div.n << 12) | (pll_div.lf << 11) |
@@ -1104,8 +1105,11 @@ int wm9713_reset(struct snd_soc_codec *codec, int try_warm)
 	soc_ac97_ops->reset(codec->ac97);
 	if (soc_ac97_ops->warm_reset)
 		soc_ac97_ops->warm_reset(codec->ac97);
-	if (ac97_read(codec, 0) != wm9713_reg[0])
+	if (ac97_read(codec, 0) != wm9713_reg[0]) {
+		dev_err(codec->dev, "Failed to reset: AC97 link error\n");
 		return -EIO;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm9713_reset);
@@ -1163,10 +1167,8 @@ static int wm9713_soc_resume(struct snd_soc_codec *codec)
 	u16 *cache = codec->reg_cache;
 
 	ret = wm9713_reset(codec, 1);
-	if (ret < 0) {
-		printk(KERN_ERR "could not reset AC97 codec\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	wm9713_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
@@ -1205,10 +1207,8 @@ static int wm9713_soc_probe(struct snd_soc_codec *codec)
 	 * a warm reset followed by an optional cold reset for codec */
 	wm9713_reset(codec, 0);
 	ret = wm9713_reset(codec, 1);
-	if (ret < 0) {
-		printk(KERN_ERR "Failed to reset WM9713: AC97 link error\n");
+	if (ret < 0)
 		goto reset_err;
-	}
 
 	wm9713_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
 
-- 
1.8.0
