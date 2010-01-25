From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH v2] ad1836: reset and restore clock control
	mode in suspend/resume entry
Date: Mon, 25 Jan 2010 16:42:25 +0800
Message-ID: <1264408945-25762-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail11.analog.com (nwd2mail11.analog.com [137.71.25.57])
	by alsa0.perex.cz (Postfix) with ESMTP id 93D9A1037F2
	for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2010 09:42:44 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, Barry Song <21cnbao@gmail.com>
List-Id: alsa-devel@alsa-project.org

tests show frequent suspend/resume(frequent poweroff/on ad1836 internal components)
maybe make ad1836 clock mode wrong sometimes after wakeup. This patch reset/restore
ad1836 clock mode while executing PM, then ad1836 can always resume to right clock
status.

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 -v2: commit forgotten ad1836.h

 sound/soc/codecs/ad1836.c |   32 ++++++++++++++++++++++++++++++++
 sound/soc/codecs/ad1836.h |    1 +
 2 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 2c18e3d..83add2f 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -223,6 +223,36 @@ static unsigned int ad1836_read_reg_cache(struct snd_soc_codec *codec,
 	return reg_cache[reg];
 }
 
+#ifdef CONFIG_PM
+static int ad1836_soc_suspend(struct platform_device *pdev,
+		pm_message_t state)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	/* reset clock control mode */
+	u16 adc_ctrl2 =  codec->read(codec, AD1836_ADC_CTRL2);
+	adc_ctrl2 &= ~AD1836_ADC_SERFMT_MASK;
+
+	return codec->write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
+}
+
+static int ad1836_soc_resume(struct platform_device *pdev)
+{
+	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = socdev->card->codec;
+
+	/* restore clock control mode */
+	u16 adc_ctrl2 = codec->read(codec, AD1836_ADC_CTRL2);
+	adc_ctrl2 |= AD1836_ADC_AUX;
+
+	return codec->write(codec, AD1836_ADC_CTRL2, adc_ctrl2);
+}
+#else
+#define ad1836_soc_suspend NULL
+#define ad1836_soc_resume  NULL
+#endif
+
 static int __devinit ad1836_spi_probe(struct spi_device *spi)
 {
 	struct snd_soc_codec *codec;
@@ -404,6 +434,8 @@ static int ad1836_remove(struct platform_device *pdev)
 struct snd_soc_codec_device soc_codec_dev_ad1836 = {
 	.probe = 	ad1836_probe,
 	.remove = 	ad1836_remove,
+	.suspend =      ad1836_soc_suspend,
+	.resume =       ad1836_soc_resume,
 };
 EXPORT_SYMBOL_GPL(soc_codec_dev_ad1836);
 
diff --git a/sound/soc/codecs/ad1836.h b/sound/soc/codecs/ad1836.h
index 7660ee6..e9d90d3 100644
--- a/sound/soc/codecs/ad1836.h
+++ b/sound/soc/codecs/ad1836.h
@@ -54,6 +54,7 @@
 #define AD1836_ADC_SERFMT_MASK	       (7 << 6)
 #define AD1836_ADC_SERFMT_PCK256       (0x4 << 6)
 #define AD1836_ADC_SERFMT_PCK128       (0x5 << 6)
+#define AD1836_ADC_AUX                 (0x6 << 6)
 
 #define AD1836_ADC_CTRL3               14
 
-- 
1.5.6.3
