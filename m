From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/1] ASoC: TWL4030: Make the HS ramp delay
	configurable
Date: Thu,  5 Mar 2009 12:48:49 +0200
Message-ID: <1236250129-2533-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1236250129-2533-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id A79FF103899
	for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2009 11:49:10 +0100 (CET)
In-Reply-To: <1236250129-2533-1-git-send-email-peter.ujfalusi@nokia.com>
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

Enum type for selecting the desired ramp delay for the headset output.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/codecs/twl4030.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 535d8ce..86bb15c 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -584,12 +584,11 @@ static int headsetl_event(struct snd_soc_dapm_widget *w,
 
 	/* Save the current volume */
 	hs_gain = twl4030_read_reg_cache(w->codec, TWL4030_REG_HS_GAIN_SET);
+	hs_pop = twl4030_read_reg_cache(w->codec, TWL4030_REG_HS_POPN_SET);
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
 		/* Do the anti-pop/bias ramp enable according to the TRM */
-		hs_pop = TWL4030_RAMP_DELAY_645MS;
-		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 		hs_pop |= TWL4030_VMID_EN;
 		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 		/* Is this needed? Can we just use whatever gain here? */
@@ -603,8 +602,6 @@ static int headsetl_event(struct snd_soc_dapm_widget *w,
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		/* Do the anti-pop/bias ramp disable according to the TRM */
-		hs_pop = twl4030_read_reg_cache(w->codec,
-						TWL4030_REG_HS_POPN_SET);
 		hs_pop &= ~TWL4030_RAMP_EN;
 		twl4030_write(w->codec, TWL4030_REG_HS_POPN_SET, hs_pop);
 		/* Bypass the reg_cache to mute the headset */
@@ -847,6 +844,17 @@ static DECLARE_TLV_DB_SCALE(digital_capture_tlv, 0, 100, 0);
  */
 static DECLARE_TLV_DB_SCALE(input_gain_tlv, 0, 600, 0);
 
+static const char *twl4030_rampdelay_texts[] = {
+	"27/20/14 ms", "55/40/27 ms", "109/81/55 ms", "218/161/109 ms",
+	"437/323/218 ms", "874/645/437 ms", "1748/1291/874 ms",
+	"3495/2581/1748 ms"
+};
+
+static const struct soc_enum twl4030_rampdelay_enum =
+	SOC_ENUM_SINGLE(TWL4030_REG_HS_POPN_SET, 2,
+			ARRAY_SIZE(twl4030_rampdelay_texts),
+			twl4030_rampdelay_texts);
+
 static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 	/* Common playback gain controls */
 	SOC_DOUBLE_R_TLV("DAC1 Digital Fine Playback Volume",
@@ -901,6 +909,8 @@ static const struct snd_kcontrol_new twl4030_snd_controls[] = {
 
 	SOC_DOUBLE_TLV("Analog Capture Volume", TWL4030_REG_ANAMIC_GAIN,
 		0, 3, 5, 0, input_gain_tlv),
+
+	SOC_ENUM("HS ramp delay", twl4030_rampdelay_enum),
 };
 
 static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
-- 
1.6.1.3
