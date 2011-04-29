From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/10] ALSA: hda - Add Auto-Mute Mode enum for
	two-output cases
Date: Fri, 29 Apr 2011 19:18:36 +0200
Message-ID: <1304097516-7258-11-git-send-email-tiwai@suse.de>
References: <1304097516-7258-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 4F9E3103A3A
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:12 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id E4EA087567
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 19:19:10 +0200 (CEST)
In-Reply-To: <1304097516-7258-1-git-send-email-tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

The Auto-Mute Mode control is useful even when only two outputs
(e.g. HP and speaker) are available.  Then user can enable/disable
the auto-mute behavior on the fly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_realtek.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3e41d56..faede0f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -397,6 +397,7 @@ struct alc_spec {
 	unsigned int automute:1;	/* HP automute enabled */
 	unsigned int detect_line:1;	/* Line-out detection enabled */
 	unsigned int automute_lines:1;	/* automute line-out as well */
+	unsigned int automute_hp_lo:1;	/* both HP and LO available */
 
 	/* other flags */
 	unsigned int no_analog :1; /* digital I/O only */
@@ -1427,15 +1428,27 @@ static void alc_auto_init_amp(struct hda_codec *codec, int type)
 static int alc_automute_mode_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
-	static const char * const texts[] = {
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct alc_spec *spec = codec->spec;
+	static const char * const texts2[] = {
+		"Disabled", "Enabled"
+	};
+	static const char * const texts3[] = {
 		"Disabled", "Speaker Only", "Line-Out+Speaker"
 	};
+	const char * const *texts;
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	uinfo->value.enumerated.items = 3;
-	if (uinfo->value.enumerated.item >= 3)
-		uinfo->value.enumerated.item = 2;
+	if (spec->automute_hp_lo) {
+		uinfo->value.enumerated.items = 3;
+		texts = texts3;
+	} else {
+		uinfo->value.enumerated.items = 2;
+		texts = texts2;
+	}
+	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
+		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
 	strcpy(uinfo->value.enumerated.name,
 	       texts[uinfo->value.enumerated.item]);
 	return 0;
@@ -1476,6 +1489,8 @@ static int alc_automute_mode_put(struct snd_kcontrol *kcontrol,
 		spec->automute_lines = 0;
 		break;
 	case 2:
+		if (!spec->automute_hp_lo)
+			return -EINVAL;
 		if (spec->automute && spec->automute_lines)
 			return 0;
 		spec->automute = 1;
@@ -1528,6 +1543,8 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		present++;
 	if (present < 2) /* need two different output types */
 		return;
+	if (present == 3)
+		spec->automute_hp_lo = 1; /* both HP and LO automute */
 
 	if (!cfg->speaker_pins[0]) {
 		memcpy(cfg->speaker_pins, cfg->line_out_pins,
@@ -1569,11 +1586,14 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 					AC_USRSP_EN | ALC880_FRONT_EVENT);
 			spec->detect_line = 1;
 		}
+		spec->automute_lines = 1;
+	}
+
+	if (spec->automute) {
 		/* create a control for automute mode */
 		alc_add_automute_mode_enum(codec);
-		spec->automute_lines = 1;
+		spec->unsol_event = alc_sku_unsol_event;
 	}
-	spec->unsol_event = alc_sku_unsol_event;
 }
 
 static void alc_init_auto_mic(struct hda_codec *codec)
-- 
1.7.4.2
