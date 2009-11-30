From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] ALSA: ASoc: Add regulator support to CS4270
	codec driver
Date: Mon, 30 Nov 2009 17:56:11 +0100
Message-ID: <1259600171-30357-1-git-send-email-daniel@caiaq.de>
References: <20091130165104.GK14091@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EC6024426
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 17:56:24 +0100 (CET)
In-Reply-To: <20091130165104.GK14091@buzzloop.caiaq.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Timur Tabi <timur@freescale.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Timur Tabi <timur@freescale.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
---
 sound/soc/codecs/cs4270.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index ffe122d..8b54575 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -28,6 +28,7 @@
 #include <sound/initval.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/regulator/consumer.h>
 
 #include "cs4270.h"
 
@@ -106,6 +107,10 @@
 #define CS4270_MUTE_DAC_A	0x01
 #define CS4270_MUTE_DAC_B	0x02
 
+static const char *supply_names[] = {
+	"va", "vd", "vlc"
+};
+
 /* Private data for the CS4270 */
 struct cs4270_private {
 	struct snd_soc_codec codec;
@@ -114,6 +119,9 @@ struct cs4270_private {
 	unsigned int mode; /* The mode (I2S or left-justified) */
 	unsigned int slave_mode;
 	unsigned int manual_mute;
+
+	/* power domain regulators */
+	struct regulator_bulk_data supplies[ARRAY_SIZE(supply_names)];
 };
 
 /**
@@ -579,7 +587,8 @@ static int cs4270_probe(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = cs4270_codec;
-	int ret;
+	struct cs4270_private *cs4270 = codec->private_data;
+	int i, ret;
 
 	/* Connect the codec to the socdev.  snd_soc_new_pcms() needs this. */
 	socdev->card->codec = codec;
@@ -599,6 +608,15 @@ static int cs4270_probe(struct platform_device *pdev)
 		goto error_free_pcms;
 	}
 
+	/* get the power supply regulators */
+	for (i = 0; i < ARRAY_SIZE(supply_names); i++)
+		cs4270->supplies[i].supply = supply_names[i];
+
+	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(cs4270->supplies),
+				 cs4270->supplies);
+	if (ret < 0)
+		goto error_free_pcms;
+
 	return 0;
 
 error_free_pcms:
@@ -616,8 +634,11 @@ error_free_pcms:
 static int cs4270_remove(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
+	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 
 	snd_soc_free_pcms(socdev);
+	regulator_bulk_free(ARRAY_SIZE(cs4270->supplies), cs4270->supplies);
 
 	return 0;
 };
@@ -799,17 +820,33 @@ MODULE_DEVICE_TABLE(i2c, cs4270_id);
 static int cs4270_soc_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct snd_soc_codec *codec = cs4270_codec;
-	int reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
+	struct cs4270_private *cs4270 = codec->private_data;
+	int reg, ret;
 
-	return snd_soc_write(codec, CS4270_PWRCTL, reg);
+	reg = snd_soc_read(codec, CS4270_PWRCTL) | CS4270_PWRCTL_PDN_ALL;
+	if (reg < 0)
+		return reg;
+
+	ret = snd_soc_write(codec, CS4270_PWRCTL, reg);
+	if (ret < 0)
+		return ret;
+
+	regulator_bulk_disable(ARRAY_SIZE(cs4270->supplies),
+			       cs4270->supplies);
+
+	return 0;
 }
 
 static int cs4270_soc_resume(struct platform_device *pdev)
 {
 	struct snd_soc_codec *codec = cs4270_codec;
+	struct cs4270_private *cs4270 = codec->private_data;
 	struct i2c_client *i2c_client = codec->control_data;
 	int reg;
 
+	regulator_bulk_enable(ARRAY_SIZE(cs4270->supplies),
+			      cs4270->supplies);
+
 	/* In case the device was put to hard reset during sleep, we need to
 	 * wait 500ns here before any I2C communication. */
 	ndelay(500);
-- 
1.6.5.2
