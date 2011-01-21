From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 1/2] ALSA: HDA: Refactor some redundant code
 for Conexant 5066/205xx
Date: Fri, 21 Jan 2011 13:44:46 +0100
Message-ID: <4D397FBE.4020405@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090909050907040908000909"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B804245DC
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 13:44:52 +0100 (CET)
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.71 #1 (Debian))
	id 1PgGME-00067U-Mt
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 12:44:50 +0000
Received: from c-83-233-18-148.cust.bredband2.com ([83.233.18.148]
	helo=[192.168.8.102]) by hutte.canonical.com with esmtpsa
	(TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.71)
	(envelope-from <david.henningsson@canonical.com>) id 1PgGME-0002Wv-Ie
	for alsa-devel@alsa-project.org; Fri, 21 Jan 2011 12:44:50 +0000
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090909050907040908000909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Four very similar procedures - one for each model - now
refactored into one. This isn't all duplicated code, but a step
in the right direction.

(And given the next patch, that four procedures would have been five if 
it weren't for this one...)

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------090909050907040908000909
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Refactor-some-redundant-code-for-Conexant-5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ALSA-HDA-Refactor-some-redundant-code-for-Conexant-5.pa";
 filename*1="tch"

>From 140fce043955d745c33cbde9c95de6be7af758f2 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Fri, 21 Jan 2011 13:27:39 +0100
Subject: [PATCH 1/2] ALSA: HDA: Refactor some redundant code for Conexant 5066/205xx

Four very similar procedures - one for each model - now
refactored into one. This isn't all duplicated code, but a step
in the right direction.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_conexant.c |   81 +++++++++++----------------------------
 1 files changed, 23 insertions(+), 58 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 9bb030a..7cd59b9 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -2387,79 +2387,53 @@ static void cxt5066_hp_automute(struct hda_codec *codec)
 	cxt5066_update_speaker(codec);
 }
 
-/* unsolicited event for jack sensing */
-static void cxt5066_olpc_unsol_event(struct hda_codec *codec, unsigned int res)
+/* Dispatch the right mic autoswitch function */
+static void cxt5066_automic(struct hda_codec *codec)
 {
 	struct conexant_spec *spec = codec->spec;
-	snd_printdd("CXT5066: unsol event %x (%x)\n", res, res >> 26);
-	switch (res >> 26) {
-	case CONEXANT_HP_EVENT:
-		cxt5066_hp_automute(codec);
-		break;
-	case CONEXANT_MIC_EVENT:
-		/* ignore mic events in DC mode; we're always using the jack */
-		if (!spec->dc_enable)
-			cxt5066_olpc_automic(codec);
-		break;
-	}
-}
 
-/* unsolicited event for jack sensing */
-static void cxt5066_vostro_event(struct hda_codec *codec, unsigned int res)
-{
-	snd_printdd("CXT5066_vostro: unsol event %x (%x)\n", res, res >> 26);
-	switch (res >> 26) {
-	case CONEXANT_HP_EVENT:
-		cxt5066_hp_automute(codec);
-		break;
-	case CONEXANT_MIC_EVENT:
+	if (spec->dell_vostro)
 		cxt5066_vostro_automic(codec);
-		break;
-	}
-}
-
-/* unsolicited event for jack sensing */
-static void cxt5066_ideapad_event(struct hda_codec *codec, unsigned int res)
-{
-	snd_printdd("CXT5066_ideapad: unsol event %x (%x)\n", res, res >> 26);
-	switch (res >> 26) {
-	case CONEXANT_HP_EVENT:
-		cxt5066_hp_automute(codec);
-		break;
-	case CONEXANT_MIC_EVENT:
+	else if (spec->ideapad)
 		cxt5066_ideapad_automic(codec);
-		break;
-	}
+	else if (spec->thinkpad)
+		cxt5066_thinkpad_automic(codec);
+	else if (spec->hp_laptop)
+		cxt5066_hp_laptop_automic(codec);
 }
 
 /* unsolicited event for jack sensing */
