From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/3] ALSA: hda - Handle error from
	snd_hda_power_up*()
Date: Wed, 27 Jun 2018 11:10:32 +0200
Message-ID: <20180627091034.22724-2-tiwai@suse.de>
References: <20180627091034.22724-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id F00292677C9
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 11:10:39 +0200 (CEST)
In-Reply-To: <20180627091034.22724-1-tiwai@suse.de>
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
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: alsa-devel@alsa-project.org

Although snd_hda_power_up() and snd_hda_power_up_pm() may fail, we
haven't dealt with the error properly in many places.  It's an unusual
situation but still possible.

This patch spots these places and adds the proper error paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_beep.c       |  3 +-
 sound/pci/hda/hda_codec.c      |  4 ++-
 sound/pci/hda/hda_controller.c |  4 ++-
 sound/pci/hda/hda_proc.c       |  3 +-
 sound/pci/hda/hda_sysfs.c      |  4 ++-
 sound/pci/hda/patch_ca0132.c   | 53 +++++++++++++++++++++++++++-------
 sound/pci/hda/patch_realtek.c  |  3 +-
 7 files changed, 57 insertions(+), 17 deletions(-)

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 066b5b59c4d7..e9d5fbd6c13a 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -26,7 +26,8 @@ static void generate_tone(struct hda_beep *beep, int tone)
 	struct hda_codec *codec = beep->codec;
 
 	if (tone && !beep->playing) {
-		snd_hda_power_up(codec);
+		if (snd_hda_power_up(codec) < 0)
+			return;
 		if (beep->power_hook)
 			beep->power_hook(beep, true);
 		beep->playing = 1;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 20a171ac4bb2..44165f3e344e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -65,7 +65,9 @@ static int codec_exec_verb(struct hdac_device *dev, unsigned int cmd,
 		return -1;
 
  again:
-	snd_hda_power_up_pm(codec);
+	err = snd_hda_power_up_pm(codec);
+	if (err < 0)
+		return err;
 	mutex_lock(&bus->core.cmd_mutex);
 	if (flags & HDA_RW_NO_RESPONSE_FALLBACK)
 		bus->no_response_fallback = 1;
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index a12e594d4e3b..4273be1f3eaa 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -645,7 +645,9 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 				   buff_step);
 	snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
 				   buff_step);
-	snd_hda_power_up(apcm->codec);
+	err = snd_hda_power_up(apcm->codec);
+	if (err < 0)
+		return err;
 	if (hinfo->ops.open)
 		err = hinfo->ops.open(hinfo, apcm->codec, substream);
 	else
diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
index c6b778b2580c..4206749d5130 100644
--- a/sound/pci/hda/hda_proc.c
+++ b/sound/pci/hda/hda_proc.c
@@ -760,7 +760,8 @@ static void print_codec_info(struct snd_info_entry *entry,
 	fg = codec->core.afg;
 	if (!fg)
 		return;
-	snd_hda_power_up(codec);
+	if (snd_hda_power_up(codec) < 0)
+		return;
 	snd_iprintf(buffer, "Default PCM:\n");
 	print_pcm_caps(buffer, codec, fg);
 	snd_iprintf(buffer, "Default Amp-In caps: ");
diff --git a/sound/pci/hda/hda_sysfs.c b/sound/pci/hda/hda_sysfs.c
index 6ec79c58d48d..d17a808e72d2 100644
--- a/sound/pci/hda/hda_sysfs.c
+++ b/sound/pci/hda/hda_sysfs.c
@@ -130,7 +130,9 @@ static int reconfig_codec(struct hda_codec *codec)
 {
 	int err;
 
-	snd_hda_power_up(codec);
+	err = snd_hda_power_up(codec);
+	if (err < 0)
+		return err;
 	codec_info(codec, "hda-codec: reconfiguring\n");
 	err = snd_hda_codec_reset(codec);
 	if (err < 0) {
diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 4ff5320378e2..3b58f6032250 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -3575,12 +3575,15 @@ static int tuning_ctl_set(struct hda_codec *codec, hda_nid_t nid,
 			  unsigned int *lookup, int idx)
 {
 	int i = 0;
+	int err;
 
 	for (i = 0; i < TUNING_CTLS_COUNT; i++)
 		if (nid == ca0132_tuning_ctls[i].nid)
 			break;
 
-	snd_hda_power_up(codec);
+	err = snd_hda_power_up(codec);
+	if (err < 0)
+		return err;
 	dspio_set_param(codec, ca0132_tuning_ctls[i].mid, 0x20,
 			ca0132_tuning_ctls[i].req,
 			&(lookup[idx]), sizeof(unsigned int));
@@ -3801,7 +3804,9 @@ static int ca0132_select_out(struct hda_codec *codec)
 
 	codec_dbg(codec, "ca0132_select_out\n");
 
-	snd_hda_power_up_pm(codec);
+	err = snd_hda_power_up_pm(codec);
+	if (err < 0)
+		return err;
 
 	auto_jack = spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID];
 
@@ -3914,7 +3919,9 @@ static int ca0132_alt_select_out(struct hda_codec *codec)
 
 	codec_dbg(codec, "%s\n", __func__);
 
-	snd_hda_power_up_pm(codec);
+	err = snd_hda_power_up_pm(codec);
+	if (err < 0)
+		return err;
 
 	auto_jack = spec->vnode_lswitch[VNID_HP_ASEL - VNODE_START_NID];
 
@@ -4225,10 +4232,13 @@ static int ca0132_select_mic(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 	int jack_present;
 	int auto_jack;
+	int err;
 
 	codec_dbg(codec, "ca0132_select_mic\n");
 
-	snd_hda_power_up_pm(codec);
+	err = snd_hda_power_up_pm(codec);
+	if (err < 0)
+		return err;
 
 	auto_jack = spec->vnode_lswitch[VNID_AMIC1_ASEL - VNODE_START_NID];
 
@@ -4276,10 +4286,13 @@ static int ca0132_alt_select_in(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
 	unsigned int tmp;
+	int err;
 
 	codec_dbg(codec, "%s\n", __func__);
 
-	snd_hda_power_up_pm(codec);
+	err = snd_hda_power_up_pm(codec);
+	if (err < 0)
+		return err;
 
 	chipio_set_stream_control(codec, 0x03, 0);
 	chipio_set_stream_control(codec, 0x04, 0);
@@ -4701,6 +4714,8 @@ static int ca0132_alt_slider_ctl_set(struct hda_codec *codec, hda_nid_t nid,
 {
 	int i = 0;
 	unsigned int y;
+	int err;
+
 	/*
 	 * For X_BASS, req 2 is actually crossover freq instead of
 	 * effect level
@@ -4710,7 +4725,9 @@ static int ca0132_alt_slider_ctl_set(struct hda_codec *codec, hda_nid_t nid,
 	else
 		y = 1;
 
-	snd_hda_power_up(codec);
+	err = snd_hda_power_up(codec);
+	if (err < 0)
+		return err;
 	if (nid == XBASS_XOVER) {
 		for (i = 0; i < OUT_EFFECTS_COUNT; i++)
 			if (ca0132_effects[i].nid == X_BASS)
@@ -5221,11 +5238,14 @@ static int ca0132_switch_put(struct snd_kcontrol *kcontrol,
 	int ch = get_amp_channels(kcontrol);
 	long *valp = ucontrol->value.integer.value;
 	int changed = 1;
+	int err;
 
 	codec_dbg(codec, "ca0132_switch_put: nid=0x%x, val=%ld\n",
 		    nid, *valp);
 
-	snd_hda_power_up(codec);
+	err = snd_hda_power_up(codec);
+	if (err < 0)
+		return err;
 	/* vnode */
 	if ((nid >= VNODE_START_NID) && (nid < VNODE_END_NID)) {
 		if (ch & 1) {
@@ -5390,6 +5410,7 @@ static int ca0132_volume_put(struct snd_kcontrol *kcontrol,
 	hda_nid_t shared_nid = 0;
 	bool effective;
 	int changed = 1;
+	int err;
 
 	/* store the left and right volume */
 	if (ch & 1) {
@@ -5407,7 +5428,9 @@ static int ca0132_volume_put(struct snd_kcontrol *kcontrol,
 		int dir = get_amp_direction(kcontrol);
 		unsigned long pval;
 
-		snd_hda_power_up(codec);
+		err = snd_hda_power_up(codec);
+		if (err < 0)
+			return err;
 		mutex_lock(&codec->control_mutex);
 		pval = kcontrol->private_value;
 		kcontrol->private_value = HDA_COMPOSE_AMP_VAL(shared_nid, ch,
@@ -5436,6 +5459,7 @@ static int ca0132_alt_volume_put(struct snd_kcontrol *kcontrol,
 	long *valp = ucontrol->value.integer.value;
 	hda_nid_t vnid = 0;
 	int changed = 1;
+	int err;
 
 	switch (nid) {
 	case 0x02:
@@ -5456,7 +5480,9 @@ static int ca0132_alt_volume_put(struct snd_kcontrol *kcontrol,
 		valp++;
 	}
 
-	snd_hda_power_up(codec);
+	err = snd_hda_power_up(codec);
+	if (err < 0)
+		return err;
 	ca0132_alt_dsp_volume_put(codec, vnid);
 	mutex_lock(&codec->control_mutex);
 	changed = snd_hda_mixer_amp_volume_put(kcontrol, ucontrol);
@@ -7190,6 +7216,7 @@ static int ca0132_init(struct hda_codec *codec)
 	struct auto_pin_cfg *cfg = &spec->autocfg;
 	int i;
 	bool dsp_loaded;
+	int err;
 
 	/*
 	 * If the DSP is already downloaded, and init has been entered again,
@@ -7220,7 +7247,9 @@ static int ca0132_init(struct hda_codec *codec)
 	if (spec->quirk == QUIRK_SBZ)
 		sbz_region2_startup(codec);
 
-	snd_hda_power_up_pm(codec);
+	err = snd_hda_power_up_pm(codec);
+	if (err < 0)
+		return err;
 
 	ca0132_init_unsol(codec);
 	ca0132_init_params(codec);
@@ -7310,7 +7339,8 @@ static void ca0132_free(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	cancel_delayed_work_sync(&spec->unsol_hp_work);
-	snd_hda_power_up(codec);
+	if (snd_hda_power_up(codec) < 0)
+		goto skip_shutdown;
 	switch (spec->quirk) {
 	case QUIRK_SBZ:
 		sbz_exit_chip(codec);
@@ -7326,6 +7356,7 @@ static void ca0132_free(struct hda_codec *codec)
 		break;
 	}
 	snd_hda_power_down(codec);
+ skip_shutdown:
 	if (spec->mem_base)
 		iounmap(spec->mem_base);
 	kfree(spec->spec_init_verbs);
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 5ad6c7e5f92e..b0d757cf7aab 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3606,7 +3606,8 @@ static void alc269_fixup_mic_mute_hook(void *private_data, int enabled)
 	pinval |= enabled ? AC_PINCTL_VREF_HIZ : AC_PINCTL_VREF_80;
 	if (spec->mute_led_nid) {
 		/* temporarily power up/down for setting VREF */
-		snd_hda_power_up_pm(codec);
+		if (snd_hda_power_up_pm(codec) < 0)
+			return;
 		snd_hda_set_pin_ctl_cache(codec, spec->mute_led_nid, pinval);
 		snd_hda_power_down_pm(codec);
 	}
-- 
2.17.1
