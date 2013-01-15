From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/20] ALSA: hda - Add a new fixup type to
	override pinctl values
Date: Tue, 15 Jan 2013 12:05:39 +0100
Message-ID: <1358247947-13992-13-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD018265328
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 9A523A5230
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add a new fixup type, HDA_FIXUP_PINCTLS, for overriding the pinctl
values of the given pins.  It takes the same array of struct pintbl
like HDA_FIXUP_PINS, but each entry contains the pinctl value instead
of the pin default config value.

This patch also replaces the corresponding codes in patch_realtek.c.
Without this change, the direct call of verbs may be overridden again
by the later call of pinctl restoration by the driver.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_auto_parser.c | 15 +++++++++++++++
 sound/pci/hda/hda_local.h       |  1 +
 sound/pci/hda/patch_realtek.c   | 18 +++++++++---------
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/sound/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c
index e5b20219..55ed857 100644
--- a/sound/pci/hda/hda_auto_parser.c
+++ b/sound/pci/hda/hda_auto_parser.c
@@ -655,6 +655,13 @@ void snd_hda_apply_pincfgs(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_HDA(snd_hda_apply_pincfgs);
 
+static void set_pin_targets(struct hda_codec *codec,
+			    const struct hda_pintbl *cfg)
+{
+	for (; cfg->nid; cfg++)
+		snd_hda_set_pin_ctl_cache(codec, cfg->nid, cfg->val);
+}
+
 void snd_hda_apply_fixup(struct hda_codec *codec, int action)
 {
 	int id = codec->fixup_id;
@@ -694,6 +701,14 @@ void snd_hda_apply_fixup(struct hda_codec *codec, int action)
 				    codec->chip_name, modelname);
 			fix->v.func(codec, fix, action);
 			break;
+		case HDA_FIXUP_PINCTLS:
+			if (action != HDA_FIXUP_ACT_PROBE || !fix->v.pins)
+				break;
+			snd_printdd(KERN_INFO SFX
+				    "%s: Apply pinctl for %s\n",
+				    codec->chip_name, modelname);
+			set_pin_targets(codec, fix->v.pins);
+			break;
 		default:
 			snd_printk(KERN_ERR SFX
 				   "%s: Invalid fixup type %d\n",
diff --git a/sound/pci/hda/hda_local.h b/sound/pci/hda/hda_local.h
index aa721aa..c09440d 100644
--- a/sound/pci/hda/hda_local.h
+++ b/sound/pci/hda/hda_local.h
@@ -422,6 +422,7 @@ enum {
 	HDA_FIXUP_PINS,
 	HDA_FIXUP_VERBS,
 	HDA_FIXUP_FUNC,
+	HDA_FIXUP_PINCTLS,
 };
 
 /* fixup action definitions */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7a4b783..c8fcfa8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1794,9 +1794,9 @@ static const struct hda_fixup alc882_fixups[] = {
 		}
 	},
 	[ALC882_FIXUP_PB_M5210] = {
-		.type = HDA_FIXUP_VERBS,
-		.v.verbs = (const struct hda_verb[]) {
-			{ 0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50 },
+		.type = HDA_FIXUP_PINCTLS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, PIN_VREF50 },
 			{}
 		}
 	},
@@ -2158,9 +2158,9 @@ static const struct hda_fixup alc262_fixups[] = {
 		}
 	},
 	[ALC262_FIXUP_LENOVO_3000] = {
-		.type = HDA_FIXUP_VERBS,
-		.v.verbs = (const struct hda_verb[]) {
-			{ 0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREF50 },
+		.type = HDA_FIXUP_PINCTLS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, PIN_VREF50 },
 			{}
 		},
 		.chained = true,
@@ -2715,9 +2715,9 @@ enum {
 
 static const struct hda_fixup alc269_fixups[] = {
 	[ALC269_FIXUP_SONY_VAIO] = {
-		.type = HDA_FIXUP_VERBS,
-		.v.verbs = (const struct hda_verb[]) {
-			{0x19, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_VREFGRD},
+		.type = HDA_FIXUP_PINCTLS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{0x19, PIN_VREFGRD},
 			{}
 		}
 	},
-- 
1.8.1
