From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH] ASoC: TWL4030: Modify codec default settings
Date: Thu, 28 Jan 2010 15:57:04 +0200
Message-ID: <1264687024-7241-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id DC379243A7
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 14:58:00 +0100 (CET)
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
Cc: broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Change the legacy default register configuration, which left some
internal components on.
Now we have either DAPM, or other ways to control these bits,
so there is no need to enable them by default.

The affected parts:
Disable ADCL and ADCR
Disable ARXL2 and ARXR2 analog PGA (playback)
Disable APLL by default

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 74f0d65..e0106a5 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -64,12 +64,12 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_VRXPGA		(0x14)	*/
 	0x00, /* REG_VSTPGA		(0x15)	*/
 	0x00, /* REG_VRX2ARXPGA		(0x16)	*/
-	0x0c, /* REG_AVDAC_CTL		(0x17)	*/
+	0x00, /* REG_AVDAC_CTL		(0x17)	*/
 	0x00, /* REG_ARX2VTXPGA		(0x18)	*/
 	0x00, /* REG_ARXL1_APGA_CTL	(0x19)	*/
 	0x00, /* REG_ARXR1_APGA_CTL	(0x1A)	*/
-	0x4b, /* REG_ARXL2_APGA_CTL	(0x1B)	*/
-	0x4b, /* REG_ARXR2_APGA_CTL	(0x1C)	*/
+	0x4a, /* REG_ARXL2_APGA_CTL	(0x1B)	*/
+	0x4a, /* REG_ARXR2_APGA_CTL	(0x1C)	*/
 	0x00, /* REG_ATX2ARXPGA		(0x1D)	*/
 	0x00, /* REG_BT_IF		(0x1E)	*/
 	0x00, /* REG_BTPGA		(0x1F)	*/
@@ -99,7 +99,7 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
 	0x00, /* REG_I2S_RX_SCRAMBLE_H	(0x37)	*/
 	0x00, /* REG_I2S_RX_SCRAMBLE_M	(0x38)	*/
 	0x00, /* REG_I2S_RX_SCRAMBLE_L	(0x39)	*/
-	0x16, /* REG_APLL_CTL		(0x3A)	*/
+	0x06, /* REG_APLL_CTL		(0x3A)	*/
 	0x00, /* REG_DTMF_CTL		(0x3B)	*/
 	0x00, /* REG_DTMF_PGA_CTL2	(0x3C)	*/
 	0x00, /* REG_DTMF_PGA_CTL1	(0x3D)	*/
-- 
1.6.6.1
