From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: hda - Adjust power of beep widget
	and outputs
Date: Wed, 18 Mar 2015 09:50:58 +0100
Message-ID: <1426668658-15911-5-git-send-email-tiwai@suse.de>
References: <1426668658-15911-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D70C2604F4
 for <alsa-devel@alsa-project.org>; Wed, 18 Mar 2015 09:51:01 +0100 (CET)
In-Reply-To: <1426668658-15911-1-git-send-email-tiwai@suse.de>
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

As the widget PM may turn off the pins, this might lead to the silent
output for beep when no explicit paths are given.  This patch adds
fake output paths for the beep widget so that the output pins are
dynamically powered upon beep on/off.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c    | 29 ++++++++++---------
 sound/pci/hda/hda_beep.h    |  1 +
 sound/pci/hda/hda_generic.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 581b7fdef0e3..4cdac3a71cae 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -33,30 +33,36 @@ enum {
 	DIGBEEP_HZ_MAX = 12000000,	/* 12 KHz */
 };
 
-static void snd_hda_generate_beep(struct work_struct *work)
+/* generate or stop tone */
+static void generate_tone(struct hda_beep *beep, int tone)
 {
-	struct hda_beep *beep =
-		container_of(work, struct hda_beep, beep_work);
 	struct hda_codec *codec = beep->codec;
-	int tone;
 
-	if (!beep->enabled)
-		return;
-
-	tone = beep->tone;
 	if (tone && !beep->playing) {
 		snd_hda_power_up(codec);
+		if (beep->power_hook)
+			beep->power_hook(beep, true);
 		beep->playing = 1;
 	}
-	/* generate tone */
 	snd_hda_codec_write(codec, beep->nid, 0,
 			    AC_VERB_SET_BEEP_CONTROL, tone);
 	if (!tone && beep->playing) {
 		beep->playing = 0;
+		if (beep->power_hook)
+			beep->power_hook(beep, false);
 		snd_hda_power_down(codec);
 	}
 }
 
+static void snd_hda_generate_beep(struct work_struct *work)
+{
+	struct hda_beep *beep =
+		container_of(work, struct hda_beep, beep_work);
+
+	if (beep->enabled)
+		generate_tone(beep, beep->tone);
+}
+
 /* (non-standard) Linear beep tone calculation for IDT/STAC codecs 
  *
  * The tone frequency of beep generator on IDT/STAC codecs is
@@ -130,10 +136,7 @@ static void turn_off_beep(struct hda_beep *beep)
 	cancel_work_sync(&beep->beep_work);
 	if (beep->playing) {
 		/* turn off beep */
-		snd_hda_codec_write(beep->codec, beep->nid, 0,
-				    AC_VERB_SET_BEEP_CONTROL, 0);
-		beep->playing = 0;
-		snd_hda_power_down(beep->codec);
+		generate_tone(beep, 0);
 	}
 }
 
diff --git a/sound/pci/hda/hda_beep.h b/sound/pci/hda/hda_beep.h
index a63b5e077332..46524ff7e79e 100644
--- a/sound/pci/hda/hda_beep.h
+++ b/sound/pci/hda/hda_beep.h
@@ -40,6 +40,7 @@ struct hda_beep {
 	unsigned int playing:1;
 	struct work_struct beep_work; /* scheduled task for beep event */
 	struct mutex mutex;
+	void (*power_hook)(struct hda_beep *beep, bool on);
 };
 
 #ifdef CONFIG_SND_HDA_INPUT_BEEP
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8a5055d296f5..d7ca388651da 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -654,6 +654,9 @@ static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
 	int type = get_wcaps_type(get_wcaps(codec, nid));
 	int i, n;
 
+	if (nid == codec->afg)
+		return true;
+
 	for (n = 0; n < spec->paths.used; n++) {
 		struct nid_path *path = snd_array_elem(&spec->paths, n);
 		if (!path->active)
@@ -829,6 +832,8 @@ static hda_nid_t path_power_update(struct hda_codec *codec,
 
 	for (i = 0; i < path->depth; i++) {
 		nid = path->path[i];
+		if (nid == codec->afg)
+			continue;
 		if (!allow_powerdown || is_active_nid_for_any(codec, nid))
 			state = AC_PWRST_D0;
 		else
@@ -4073,6 +4078,64 @@ static void sync_all_pin_power_ctls(struct hda_codec *codec)
 		sync_pin_power_ctls(codec, 1, &cfg->inputs[i].pin);
 }
 
+/* add fake paths if not present yet */
+static int add_fake_paths(struct hda_codec *codec, hda_nid_t nid,
+			   int num_pins, const hda_nid_t *pins)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct nid_path *path;
+	int i;
+
+	for (i = 0; i < num_pins; i++) {
+		if (!pins[i])
+			break;
+		if (get_nid_path(codec, nid, pins[i], 0))
+			continue;
+		path = snd_array_new(&spec->paths);
+		if (!path)
+			return -ENOMEM;
+		memset(path, 0, sizeof(*path));
+		path->depth = 2;
+		path->path[0] = nid;
+		path->path[1] = pins[i];
+		path->active = true;
+	}
+	return 0;
+}
+
+/* create fake paths to all outputs from beep */
+static int add_fake_beep_paths(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	hda_nid_t nid = spec->beep_nid;
+	int err;
+
+	if (!codec->power_mgmt || !nid)
+		return 0;
+	err = add_fake_paths(codec, nid, cfg->line_outs, cfg->line_out_pins);
+	if (err < 0)
+		return err;
+	if (cfg->line_out_type != AUTO_PIN_HP_OUT) {
+		err = add_fake_paths(codec, nid, cfg->hp_outs, cfg->hp_pins);
+		if (err < 0)
+			return err;
+	}
+	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+		err = add_fake_paths(codec, nid, cfg->speaker_outs,
+				     cfg->speaker_pins);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+/* power up/down beep widget and its output paths */
+static void beep_power_hook(struct hda_beep *beep, bool on)
+{
+	set_path_power(beep->codec, beep->nid, -1, on);
+}
+
 /*
  * Jack detections for HP auto-mute and mic-switch
  */
@@ -4837,6 +4900,12 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 		err = snd_hda_attach_beep_device(codec, spec->beep_nid);
 		if (err < 0)
 			return err;
+		if (codec->beep && codec->power_mgmt) {
+			err = add_fake_beep_paths(codec);
+			if (err < 0)
+				return err;
+			codec->beep->power_hook = beep_power_hook;
+		}
 	}
 
 	return 1;
-- 
2.3.3