-static void cxt5066_hp_laptop_event(struct hda_codec *codec, unsigned int res)
+static void cxt5066_olpc_unsol_event(struct hda_codec *codec, unsigned int res)
 {
-	snd_printdd("CXT5066_hp_laptop: unsol event %x (%x)\n", res, res >> 26);
+	struct conexant_spec *spec = codec->spec;
+	snd_printdd("CXT5066: unsol event %x (%x)\n", res, res >> 26);
 	switch (res >> 26) {
 	case CONEXANT_HP_EVENT:
 		cxt5066_hp_automute(codec);
 		break;
 	case CONEXANT_MIC_EVENT:
-		cxt5066_hp_laptop_automic(codec);
+		/* ignore mic events in DC mode; we're always using the jack */
+		if (!spec->dc_enable)
+			cxt5066_olpc_automic(codec);
 		break;
 	}
 }
 
 /* unsolicited event for jack sensing */
-static void cxt5066_thinkpad_event(struct hda_codec *codec, unsigned int res)
+static void cxt5066_unsol_event(struct hda_codec *codec, unsigned int res)
 {
-	snd_printdd("CXT5066_thinkpad: unsol event %x (%x)\n", res, res >> 26);
+	snd_printdd("CXT5066: unsol event %x (%x)\n", res, res >> 26);
 	switch (res >> 26) {
 	case CONEXANT_HP_EVENT:
 		cxt5066_hp_automute(codec);
 		break;
 	case CONEXANT_MIC_EVENT:
-		cxt5066_thinkpad_automic(codec);
+		cxt5066_automic(codec);
 		break;
 	}
 }
 
+
 static const struct hda_input_mux cxt5066_analog_mic_boost = {
 	.num_items = 5,
 	.items = {
@@ -3039,20 +3013,11 @@ static struct hda_verb cxt5066_init_verbs_hp_laptop[] = {
 /* initialize jack-sensing, too */
 static int cxt5066_init(struct hda_codec *codec)
 {
-	struct conexant_spec *spec = codec->spec;
-
 	snd_printdd("CXT5066: init\n");
 	conexant_init(codec);
 	if (codec->patch_ops.unsol_event) {
 		cxt5066_hp_automute(codec);
-		if (spec->dell_vostro)
-			cxt5066_vostro_automic(codec);
-		else if (spec->ideapad)
-			cxt5066_ideapad_automic(codec);
-		else if (spec->thinkpad)
-			cxt5066_thinkpad_automic(codec);
-		else if (spec->hp_laptop)
-			cxt5066_hp_laptop_automic(codec);
+		cxt5066_automic(codec);
 	}
 	cxt5066_set_mic_boost(codec);
 	return 0;
@@ -3169,7 +3134,7 @@ static int patch_cxt5066(struct hda_codec *codec)
 		break;
 	case CXT5066_HP_LAPTOP:
 		codec->patch_ops.init = cxt5066_init;
-		codec->patch_ops.unsol_event = cxt5066_hp_laptop_event;
+		codec->patch_ops.unsol_event = cxt5066_unsol_event;
 		spec->init_verbs[spec->num_init_verbs] =
 			cxt5066_init_verbs_hp_laptop;
 		spec->num_init_verbs++;
@@ -3207,7 +3172,7 @@ static int patch_cxt5066(struct hda_codec *codec)
 		break;
 	case CXT5066_DELL_VOSTRO:
 		codec->patch_ops.init = cxt5066_init;
-		codec->patch_ops.unsol_event = cxt5066_vostro_event;
+		codec->patch_ops.unsol_event = cxt5066_unsol_event;
 		spec->init_verbs[0] = cxt5066_init_verbs_vostro;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master_olpc;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixers;
@@ -3224,7 +3189,7 @@ static int patch_cxt5066(struct hda_codec *codec)
 		break;
 	case CXT5066_IDEAPAD:
 		codec->patch_ops.init = cxt5066_init;
-		codec->patch_ops.unsol_event = cxt5066_ideapad_event;
+		codec->patch_ops.unsol_event = cxt5066_unsol_event;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixers;
 		spec->init_verbs[0] = cxt5066_init_verbs_ideapad;
@@ -3240,7 +3205,7 @@ static int patch_cxt5066(struct hda_codec *codec)
 		break;
 	case CXT5066_THINKPAD:
 		codec->patch_ops.init = cxt5066_init;
-		codec->patch_ops.unsol_event = cxt5066_thinkpad_event;
+		codec->patch_ops.unsol_event = cxt5066_unsol_event;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixer_master;
 		spec->mixers[spec->num_mixers++] = cxt5066_mixers;
 		spec->init_verbs[0] = cxt5066_init_verbs_thinkpad;
-- 
1.7.1


--------------090909050907040908000909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------090909050907040908000909--
