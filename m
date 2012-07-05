From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - Always call standard unsolicited
	event
Date: Thu,  5 Jul 2012 12:00:12 +0200
Message-ID: <1341482413-7131-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id C56AB244A4
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2012 12:00:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org, 1021192@bugs.launchpad.net
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

With the model parsers out of the way, we have no custom unsol
events to worry about, we can therefore simplify the code.

In addition, this fixes a bug on the ASUS TC710, which has only
a headphone jack and a mic jack, but no internal mic or speakers.
Therefore the unsol_event pointer was not set, and as a result,
the jack kcontrols were not correctly updated.

BugLink: https://bugs.launchpad.net/bugs/1021192
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---

Alsa-info:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1021192/+attachment/3213783/+files/eb1030-bad-alsa-info.log

 sound/pci/hda/patch_realtek.c |   21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c2ff945..04e9243 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -174,7 +174,6 @@ struct alc_spec {
 
 	/* hooks */
 	void (*init_hook)(struct hda_codec *codec);
-	void (*unsol_event)(struct hda_codec *codec, unsigned int res);
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	void (*power_hook)(struct hda_codec *codec);
 #endif
@@ -688,7 +687,7 @@ static void alc_update_knob_master(struct hda_codec *codec, hda_nid_t nid)
 }
 
 /* unsolicited event for HP jack sensing */
-static void alc_sku_unsol_event(struct hda_codec *codec, unsigned int res)
+static void alc_unsol_event(struct hda_codec *codec, unsigned int res)
 {
 	int action;
 
@@ -1024,11 +1023,9 @@ static void alc_init_automute(struct hda_codec *codec)
 	spec->automute_lo = spec->automute_lo_possible;
 	spec->automute_speaker = spec->automute_speaker_possible;
 
-	if (spec->automute_speaker_possible || spec->automute_lo_possible) {
+	if (spec->automute_speaker_possible || spec->automute_lo_possible)
 		/* create a control for automute mode */
 		alc_add_automute_mode_enum(codec);
-		spec->unsol_event = alc_sku_unsol_event;
-	}
 }
 
 /* return the position of NID in the list, or -1 if not found */
@@ -1191,7 +1188,6 @@ static void alc_init_auto_mic(struct hda_codec *codec)
 
 	snd_printdd("realtek: Enable auto-mic switch on NID 0x%x/0x%x/0x%x\n",
 		    ext, fixed, dock);
-	spec->unsol_event = alc_sku_unsol_event;
 }
 
 /* check the availabilities of auto-mute and auto-mic switches */
@@ -2062,14 +2058,6 @@ static int alc_init(struct hda_codec *codec)
 	return 0;
 }
 
-static void alc_unsol_event(struct hda_codec *codec, unsigned int res)
-{
-	struct alc_spec *spec = codec->spec;
-
-	if (spec->unsol_event)
-		spec->unsol_event(codec, res);
-}
-
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 static int alc_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 {
@@ -4271,14 +4259,12 @@ static void set_capture_mixer(struct hda_codec *codec)
  */
 static void alc_auto_init_std(struct hda_codec *codec)
 {
-	struct alc_spec *spec = codec->spec;
 	alc_auto_init_multi_out(codec);
 	alc_auto_init_extra_out(codec);
 	alc_auto_init_analog_input(codec);
 	alc_auto_init_input_src(codec);
 	alc_auto_init_digital(codec);
-	if (spec->unsol_event)
-		alc_inithook(codec);
+	alc_inithook(codec);
 }
 
 /*
@@ -4879,7 +4865,6 @@ static void alc260_fixup_gpio1_toggle(struct hda_codec *codec,
 		spec->automute_speaker = 1;
 		spec->autocfg.hp_pins[0] = 0x0f; /* copy it for automute */
 		snd_hda_jack_detect_enable(codec, 0x0f, ALC_HP_EVENT);
-		spec->unsol_event = alc_sku_unsol_event;
 		snd_hda_gen_add_verbs(&spec->gen, alc_gpio1_init_verbs);
 	}
 }
-- 
1.7.9.5
