From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/7] ASoC: TWL4030: Revisit codec defaults
Date: Tue, 25 May 2010 14:34:02 +0300
Message-ID: <1274787248-18583-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1274787248-18583-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C4BE24478
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 13:34:34 +0200 (CEST)
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

Reset most of the codec registers to their chip reset
value.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   44 ++++++++++++++++++++++----------------------
 1 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 6a34f56..9a3e999 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -42,7 +42,7 @@
  */
 static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* this register not used		*/
-	0x91, /* REG_CODEC_MODE		(0x1)	*/
+	0x00, /* REG_CODEC_MODE		(0x1)	*/
 	0xc3, /* REG_OPTION		(0x2)	*/
 	0x00, /* REG_UNKNOWN		(0x3)	*/
 	0x00, /* REG_MICBIAS_CTL	(0x4)	*/
@@ -51,28 +51,28 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_AVADC_CTL		(0x7)	*/
 	0x00, /* REG_ADCMICSEL		(0x8)	*/
 	0x00, /* REG_DIGMIXING		(0x9)	*/
-	0x0c, /* REG_ATXL1PGA		(0xA)	*/
-	0x0c, /* REG_ATXR1PGA		(0xB)	*/
-	0x00, /* REG_AVTXL2PGA		(0xC)	*/
-	0x00, /* REG_AVTXR2PGA		(0xD)	*/
+	0x0f, /* REG_ATXL1PGA		(0xA)	*/
+	0x0f, /* REG_ATXR1PGA		(0xB)	*/
+	0x0f, /* REG_AVTXL2PGA		(0xC)	*/
+	0x0f, /* REG_AVTXR2PGA		(0xD)	*/
 	0x00, /* REG_AUDIO_IF		(0xE)	*/
 	0x00, /* REG_VOICE_IF		(0xF)	*/
-	0x00, /* REG_ARXR1PGA		(0x10)	*/
-	0x00, /* REG_ARXL1PGA		(0x11)	*/
-	0x6c, /* REG_ARXR2PGA		(0x12)	*/
-	0x6c, /* REG_ARXL2PGA		(0x13)	*/
-	0x00, /* REG_VRXPGA		(0x14)	*/
+	0x3f, /* REG_ARXR1PGA		(0x10)	*/
+	0x3f, /* REG_ARXL1PGA		(0x11)	*/
+	0x3f, /* REG_ARXR2PGA		(0x12)	*/
+	0x3f, /* REG_ARXL2PGA		(0x13)	*/
+	0x25, /* REG_VRXPGA		(0x14)	*/
 	0x00, /* REG_VSTPGA		(0x15)	*/
 	0x00, /* REG_VRX2ARXPGA		(0x16)	*/
 	0x00, /* REG_AVDAC_CTL		(0x17)	*/
 	0x00, /* REG_ARX2VTXPGA		(0x18)	*/
-	0x00, /* REG_ARXL1_APGA_CTL	(0x19)	*/
-	0x00, /* REG_ARXR1_APGA_CTL	(0x1A)	*/
-	0x4a, /* REG_ARXL2_APGA_CTL	(0x1B)	*/
-	0x4a, /* REG_ARXR2_APGA_CTL	(0x1C)	*/
+	0x32, /* REG_ARXL1_APGA_CTL	(0x19)	*/
+	0x32, /* REG_ARXR1_APGA_CTL	(0x1A)	*/
+	0x32, /* REG_ARXL2_APGA_CTL	(0x1B)	*/
+	0x32, /* REG_ARXR2_APGA_CTL	(0x1C)	*/
 	0x00, /* REG_ATX2ARXPGA		(0x1D)	*/
 	0x00, /* REG_BT_IF		(0x1E)	*/
-	0x00, /* REG_BTPGA		(0x1F)	*/
+	0x55, /* REG_BTPGA		(0x1F)	*/
 	0x00, /* REG_BTSTPGA		(0x20)	*/
 	0x00, /* REG_EAR_CTL		(0x21)	*/
 	0x00, /* REG_HS_SEL		(0x22)	*/
@@ -84,32 +84,32 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_PRECKR_CTL		(0x28)	*/
 	0x00, /* REG_HFL_CTL		(0x29)	*/
 	0x00, /* REG_HFR_CTL		(0x2A)	*/
-	0x00, /* REG_ALC_CTL		(0x2B)	*/
+	0x05, /* REG_ALC_CTL		(0x2B)	*/
 	0x00, /* REG_ALC_SET1		(0x2C)	*/
 	0x00, /* REG_ALC_SET2		(0x2D)	*/
 	0x00, /* REG_BOOST_CTL		(0x2E)	*/
 	0x00, /* REG_SOFTVOL_CTL	(0x2F)	*/
-	0x00, /* REG_DTMF_FREQSEL	(0x30)	*/
+	0x13, /* REG_DTMF_FREQSEL	(0x30)	*/
 	0x00, /* REG_DTMF_TONEXT1H	(0x31)	*/
 	0x00, /* REG_DTMF_TONEXT1L	(0x32)	*/
 	0x00, /* REG_DTMF_TONEXT2H	(0x33)	*/
 	0x00, /* REG_DTMF_TONEXT2L	(0x34)	*/
-	0x00, /* REG_DTMF_TONOFF	(0x35)	*/
-	0x00, /* REG_DTMF_WANONOFF	(0x36)	*/
+	0x79, /* REG_DTMF_TONOFF	(0x35)	*/
+	0x11, /* REG_DTMF_WANONOFF	(0x36)	*/
 	0x00, /* REG_I2S_RX_SCRAMBLE_H	(0x37)	*/
 	0x00, /* REG_I2S_RX_SCRAMBLE_M	(0x38)	*/
 	0x00, /* REG_I2S_RX_SCRAMBLE_L	(0x39)	*/
 	0x06, /* REG_APLL_CTL		(0x3A)	*/
 	0x00, /* REG_DTMF_CTL		(0x3B)	*/
-	0x00, /* REG_DTMF_PGA_CTL2	(0x3C)	*/
-	0x00, /* REG_DTMF_PGA_CTL1	(0x3D)	*/
+	0x44, /* REG_DTMF_PGA_CTL2	(0x3C)	*/
+	0x69, /* REG_DTMF_PGA_CTL1	(0x3D)	*/
 	0x00, /* REG_MISC_SET_1		(0x3E)	*/
 	0x00, /* REG_PCMBTMUX		(0x3F)	*/
 	0x00, /* not used		(0x40)	*/
 	0x00, /* not used		(0x41)	*/
 	0x00, /* not used		(0x42)	*/
 	0x00, /* REG_RX_PATH_SEL	(0x43)	*/
-	0x00, /* REG_VDL_APGA_CTL	(0x44)	*/
+	0x32, /* REG_VDL_APGA_CTL	(0x44)	*/
 	0x00, /* REG_VIBRA_CTL		(0x45)	*/
 	0x00, /* REG_VIBRA_SET		(0x46)	*/
 	0x00, /* REG_VIBRA_PWM_SET	(0x47)	*/
-- 
1.7.1
