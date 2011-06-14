From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 7/8] ASoC: AD183x: rename suspend/resume funcs
Date: Tue, 14 Jun 2011 17:34:27 -0400
Message-ID: <1308087268-11464-7-git-send-email-vapier@gentoo.org>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 7BF25243ED
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Jun 2011 23:34:08 +0200 (CEST)
In-Reply-To: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
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
 sound/soc/codecs/ad183x.c |   51 ++++++++++++++++++++++-----------------------
 1 files changed, 25 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/ad183x.c b/sound/soc/codecs/ad183x.c
index 2c5c49e..21567ce 100644
--- a/sound/soc/codecs/ad183x.c
+++ b/sound/soc/codecs/ad183x.c
@@ -155,30 +155,6 @@ static int ad183x_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int ad183x_soc_suspend(struct snd_soc_codec *codec,
-		pm_message_t state)
-{
-	/* reset clock control mode */
-	u16 adc_ctrl2 = snd_soc_read(codec, AD183X_ADC_CTRL2);
-	adc_ctrl2 &= ~AD183X_ADC_SERFMT_MASK;
-
-	return snd_soc_write(codec, AD183X_ADC_CTRL2, adc_ctrl2);
-}
-
-static int ad183x_soc_resume(struct snd_soc_codec *codec)
-{
-	/* restore clock control mode */
-	u16 adc_ctrl2 = snd_soc_read(codec, AD183X_ADC_CTRL2);
-	adc_ctrl2 |= AD183X_ADC_AUX;
-
-	return snd_soc_write(codec, AD183X_ADC_CTRL2, adc_ctrl2);
-}
-#else
-#define ad183x_soc_suspend NULL
-#define ad183x_soc_resume  NULL
-#endif
-
 static struct snd_soc_dai_ops ad183x_dai_ops = {
 	.hw_params = ad183x_hw_params,
 	.set_fmt = ad183x_set_dai_fmt,
@@ -206,6 +182,29 @@ static struct snd_soc_dai_driver ad183x_dai = {
 	.ops = &ad183x_dai_ops,
 };
 
+#ifdef CONFIG_PM
+static int ad183x_suspend(struct snd_soc_codec *codec, pm_message_t state)
+{
+	/* reset clock control mode */
+	u16 adc_ctrl2 = snd_soc_read(codec, AD183X_ADC_CTRL2);
+	adc_ctrl2 &= ~AD183X_ADC_SERFMT_MASK;
+
+	return snd_soc_write(codec, AD183X_ADC_CTRL2, adc_ctrl2);
+}
+
+static int ad183x_resume(struct snd_soc_codec *codec)
+{
+	/* restore clock control mode */
+	u16 adc_ctrl2 = snd_soc_read(codec, AD183X_ADC_CTRL2);
+	adc_ctrl2 |= AD183X_ADC_AUX;
+
+	return snd_soc_write(codec, AD183X_ADC_CTRL2, adc_ctrl2);
+}
+#else
+#define ad183x_suspend NULL
+#define ad183x_resume  NULL
+#endif
+
 static int ad183x_probe(struct snd_soc_codec *codec)
 {
 	struct ad183x_priv *ad183x = snd_soc_codec_get_drvdata(codec);
@@ -242,8 +241,8 @@ static int ad183x_remove(struct snd_soc_codec *codec)
 static struct snd_soc_codec_driver soc_codec_dev_ad183x = {
 	.probe =        ad183x_probe,
 	.remove =       ad183x_remove,
-	.suspend =      ad183x_soc_suspend,
-	.resume =       ad183x_soc_resume,
+	.suspend =      ad183x_suspend,
+	.resume =       ad183x_resume,
 	.reg_cache_size = AD183X_NUM_REGS,
 	.reg_word_size = sizeof(u16),
 };
-- 
1.7.5.3
