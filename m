From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH] Fixup automute for Realtek auto parser
Date: Fri, 16 Sep 2011 11:22:01 +0200
Message-ID: <4E731539.6050509@canonical.com>
References: <4E73026C.5090307@canonical.com> <s5hpqj0nb0m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050207030404040202010807"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 4E1702415E
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 11:22:02 +0200 (CEST)
In-Reply-To: <s5hpqj0nb0m.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050207030404040202010807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/16/2011 10:31 AM, Takashi Iwai wrote:
> At Fri, 16 Sep 2011 10:01:48 +0200,
> David Henningsson wrote:
>>
>> The ~6 months old functionality for configurable automuting is broken
>> for the case that the user has only HP and LO (no speakers) - basically
>> there is an "Automute mode" control, but enabling it does nothing. While
>> fixing that, I also took the liberty of refactoring/rewriting some of
>> that code, in order to make it easier to understand and maintain.
>>
>> Takashi, given you approve/like these changes, I'll go ahead and fix up
>> the quirk files to fit the new variable names.
>
> I'm fine with renames but let's split patches: first fix the bug
> of non-working auto-mute control, then refactoring.  The former
> should go to 3.1 while the latter is queued to 3.2.

Ok. If it also should go to 3.0, feel free to add cc: stable@kernel.org 
(hmm, is that working even though kernel.org is down?)

Here comes the 3.1 part of the patch. If you're happy with it, commit it 
and I'll continue with the 3.2 renames.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------050207030404040202010807
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Fix-Realtek-automute-for-Headphone-to-Line-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Fix-Realtek-automute-for-Headphone-to-Line-.pa";
 filename*1="tch"

>From f57b75cf26dc8c858bdb5f84babb9962c72a02ac Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 16 Sep 2011 11:12:04 +0200
Subject: [PATCH] ALSA: HDA: Fix Realtek automute for Headphone to Line Out

If the machine has "Headphone out" and "Line Out", but no
"Speaker out", the Realtek autoparser currently creates an
Automute kcontrol, but it isn't working. This patch enables
automuting of "Line out" when headphones are plugged, provided
that the automute kcontrol is set to "enabled".

BugLink: http://bugs.launchpad.net/bugs/851697
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_realtek.c |   92 ++++++++++++++++++++++++-----------------
 1 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 70ba45e..8dff8d2 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -167,10 +167,12 @@ struct alc_spec {
 	unsigned int master_mute:1;
 	unsigned int auto_mic:1;
 	unsigned int auto_mic_valid_imux:1;	/* valid imux for auto-mic */
-	unsigned int automute:1;	/* HP automute enabled */
+	unsigned int automute:1;	/* Speaker automute enabled */
+	unsigned int detect_hp:1;		/* Headphones detection enabled */
 	unsigned int detect_line:1;	/* Line-out detection enabled */
 	unsigned int automute_lines:1;	/* automute line-out as well */
-	unsigned int automute_hp_lo:1;	/* both HP and LO available */
+	unsigned int automute_speaker_possible:1;	/* there are speakers and either LO or HP */
+	unsigned int automute_lo_possible:1;		/* there are line outs and HP */
 
 	/* other flags */
 	unsigned int no_analog :1; /* digital I/O only */
@@ -556,7 +558,7 @@ static void update_speakers(struct hda_codec *codec)
 	if (spec->autocfg.line_out_pins[0] == spec->autocfg.hp_pins[0] ||
 	    spec->autocfg.line_out_pins[0] == spec->autocfg.speaker_pins[0])
 		return;
-	if (!spec->automute_lines || !spec->automute)
+	if (!spec->automute_lines)
 		on = 0;
 	else
 		on = spec->jack_present;
@@ -582,7 +584,7 @@ static void alc_hp_automute(struct hda_codec *codec)
 	spec->jack_present =
 		detect_jacks(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
 			     spec->autocfg.hp_pins);
-	if (!spec->automute)
+	if (!spec->detect_hp || (!spec->automute && !spec->automute_lines))
 		return;
 	call_update_speakers(codec);
 }
