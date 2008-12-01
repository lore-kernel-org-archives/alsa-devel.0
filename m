From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/7] ASoC: TWL4030: Change the capture volume
	control to TLV
Date: Mon,  1 Dec 2008 20:07:38 +0000
Message-ID: <1228162061-14769-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081201200703.GA14376@rakim.wolfsonmicro.main>
	<1228162061-14769-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-3-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 98CA41037F5
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 21:07:43 +0100 (CET)
In-Reply-To: <1228162061-14769-3-git-send-email-broonie@opensource.wolfsonmicro.com>
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

The digital Capture gain control has a range:
0 to 31 dB in 1 dB steps.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index f3e9e59..4b7a2d1 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -360,6 +360,12 @@ static DECLARE_TLV_DB_SCALE(master_tlv, -6300, 100, 1);
  */
 static DECLARE_TLV_DB_SCALE(master_coarse_tlv, 0, 600, 0);
 
+/*
+ * Capture gain after the ADCs
+ * from 0 dB to 31 dB in 1 dB steps
+ */
+static DECLARE_TLV_DB_SCALE(digital_capture_tlv, 0, 100, 0);
+
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Master Playback Volume",
 		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
@@ -367,9 +373,11 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	SOC_DOUBLE_R_TLV("Master PCM Playback Volume",
 		 TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
 		6, 0x2, 0, master_coarse_tlv),
-	SOC_DOUBLE_R("Capture Volume",
-		 TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
-		0, 0x1f, 0),
+
+	/* Common capture gain controls */
+	SOC_DOUBLE_R_TLV("Capture Volume",
+		TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
+		0, 0x1f, 0, digital_capture_tlv),
 };
 
 /* add non dapm controls */
-- 
1.5.6.5
