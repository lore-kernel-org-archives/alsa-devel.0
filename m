From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH v2 8/8] ASoC: TWL4030: Add functionalty to
	reset the registers
Date: Wed, 26 May 2010 11:38:21 +0300
Message-ID: <1274863101-18514-9-git-send-email-peter.ujfalusi@nokia.com>
References: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 727F9103940
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 10:38:44 +0200 (CEST)
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

Machine driver can instruct the codec driver to reset the
chip registers to their default values at probe time.

If machine driver does not provide setup data, then the
registers are going to be reseted to their defaults, to
be safe.

If the developer on the platform confirms that the register
reset is not needed, than it can be skipped, saving ~20ms
time in probe.

As safety measure do the register reset at remove time also.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   17 +++++++++++++++++
 sound/soc/codecs/twl4030.h |    1 +
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 7bd5f33..7bede64 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -262,6 +262,17 @@ static inline void twl4030_check_defaults(struct snd_soc_codec *codec)
 		 difference, difference ? "Not OK" : "OK");
 }
 
+static inline void twl4030_reset_registers(struct snd_soc_codec *codec)
+{
+	int i;
+
+	/* set all audio section registers to reasonable defaults */
+	for (i = TWL4030_REG_OPTION; i <= TWL4030_REG_MISC_SET_2; i++)
+		if (i != TWL4030_REG_APLL_CTL)
+			twl4030_write(codec, i, twl4030_reg[i]);
+
+}
+
 static void twl4030_init_chip(struct platform_device *pdev)
 {
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
@@ -275,6 +286,10 @@ static void twl4030_init_chip(struct platform_device *pdev)
 	if (setup && setup->check_defaults)
 		twl4030_check_defaults(codec);
 
+	/* Reset registers, if no setup data or if instructed to do so */
+	if (!setup || (setup && setup->reset_registers))
+		twl4030_reset_registers(codec);
+
 	/* Refresh APLL_CTL register from HW */
 	twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte,
 			    TWL4030_REG_APLL_CTL);
@@ -2271,6 +2286,8 @@ static int twl4030_soc_remove(struct platform_device *pdev)
 	struct snd_soc_device *socdev = platform_get_drvdata(pdev);
 	struct snd_soc_codec *codec = socdev->card->codec;
 
+	/* Reset registers to their chip default before leaving */
+	twl4030_reset_registers(codec);
 	twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
 	snd_soc_free_pcms(socdev);
 	snd_soc_dapm_free(socdev);
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index c22542c..788e3d1 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -44,6 +44,7 @@ struct twl4030_setup_data {
 	unsigned int sysclk;
 	unsigned int offset_cncl_path;
 	unsigned int check_defaults:1;
+	unsigned int reset_registers:1;
 	unsigned int hs_extmute:1;
 	void (*set_hs_extmute)(int mute);
 };
-- 
1.7.1
