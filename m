From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 2/4] ASoC: TWL4030: Change the common playback
	volume controls
Date: Mon,  1 Dec 2008 10:03:46 +0200
Message-ID: <1228118628-22856-3-git-send-email-peter.ujfalusi@nokia.com>
References: <1228118628-22856-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-2-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B0D8243F4
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 09:04:12 +0100 (CET)
In-Reply-To: <1228118628-22856-2-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: sakoman@gmail.com, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

Add Playback volume controls for all four DACs.
All four paths has three levels of volume controls:
Digital Fine gain, Digital Coarse gain, Analog gain.

The controls are named to reflect their connection to the DACs.
Per DAC volume can be performed, if needed:
amixer sset 'DAC1 Analog'  5,10
DACL1 analog gain to 5
DACR1 analog gain to 10

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   37 +++++++++++++++++++++++++++++--------
 1 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index ffc9401..849ad4b 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -351,14 +351,20 @@ static int snd_soc_put_volsw_r2_twl4030(struct snd_kcontrol *kcontrol,
  * FGAIN volume control:
  * from -62 to 0 dB in 1 dB steps (mute instead of -63 dB)
  */
-static DECLARE_TLV_DB_SCALE(master_tlv, -6300, 100, 1);
+static DECLARE_TLV_DB_SCALE(digital_fine_tlv, -6300, 100, 1);
 
 /*
  * CGAIN volume control:
  * 0 dB to 12 dB in 6 dB steps
  * value 2 and 3 means 12 dB
  */
-static DECLARE_TLV_DB_SCALE(master_coarse_tlv, 0, 600, 0);
+static DECLARE_TLV_DB_SCALE(digital_coarse_tlv, 0, 600, 0);
+
+/*
+ * Analog playback gain
+ * -24 dB to 12 dB in 2 dB steps
+ */
+static DECLARE_TLV_DB_SCALE(analog_tlv, -2400, 200, 0);
 
 /*
  * Capture gain after the ADCs
@@ -367,12 +373,27 @@ static DECLARE_TLV_DB_SCALE(master_coarse_tlv, 0, 600, 0);
 static DECLARE_TLV_DB_SCALE(digital_capture_tlv, 0, 100, 0);
 
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
-	SOC_DOUBLE_R_TLV("Master Playback Volume",
-		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
-		0, 0x3f, 0, master_tlv),
-	SOC_DOUBLE_R_TLV("Master PCM Playback Volume",
-		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
-		6, 0x2, 0, master_coarse_tlv),
+	/* Common playback gain controls */
+	SOC_DOUBLE_R_TLV("DAC1 Digital Fine Playback Volume",
+		TWL4030_REG_ARXL1PGA, TWL4030_REG_ARXR1PGA,
+		0, 0x3f, 0, digital_fine_tlv),
+	SOC_DOUBLE_R_TLV("DAC2 Digital Fine Playback Volume",
+		TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
+		0, 0x3f, 0, digital_fine_tlv),
+
+	SOC_DOUBLE_R_TLV("DAC1 Digital Coarse Playback Volume",
+		TWL4030_REG_ARXL1PGA, TWL4030_REG_ARXR1PGA,
+		6, 0x2, 0, digital_coarse_tlv),
+	SOC_DOUBLE_R_TLV("DAC2 Digital Coarse Playback Volume",
+		TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
+		6, 0x2, 0, digital_coarse_tlv),
+
+	SOC_DOUBLE_R_TLV("DAC1 Analog Playback Volume",
+		TWL4030_REG_ARXL1_APGA_CTL, TWL4030_REG_ARXR1_APGA_CTL,
+		3, 0x12, 1, analog_tlv),
+	SOC_DOUBLE_R_TLV("DAC2 Analog Playback Volume",
+		TWL4030_REG_ARXL2_APGA_CTL, TWL4030_REG_ARXR2_APGA_CTL,
+		3, 0x12, 1, analog_tlv),
 
 	/* Common capture gain controls */
 	SOC_DOUBLE_R_TLV("Capture Volume",
-- 
1.6.0.3
