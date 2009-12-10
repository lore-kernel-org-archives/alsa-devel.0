From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] opti93x: move controls definitions to opti93x
	driver
Date: Thu, 10 Dec 2009 20:40:18 +0100
Message-ID: <20091210204018.0106f136.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp240.poczta.interia.pl (smtp240.poczta.interia.pl
	[217.74.64.240])
	by alsa0.perex.cz (Postfix) with ESMTP id C075B10385F
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 20:38:26 +0100 (CET)
Received: from poczta.interia.pl (mi05.te.interia.pl [10.217.12.5])
	by smtp240.poczta.interia.pl (INTERIA.PL) with ESMTP id 378052704AC
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 20:38:26 +0100 (CET)
Received: from krzysio.net (93-181-133-4.as.kn.pl [93.181.133.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.poczta.fm (INTERIA.PL) with ESMTP id A42B3BE1876
	for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2009 20:38:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Move OPTi93x controls definitions to the opti93x driver
from the common wss-lib library module. These controls
are used only by the opti93x driver.

Also, fix capture source names. They are the same as
opl3sa2 names.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 sound/isa/opti9xx/opti92x-ad1848.c |   85 ++++++++++++++++++++++++++++++++++++
 sound/isa/wss/wss_lib.c            |   80 ++++++---------------------------
 2 files changed, 100 insertions(+), 65 deletions(-)

diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index d8eac3f..0991321 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -33,6 +33,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <sound/core.h>
+#include <sound/tlv.h>
 #include <sound/wss.h>
 #include <sound/mpu401.h>
 #include <sound/opl3.h>
@@ -546,6 +547,85 @@ __skip_mpu:
 
 #ifdef OPTi93X
 
+static const DECLARE_TLV_DB_SCALE(db_scale_6bit, -9450, 150, 0);
+
+static struct snd_kcontrol_new snd_opti93x_controls[] = {
+WSS_DOUBLE("Master Playback Switch", 0,
+		OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 7, 7, 1, 1),
+WSS_DOUBLE_TLV("Master Playback Volume", 0,
+		OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 1, 1, 31, 1,
+		db_scale_6bit),
+WSS_DOUBLE("PCM Playback Volume", 0,
+		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 31, 1),
+WSS_DOUBLE("FM Playback Volume", 0,
+		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 1, 1, 15, 1),
+WSS_DOUBLE("Line Playback Switch", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
+WSS_DOUBLE("Line Playback Volume", 0,
+		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 15, 1),
+WSS_DOUBLE("Mic Playback Switch", 0,
+		OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("Mic Playback Volume", 0,
+		OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 1, 1, 15, 1),
+WSS_DOUBLE("CD Playback Volume", 0,
+		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 1, 1, 15, 1),
+WSS_DOUBLE("Aux Playback Switch", 0,
+		OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 7, 7, 1, 1),
+WSS_DOUBLE("Aux Playback Volume", 0,
+		OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 1, 1, 15, 1),
+};
+
+static int __devinit snd_opti93x_mixer(struct snd_wss *chip)
+{
+	struct snd_card *card;
+	unsigned int idx;
+	struct snd_ctl_elem_id id1, id2;
+	int err;
+
+	if (snd_BUG_ON(!chip || !chip->pcm))
+		return -EINVAL;
+
+	card = chip->card;
+
+	strcpy(card->mixername, chip->pcm->name);
+
+	memset(&id1, 0, sizeof(id1));
+	memset(&id2, 0, sizeof(id2));
+	id1.iface = id2.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	/* reassign AUX0 switch to CD */
+	strcpy(id1.name, "Aux Playback Switch");
+	strcpy(id2.name, "CD Playback Switch");
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0) {
+		snd_printk(KERN_ERR "Cannot rename opti93x control\n");
+		return err;
+	}
+	/* reassign AUX1 switch to FM */
+	strcpy(id1.name, "Aux Playback Switch"); id1.index = 1;
+	strcpy(id2.name, "FM Playback Switch");
+	err = snd_ctl_rename_id(card, &id1, &id2);
+	if (err < 0) {
+		snd_printk(KERN_ERR "Cannot rename opti93x control\n");
+		return err;
+	}
+	/* remove AUX1 volume */
+	strcpy(id1.name, "Aux Playback Volume"); id1.index = 1;
+	snd_ctl_remove_id(card, &id1);
+
+	/* Replace WSS volume controls with OPTi93x volume controls */
+	id1.index = 0;
+	for (idx = 0; idx < ARRAY_SIZE(snd_opti93x_controls); idx++) {
+		strcpy(id1.name, snd_opti93x_controls[idx].name);
+		snd_ctl_remove_id(card, &id1);
+
+		err = snd_ctl_add(card,
+				snd_ctl_new1(&snd_opti93x_controls[idx], chip));
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
 static irqreturn_t snd_opti93x_interrupt(int irq, void *dev_id)
 {
 	struct snd_opti9xx *chip = dev_id;
@@ -754,6 +834,11 @@ static int __devinit snd_opti9xx_probe(struct snd_card *card)
 	error = snd_wss_mixer(codec);
 	if (error < 0)
 		return error;
+#ifdef OPTi93X
+	error = snd_opti93x_mixer(codec);
+	if (error < 0)
+		return error;
+#endif
 #ifdef CS4231
 	error = snd_wss_timer(codec, 0, &timer);
 	if (error < 0)
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 5b9d6c1..9191b32 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -2014,6 +2014,7 @@ static int snd_wss_info_mux(struct snd_kcontrol *kcontrol,
 	case WSS_HW_INTERWAVE:
 		ptexts = gusmax_texts;
 		break;
+	case WSS_HW_OPTI93X:
 	case WSS_HW_OPL3SA2:
 		ptexts = opl3sa_texts;
 		break;
@@ -2246,54 +2247,12 @@ WSS_SINGLE("Beep Bypass Playback Switch", 0,
 		CS4231_MONO_CTRL, 5, 1, 0),
 };
 
-static struct snd_kcontrol_new snd_opti93x_controls[] = {
-WSS_DOUBLE("Master Playback Switch", 0,
-		OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 7, 7, 1, 1),
-WSS_DOUBLE_TLV("Master Playback Volume", 0,
-		OPTi93X_OUT_LEFT, OPTi93X_OUT_RIGHT, 1, 1, 31, 1,
-		db_scale_6bit),
-WSS_DOUBLE("PCM Playback Switch", 0,
-		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 7, 7, 1, 1),
-WSS_DOUBLE("PCM Playback Volume", 0,
-		CS4231_LEFT_OUTPUT, CS4231_RIGHT_OUTPUT, 0, 0, 31, 1),
-WSS_DOUBLE("FM Playback Switch", 0,
-		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("FM Playback Volume", 0,
-		CS4231_AUX2_LEFT_INPUT, CS4231_AUX2_RIGHT_INPUT, 1, 1, 15, 1),
-WSS_DOUBLE("Line Playback Switch", 0,
-		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 7, 7, 1, 1),
-WSS_DOUBLE("Line Playback Volume", 0,
-		CS4231_LEFT_LINE_IN, CS4231_RIGHT_LINE_IN, 0, 0, 15, 1),
-WSS_DOUBLE("Mic Playback Switch", 0,
-		OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("Mic Playback Volume", 0,
-		OPTi93X_MIC_LEFT_INPUT, OPTi93X_MIC_RIGHT_INPUT, 1, 1, 15, 1),
-WSS_DOUBLE("Mic Boost", 0,
-		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 5, 5, 1, 0),
-WSS_DOUBLE("CD Playback Switch", 0,
-		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("CD Playback Volume", 0,
-		CS4231_AUX1_LEFT_INPUT, CS4231_AUX1_RIGHT_INPUT, 1, 1, 15, 1),
-WSS_DOUBLE("Aux Playback Switch", 0,
-		OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 7, 7, 1, 1),
-WSS_DOUBLE("Aux Playback Volume", 0,
-		OPTi931_AUX_LEFT_INPUT, OPTi931_AUX_RIGHT_INPUT, 1, 1, 15, 1),
-WSS_DOUBLE("Capture Volume", 0,
-		CS4231_LEFT_INPUT, CS4231_RIGHT_INPUT, 0, 0, 15, 0),
-{
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "Capture Source",
-	.info = snd_wss_info_mux,
-	.get = snd_wss_get_mux,
-	.put = snd_wss_put_mux,
-}
-};
-
 int snd_wss_mixer(struct snd_wss *chip)
 {
 	struct snd_card *card;
 	unsigned int idx;
 	int err;
+	int count = ARRAY_SIZE(snd_wss_controls);
 
 	if (snd_BUG_ON(!chip || !chip->pcm))
 		return -EINVAL;
@@ -2302,28 +2261,19 @@ int snd_wss_mixer(struct snd_wss *chip)
 
 	strcpy(card->mixername, chip->pcm->name);
 
-	if (chip->hardware == WSS_HW_OPTI93X)
-		for (idx = 0; idx < ARRAY_SIZE(snd_opti93x_controls); idx++) {
-			err = snd_ctl_add(card,
-					snd_ctl_new1(&snd_opti93x_controls[idx],
-						     chip));
-			if (err < 0)
-				return err;
-		}
-	else {
-		int count = ARRAY_SIZE(snd_wss_controls);
-
-		/* Use only the first 11 entries on AD1848 */
-		if (chip->hardware & WSS_HW_AD1848_MASK)
-			count = 11;
-
-		for (idx = 0; idx < count; idx++) {
-			err = snd_ctl_add(card,
-					snd_ctl_new1(&snd_wss_controls[idx],
-						     chip));
-			if (err < 0)
-				return err;
-		}
+	/* Use only the first 11 entries on AD1848 */
+	if (chip->hardware & WSS_HW_AD1848_MASK)
+		count = 11;
+	/* There is no loopback on OPTI93X */
+	else if (chip->hardware == WSS_HW_OPTI93X)
+		count = 9;
+
+	for (idx = 0; idx < count; idx++) {
+		err = snd_ctl_add(card,
+				snd_ctl_new1(&snd_wss_controls[idx],
+					     chip));
+		if (err < 0)
+			return err;
 	}
 	return 0;
 }
-- 
1.6.4


----------------------------------------------------------------------
Internetowi nie placa! Otworz Konto Direct.
http://link.interia.pl/f24f7