@@ -795,7 +797,7 @@ static int alc_automute_mode_info(struct snd_kcontrol *kcontrol,
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	if (spec->automute_hp_lo) {
+	if (spec->automute_speaker_possible && spec->automute_lo_possible) {
 		uinfo->value.enumerated.items = 3;
 		texts = texts3;
 	} else {
@@ -814,13 +816,12 @@ static int alc_automute_mode_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct alc_spec *spec = codec->spec;
-	unsigned int val;
-	if (!spec->automute)
-		val = 0;
-	else if (!spec->automute_lines)
-		val = 1;
-	else
-		val = 2;
+	unsigned int val = 0;
+	if (spec->automute)
+		val++;
+	if (spec->automute_lines)
+		val++;
+
 	ucontrol->value.enumerated.item[0] = val;
 	return 0;
 }
@@ -833,18 +834,29 @@ static int alc_automute_mode_put(struct snd_kcontrol *kcontrol,
 
 	switch (ucontrol->value.enumerated.item[0]) {
 	case 0:
-		if (!spec->automute)
+		if (!spec->automute && !spec->automute_lines)
 			return 0;
 		spec->automute = 0;
+		spec->automute_lines = 0;
 		break;
 	case 1:
-		if (spec->automute && !spec->automute_lines)
-			return 0;
-		spec->automute = 1;
-		spec->automute_lines = 0;
+		if (spec->automute_speaker_possible) {
+			if (!spec->automute_lines && spec->automute)
+				return 0;
+			spec->automute = 1;
+			spec->automute_lines = 0;
+		} 
+		else if (spec->automute_lo_possible) {
+			if (spec->automute_lines)
+				return 0;
+			spec->automute_lines = 1;
+		}
+		else
+			return -EINVAL;
+
 		break;
 	case 2:
-		if (!spec->automute_hp_lo)
+		if (!spec->automute_lo_possible || !spec->automute_speaker_possible)
 			return -EINVAL;
 		if (spec->automute && spec->automute_lines)
 			return 0;
@@ -906,8 +918,6 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		present++;
 	if (present < 2) /* need two different output types */
 		return;
-	if (present == 3)
-		spec->automute_hp_lo = 1; /* both HP and LO automute */
 
 	if (!cfg->speaker_pins[0] &&
 	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
@@ -923,6 +933,8 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		cfg->hp_outs = cfg->line_outs;
 	}
 
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
+
 	for (i = 0; i < cfg->hp_outs; i++) {
 		hda_nid_t nid = cfg->hp_pins[i];
 		if (!is_jack_detectable(codec, nid))
@@ -932,28 +944,32 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		snd_hda_codec_write_cache(codec, nid, 0,
 				  AC_VERB_SET_UNSOLICITED_ENABLE,
 				  AC_USRSP_EN | ALC_HP_EVENT);
-		spec->automute = 1;
-		spec->automute_mode = ALC_AUTOMUTE_PIN;
-	}
-	if (spec->automute && cfg->line_out_pins[0] &&
-	    cfg->speaker_pins[0] &&
-	    cfg->line_out_pins[0] != cfg->hp_pins[0] &&
-	    cfg->line_out_pins[0] != cfg->speaker_pins[0]) {
-		for (i = 0; i < cfg->line_outs; i++) {
-			hda_nid_t nid = cfg->line_out_pins[i];
-			if (!is_jack_detectable(codec, nid))
-				continue;
-			snd_printdd("realtek: Enable Line-Out auto-muting "
-				    "on NID 0x%x\n", nid);
-			snd_hda_codec_write_cache(codec, nid, 0,
-					AC_VERB_SET_UNSOLICITED_ENABLE,
-					AC_USRSP_EN | ALC_FRONT_EVENT);
-			spec->detect_line = 1;
+		spec->detect_hp = 1;
+	}
+
+	if (cfg->line_out_type == AUTO_PIN_LINE_OUT && cfg->line_outs) {
+		if (cfg->speaker_outs)
+			for (i = 0; i < cfg->line_outs; i++) {
+				hda_nid_t nid = cfg->line_out_pins[i];
+				if (!is_jack_detectable(codec, nid))
+					continue;
+				snd_printdd("realtek: Enable Line-Out "
+					    "auto-muting on NID 0x%x\n", nid);
+				snd_hda_codec_write_cache(codec, nid, 0,
+						AC_VERB_SET_UNSOLICITED_ENABLE,
+						AC_USRSP_EN | ALC_FRONT_EVENT);
+				spec->detect_line = 1;
 		}
-		spec->automute_lines = spec->detect_line;
+		spec->automute_lo_possible = spec->detect_hp;
 	}
 
-	if (spec->automute) {
+	spec->automute_speaker_possible = cfg->speaker_outs && 
+		(spec->detect_hp || spec->detect_line);
+
+	spec->automute_lines = spec->automute_lo_possible;
+	spec->automute = spec->automute_speaker_possible;
+
+	if (spec->automute_speaker_possible || spec->automute_lo_possible) {
 		/* create a control for automute mode */
 		alc_add_automute_mode_enum(codec);
 		spec->unsol_event = alc_sku_unsol_event;
-- 
1.7.5.4


--------------050207030404040202010807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050207030404040202010807--
