From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 5/8] ASoC: TWL4030: Helper to check chip
	default registers
Date: Wed, 26 May 2010 11:38:18 +0300
Message-ID: <1274863101-18514-6-git-send-email-peter.ujfalusi@nokia.com>
References: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 09E9C103955
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 10:38:46 +0200 (CEST)
In-Reply-To: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Since the twl4030 codec driver supports different version
of the PM chip, a helper function can come handy, which
can check the driver's default versus the chip values.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   23 +++++++++++++++++++++++
 sound/soc/codecs/twl4030.h |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 08f24de..cd913ef 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -243,6 +243,25 @@ static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
 	udelay(10);
 }

+static inline void twl4030_check_defaults(struct snd_soc_codec *codec)
+{
+	int i, difference = 0;
+	u8 val;
+
+	dev_dbg(codec->dev, "Checking TWL audio default configuration\n");
+	for (i = 1; i <= TWL4030_REG_MISC_SET_2; i++) {
+		twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &val, i);
+		if (val != twl4030_reg[i]) {
+			difference++;
+			dev_dbg(codec->dev,
+				 "Reg 0x%02x: chip: 0x%02x driver: 0x%02x\n",
+				 i, val, twl4030_reg[i]);
+		}
+	}
+	dev_dbg(codec->dev, "Found %d non maching registers. %s\n",
+		 difference, difference ? "Not OK" : "OK");
+}
+
 static void twl4030_init_chip(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -252,6 +271,10 @@ static void twl4030_init_chip(struct platform_device *pdev)
 	u8 reg, byte;
 	int i = 0;

+	/* Check defaults, if instructed before anything else */
+	if (setup && setup->check_defaults)
+		twl4030_check_defaults(codec);
+
 	/* Refresh APLL_CTL register from HW */
 	twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
 			    TWL4030_REG_APLL_CTL);
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index c98e303..c22542c 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -43,6 +43,7 @@ struct twl4030_setup_data {
 	unsigned int ramp_delay_value;
 	unsigned int sysclk;
 	unsigned int offset_cncl_path;
+	unsigned int check_defaults:1;
 	unsigned int hs_extmute:1;
 	void (*set_hs_extmute)(int mute);
 };
--
1.7.1
