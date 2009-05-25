From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/3 take2] ASoC: TWL4030: Add shadow register
Date: Mon, 25 May 2009 11:12:12 +0300
Message-ID: <1243239133-18996-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1243239133-18996-1-git-send-email-peter.ujfalusi@nokia.com>
	<1243239133-18996-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id AE75E103853
	for <alsa-devel@alsa-project.org>;
	Mon, 25 May 2009 10:12:22 +0200 (CEST)
In-Reply-To: <1243239133-18996-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Shadow, non HW register for dealing with the HandsfreeL/R
muting.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    7 ++++++-
 sound/soc/codecs/twl4030.h |    7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 17ddcb2..989446d 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -115,6 +115,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_VIBRA_PWM_SET	(0x47)	*/
 	0x00, /* REG_ANAMIC_GAIN	(0x48)	*/
 	0x00, /* REG_MISC_SET_2		(0x49)	*/
+	0x00, /* REG_SW_SHADOW		(0x4A)	- Shadow, non HW register */
 };

 /* codec private data */
@@ -172,7 +173,11 @@ static int twl4030_write(struct snd_soc_codec *codec,
 			unsigned int reg, unsigned int value)
 {
 	twl4030_write_reg_cache(codec, reg, value);
-	return twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value, reg);
+	if (likely(reg < TWL4030_REG_SW_SHADOW))
+		return twl4030_i2c_write_u8(TWL4030_MODULE_AUDIO_VOICE, value,
+					    reg);
+	else
+		return 0;
 }

 static void twl4030_codec_enable(struct snd_soc_codec *codec, int enable)
diff --git a/sound/soc/codecs/twl4030.h b/sound/soc/codecs/twl4030.h
index 48326e2..fe5f395 100644
--- a/sound/soc/codecs/twl4030.h
+++ b/sound/soc/codecs/twl4030.h
@@ -92,8 +92,9 @@
 #define TWL4030_REG_VIBRA_PWM_SET	0x47
 #define TWL4030_REG_ANAMIC_GAIN		0x48
 #define TWL4030_REG_MISC_SET_2		0x49
+#define TWL4030_REG_SW_SHADOW		0x4A

-#define TWL4030_CACHEREGNUM	(TWL4030_REG_MISC_SET_2 + 1)
+#define TWL4030_CACHEREGNUM	(TWL4030_REG_SW_SHADOW + 1)

 /* Bitfield Definitions */

@@ -260,6 +261,10 @@
 #define TWL4030_SMOOTH_ANAVOL_EN	0x02
 #define TWL4030_DIGMIC_LR_SWAP_EN	0x01

+/* TWL4030_REG_SW_SHADOW (0x4A) Fields */
+#define TWL4030_HFL_EN			0x01
+#define TWL4030_HFR_EN			0x02
+
 #define TWL4030_DAI_HIFI		0
 #define TWL4030_DAI_VOICE		1

--
1.6.3.1
