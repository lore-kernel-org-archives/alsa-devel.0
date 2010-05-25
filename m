From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/7] ASoC: TWL4030: Make offset cancellation
	path configurable
Date: Tue, 25 May 2010 14:34:04 +0300
Message-ID: <1274787248-18583-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 51B3924486
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 13:34:49 +0200 (CEST)
In-Reply-To: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
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

Add means for machine drivers to select the path for offset
cancellation.
Reset the reg cache value to the chip reset value at the
same time.

Machine drivers can specify which path need to be used for
offset cancellation via the twl4030_setup.offset_cncl_path.
For paths use the defines from
include/linux/mfd/twl4030-codec.h:
TWL4030_OFFSET_CNCL_SEL_*

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    6 +++++-
 sound/soc/codecs/twl4030.h |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 1e0aba5..2855771 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -46,7 +46,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0xc3, /* REG_OPTION		(0x2)	*/
 	0x00, /* REG_UNKNOWN		(0x3)	*/
 	0x00, /* REG_MICBIAS_CTL	(0x4)	*/
-	0x20, /* REG_ANAMICL		(0x5)	*/
+	0x00, /* REG_ANAMICL		(0x5)	*/
 	0x00, /* REG_ANAMICR		(0x6)	*/
 	0x00, /* REG_AVADC_CTL		(0x7)	*/
 	0x00, /* REG_ADCMICSEL		(0x8)	*/
@@ -281,6 +281,8 @@ static void twl4030_apll_enable(struct snd_soc_codec *codec, int enable)
 
 static void twl4030_power_up(struct snd_soc_codec *codec)
 {
+	struct snd_soc_device *socdev = codec->socdev;
+	struct twl4030_setup_data *setup = socdev->codec_data;
 	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
 	u8 anamicl, regmisc1, byte;
 	int i = 0;
@@ -293,6 +295,8 @@ static void twl4030_power_up(struct snd_soc_codec *codec)
 
 	/* initiate offset cancellation */
 	anamicl = twl4030_read_reg_cache(codec, TWL4030_REG_ANAMICL);
+	anamicl &= ~TWL4030_OFFSET_CNCL_SEL;
+	anamicl |= (setup->offset_cncl_path << 5);
 	twl4030_write(codec, TWL4030_REG_ANAMICL,
 		anamicl | TWL4030_CNCL_OFFSET_START);
 
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index f206d24..c98e303 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -42,6 +42,7 @@ extern struct snd_soc_codec_device soc_codec_dev_twl4030;
 struct twl4030_setup_data {
 	unsigned int ramp_delay_value;
 	unsigned int sysclk;
+	unsigned int offset_cncl_path;
 	unsigned int hs_extmute:1;
 	void (*set_hs_extmute)(int mute);
 };
-- 
1.7.1
