From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 6/7] ASoC: TWL4030: Add volume controls for
	outputs
Date: Mon,  1 Dec 2008 20:07:40 +0000
Message-ID: <1228162061-14769-6-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081201200703.GA14376@rakim.wolfsonmicro.main>
	<1228162061-14769-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-5-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EE5A21037EB
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 21:07:43 +0100 (CET)
In-Reply-To: <1228162061-14769-5-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Peter Ujfalusi <peter.ujfalusi@nokia.com>

All outputs have dedicated gain controls except the
HandsFree output.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 1dae73a..ffd5120 100644
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
1.5.6.5
