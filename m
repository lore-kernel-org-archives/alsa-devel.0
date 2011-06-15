From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 4/5] ASoC: AD1836: rename suspend/resume funcs
Date: Wed, 15 Jun 2011 15:29:22 -0400
Message-ID: <1308166163-22355-5-git-send-email-vapier@gentoo.org>
References: <1308166163-22355-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id B08F910384B
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 21:29:01 +0200 (CEST)
In-Reply-To: <1308166163-22355-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Scott Jiang <scott.jiang@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

Use less specific names for suspend/resume to match the probe/remove funcs
where these are now used.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Scott Jiang <scott.jiang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad1836.c |   43 +++++++++++++++++++++----------------------
 1 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index fc14668..b9a5bab 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -198,26 +198,6 @@ static int ad1836_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ad1836_soc_suspend(struct snd_soc_codec *codec,
-		pm_message_t state)
-{
-	/* reset clock control mode */
-	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
-		AD1836_ADC_SERFMT_MASK, 0);
-}
-
-static int ad1836_soc_resume(struct snd_soc_codec *codec)
-{
-	/* restore clock control mode */
-	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
-		AD1836_ADC_SERFMT_MASK, AD1836_ADC_AUX);
-}
-#else
-#define ad1836_soc_suspend NULL
-#define ad1836_soc_resume  NULL
-#endif
-
 static struct snd_soc_dai_ops ad1836_dai_ops = {
 	.hw_params = ad1836_hw_params,
 	.set_fmt = ad1836_set_dai_fmt,
@@ -251,6 +231,25 @@ static struct snd_soc_dai_driver ad183x_dais[] = {
 	[AD1838] = AD183X_DAI("ad1838", 3, 1),
 };
 
+#ifdef CONFIG_PM
+static int ad1836_suspend(struct snd_soc_codec *codec, pm_message_t state)
+{
+	/* reset clock control mode */
+	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
+		AD1836_ADC_SERFMT_MASK, 0);
+}
+
+static int ad1836_resume(struct snd_soc_codec *codec)
+{
+	/* restore clock control mode */
+	return snd_soc_update_bits(codec, AD1836_ADC_CTRL2,
+		AD1836_ADC_SERFMT_MASK, AD1836_ADC_AUX);
+}
+#else
+#define ad1836_suspend NULL
+#define ad1836_resume  NULL
+#endif
+
 static int ad1836_probe(struct snd_soc_codec *codec)
 {
 	struct ad1836_priv *ad1836 = snd_soc_codec_get_drvdata(codec);
@@ -333,8 +332,8 @@ static int ad1836_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_ad1836 = {
 	.probe = ad1836_probe,
 	.remove = ad1836_remove,
-	.suspend =      ad1836_soc_suspend,
-	.resume =       ad1836_soc_resume,
+	.suspend = ad1836_suspend,
+	.resume = ad1836_resume,
 	.reg_cache_size = AD1836_NUM_REGS,
 	.reg_word_size = sizeof(u16),
 
-- 
1.7.5.3
