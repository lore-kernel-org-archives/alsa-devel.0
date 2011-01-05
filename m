From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: HDA: Fix volume control indices for Mics
	(Realtek)
Date: Wed, 05 Jan 2011 11:10:48 +0100
Message-ID: <4D2443A8.4090902@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020605080105020908050807"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id E33671038EF
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2011 11:10:50 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020605080105020908050807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch assumes you applied the "Boost" => "Boost Volume" patch 
posted yesterday.

If more than one mic is present with different locations,
e g "Front Mic" and "Rear Mic", they can use the same index (0),
since their names are different.

Previous behavior was to have "Front Mic" as index 1, causing it
to be ignored by e g PulseAudio.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------020605080105020908050807
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-volume-control-indices-for-Mics-Realtek.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-volume-control-indices-for-Mics-Realtek.pa";
 filename*1="tch"

>From 12d16508dec19b6897f6eca10fb38810a2762bc4 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Wed, 5 Jan 2011 11:03:56 +0100
Subject: [PATCH] ALSA: HDA: Fix volume control indices for Mics (Realtek)

If more than one mic is present with different locations,
e g "Front Mic" and "Rear Mic", they can use the same index (0),
since their names are different.

Previous behavior was to have "Front Mic" as index 1, causing it
to be ignored by e g PulseAudio.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 18d53d2..e2d2a79 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5200,7 +5200,8 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec,
 {
 	struct alc_spec *spec = codec->spec;
 	struct hda_input_mux *imux = &spec->private_imux[0];
-	int i, err, idx, type, type_idx = 0;
+	int i, err, idx, type_idx = 0;
+	const char *prev_label = NULL;
 
 	for (i = 0; i < cfg->num_inputs; i++) {
 		hda_nid_t pin;
@@ -5210,12 +5211,13 @@ static int alc_auto_create_input_ctls(struct hda_codec *codec,
 		if (!alc_is_input_pin(codec, pin))
 			continue;
 
-		type = cfg->inputs[i].type;
-		if (i > 0 && type == cfg->inputs[i - 1].type)
+		label = hda_get_autocfg_input_label(codec, cfg, i);
+		if (prev_label && !strcmp(label, prev_label))
 			type_idx++;
 		else
 			type_idx = 0;
-		label = hda_get_autocfg_input_label(codec, cfg, i);
+		prev_label = label;
+
 		if (mixer) {
 			idx = get_connection_index(codec, mixer, pin);
 			if (idx >= 0) {
@@ -10819,25 +10821,30 @@ static int alc_auto_add_mic_boost(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
-	int i, err, type;
+	int i, err;
 	int type_idx = 0;
 	hda_nid_t nid;
+	const char* prev_label = NULL;
 
 	for (i = 0; i < cfg->num_inputs; i++) {
 		if (cfg->inputs[i].type > AUTO_PIN_MIC)
 			break;
 		nid = cfg->inputs[i].pin;
 		if (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) {
-			char label[32];
-			type = cfg->inputs[i].type;
-			if (i > 0 && type == cfg->inputs[i - 1].type)
+			const char* label;
+			char boost_label[32];
+
+			label = hda_get_autocfg_input_label(codec, cfg, i);
+			if (prev_label && !strcmp(label, prev_label))
 				type_idx++;
 			else
 				type_idx = 0;
-			snprintf(label, sizeof(label), "%s Boost Volume",
-				 hda_get_autocfg_input_label(codec, cfg, i));
-			err = add_control(spec, ALC_CTL_WIDGET_VOL, label,
-					  type_idx,
+			prev_label = label;
+
+			snprintf(boost_label, sizeof(boost_label), 
+				 "%s Boost Volume", label);
+			err = add_control(spec, ALC_CTL_WIDGET_VOL, 
+					  boost_label, type_idx,
 				  HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT));
 			if (err < 0)
 				return err;
-- 
1.7.1


--------------020605080105020908050807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020605080105020908050807--
