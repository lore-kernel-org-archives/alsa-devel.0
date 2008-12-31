From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [PATCH 1/2] ASoC: TWL4030: Make the enum filter
	generic for twl4030
Date: Wed, 31 Dec 2008 10:08:37 +0200
Message-ID: <1230710918-2741-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1230710918-2741-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 236BC1037FF
	for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2008 09:08:54 +0100 (CET)
In-Reply-To: <1230710918-2741-1-git-send-email-peter.ujfalusi@nokia.com>
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

Modify the enum filter to more generic that it will filter
out the enums with text "Invalid".
The enum filter also required for the capture path.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
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
1.6.0.6
