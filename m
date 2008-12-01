From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 3/4] ASoC: TWL4030: Add volume controls for
	outputs
Date: Mon,  1 Dec 2008 10:03:47 +0200
Message-ID: <1228118628-22856-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1228118628-22856-1-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-2-git-send-email-peter.ujfalusi@nokia.com>
	<1228118628-22856-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 70AB2243D8
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 09:04:00 +0100 (CET)
In-Reply-To: <1228118628-22856-3-git-send-email-peter.ujfalusi@nokia.com>
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

All outputs have dedicated gain controls except the
HandsFree output.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 849ad4b..bd236b2 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -367,6 +367,12 @@ static DECLARE_TLV_DB_SCALE(digital_coarse_tlv, 0, 600, 0);
 static DECLARE_TLV_DB_SCALE(analog_tlv, -2400, 200, 0);
 
 /*
+ * Gain controls tied to outputs
+ * -6 dB to 6 dB in 6 dB steps (mute instead of -12)
+ */
+static DECLARE_TLV_DB_SCALE(output_tvl, -1200, 600, 1);
+
+/*
  * Capture gain after the ADCs
  * from 0 dB to 31 dB in 1 dB steps
  */
@@ -395,6 +401,21 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 		TWL4030_REG_ARXL2_APGA_CTL, TWL4030_REG_ARXR2_APGA_CTL,
 		3, 0x12, 1, analog_tlv),
 
+	/* Separate output gain controls */
+	SOC_DOUBLE_R_TLV_TWL4030("PreDriv Playback Volume",
+		TWL4030_REG_PREDL_CTL, TWL4030_REG_PREDR_CTL,
+		4, 3, 0, output_tvl),
+
+	SOC_DOUBLE_TLV_TWL4030("Headset Playback Volume",
+		TWL4030_REG_HS_GAIN_SET, 0, 2, 3, 0, output_tvl),
+
+	SOC_DOUBLE_R_TLV_TWL4030("Carkit Playback Volume",
+		TWL4030_REG_PRECKL_CTL, TWL4030_REG_PRECKR_CTL,
+		4, 3, 0, output_tvl),
+
+	SOC_SINGLE_TLV_TWL4030("Earpiece Playback Volume",
+		TWL4030_REG_EAR_CTL, 4, 3, 0, output_tvl),
+
 	/* Common capture gain controls */
 	SOC_DOUBLE_R_TLV("Capture Volume",
 		TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
-- 
1.6.0.3
