From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: TWL4030: Make the enum filter
	generic for twl4030
Date: Thu,  1 Jan 2009 15:32:50 +0000
Message-ID: <1230823973-6557-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090101153113.GA5966@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EF882434A
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2009 16:33:02 +0100 (CET)
In-Reply-To: <20090101153113.GA5966@sirena.org.uk>
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

Modify the enum filter to more generic that it will filter
out the enums with text "Invalid".
The enum filter also required for the capture path.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/twl4030.c |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 5184888..2c279cd 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -298,25 +298,23 @@ static const struct soc_enum twl4030_handsfreer_enum =
 static const struct snd_kcontrol_new twl4030_dapm_handsfreer_control =
 SOC_DAPM_ENUM("Route", twl4030_handsfreer_enum);
 
-static int outmixer_event(struct snd_soc_dapm_widget *w,
+/*
+ * This function filters out the non valid mux settings, named as "Invalid"
+ * in the enum texts.
+ * Just refuse to set an invalid mux mode.
+ */
+static int twl4030_enum_event(struct snd_soc_dapm_widget *w,
 	struct snd_kcontrol *kcontrol, int event)
 {
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int ret = 0;
 	int val;
 
-	switch (e->reg) {
-	case TWL4030_REG_PREDL_CTL:
-	case TWL4030_REG_PREDR_CTL:
-	case TWL4030_REG_EAR_CTL:
-		val = w->value >> e->shift_l;
-		if (val == 3) {
-			printk(KERN_WARNING
-			"Invalid MUX setting for register 0x%02x (%d)\n",
-			      e->reg, val);
-			ret = -1;
-		}
-		break;
+	val = w->value >> e->shift_l;
+	if (!strcmp("Invalid", e->texts[val])) {
+		printk(KERN_WARNING "Invalid MUX setting on 0x%02x (%d)\n",
+			e->reg, val);
+		ret = -1;
 	}
 
 	return ret;
@@ -810,14 +808,14 @@ static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
 	/* Output MUX controls */
 	/* Earpiece */
 	SND_SOC_DAPM_MUX_E("Earpiece Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_earpiece_control, outmixer_event,
+		&twl4030_dapm_earpiece_control, twl4030_enum_event,
 		SND_SOC_DAPM_PRE_REG),
 	/* PreDrivL/R */
 	SND_SOC_DAPM_MUX_E("PredriveL Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_predrivel_control, outmixer_event,
+		&twl4030_dapm_predrivel_control, twl4030_enum_event,
 		SND_SOC_DAPM_PRE_REG),
 	SND_SOC_DAPM_MUX_E("PredriveR Mux", SND_SOC_NOPM, 0, 0,
-		&twl4030_dapm_predriver_control, outmixer_event,
+		&twl4030_dapm_predriver_control, twl4030_enum_event,
 		SND_SOC_DAPM_PRE_REG),
 	/* HeadsetL/R */
 	SND_SOC_DAPM_MUX("HeadsetL Mux", SND_SOC_NOPM, 0, 0,
-- 
1.5.6.3
