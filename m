From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 3/8] ASoC: AD1836: fix intermixed tab/space
	indentation
Date: Tue, 14 Jun 2011 17:34:23 -0400
Message-ID: <1308087268-11464-3-git-send-email-vapier@gentoo.org>
References: <1308087268-11464-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 33FBA243EB
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
Cc: Lars-Peter Clausen <lars@metafoo.de>, device-drivers-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ad1836.c |    4 ++--
 sound/soc/codecs/ad1836.h |   12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/ad1836.c b/sound/soc/codecs/ad1836.c
index 78c24f8..56b90aa 100644
--- a/sound/soc/codecs/ad1836.c
+++ b/sound/soc/codecs/ad1836.c
@@ -250,8 +250,8 @@ static int ad1836_remove(struct snd_soc_codec *codec)
 }
 
 static struct snd_soc_codec_driver soc_codec_dev_ad1836 = {
-	.probe = 	ad1836_probe,
-	.remove = 	ad1836_remove,
+	.probe =        ad1836_probe,
+	.remove =       ad1836_remove,
 	.suspend =      ad1836_soc_suspend,
 	.resume =       ad1836_soc_resume,
 	.reg_cache_size = AD1836_NUM_REGS,
diff --git a/sound/soc/codecs/ad1836.h b/sound/soc/codecs/ad1836.h
index 9d6a3f8..81d9ae3 100644
--- a/sound/soc/codecs/ad1836.h
+++ b/sound/soc/codecs/ad1836.h
@@ -21,7 +21,7 @@
 
 #define AD1836_DAC_CTRL1               0
 #define AD1836_DAC_POWERDOWN           2
-#define AD1836_DAC_SERFMT_MASK	       0xE0
+#define AD1836_DAC_SERFMT_MASK         0xE0
 #define AD1836_DAC_SERFMT_PCK256       (0x4 << 5)
 #define AD1836_DAC_SERFMT_PCK128       (0x5 << 5)
 #define AD1836_DAC_WORD_LEN_MASK       0x18
@@ -47,13 +47,13 @@
 #define AD1836_ADC_HIGHPASS_FILTER     8
 
 #define AD1836_ADC_CTRL2               13
-#define AD1836_ADCL1_MUTE 		0
-#define AD1836_ADCR1_MUTE 		1
-#define AD1836_ADCL2_MUTE 		2
-#define AD1836_ADCR2_MUTE 		3
+#define AD1836_ADCL1_MUTE              0
+#define AD1836_ADCR1_MUTE              1
+#define AD1836_ADCL2_MUTE              2
+#define AD1836_ADCR2_MUTE              3
 #define AD1836_ADC_WORD_LEN_MASK       0x30
 #define AD1836_ADC_WORD_OFFSET         5
-#define AD1836_ADC_SERFMT_MASK	       (7 << 6)
+#define AD1836_ADC_SERFMT_MASK         (7 << 6)
 #define AD1836_ADC_SERFMT_PCK256       (0x4 << 6)
 #define AD1836_ADC_SERFMT_PCK128       (0x5 << 6)
 #define AD1836_ADC_AUX                 (0x6 << 6)
-- 
1.7.5.3
