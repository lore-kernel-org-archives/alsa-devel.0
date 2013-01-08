From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 079/112] ALSA: hda - Implement independent HP
	control
Date: Tue,  8 Jan 2013 12:39:12 +0100
Message-ID: <1357645185-7645-80-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A079265211
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:26 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id 87BE8A5339
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:23 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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

Similar like the implementation in patch_analog.c and patch_via.c,
the generic parser can provide the independent HP PCM stream now.
It's enabled when spec->indep_hp is set by the caller while parsing.

Currently no dynamic PCM switching as in patch_via.c is implemented
yet.  The control returns -EBUSY when the value is changed during PCM
operations.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 128 +++++++++++++++++++++++++++++++++++++++++++-
 sound/pci/hda/hda_generic.h |   9 ++++
 2 files changed, 136 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f3c6ace..cc47460 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -41,6 +41,7 @@ int snd_hda_gen_spec_init(struct hda_gen_spec *spec)
 	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
 	snd_array_init(&spec->bind_ctls, sizeof(struct hda_bind_ctls *), 8);
 	snd_array_init(&spec->paths, sizeof(struct nid_path), 8);
+	mutex_init(&spec->pcm_mutex);
 	return 0;
 }
 EXPORT_SYMBOL_HDA(snd_hda_gen_spec_init);
@@ -1485,6 +1486,77 @@ static int create_speaker_out_ctls(struct hda_codec *codec)
 }
 
 /*
+ * independent HP controls
+ */
+
+static int indep_hp_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	return snd_hda_enum_bool_helper_info(kcontrol, uinfo);
+}
+
+static int indep_hp_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	ucontrol->value.enumerated.item[0] = spec->indep_hp_enabled;
+	return 0;
+}
+
+static int indep_hp_put(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	unsigned int select = ucontrol->value.enumerated.item[0];
+
+	mutex_lock(&spec->pcm_mutex);
+	if (spec->active_streams) {
+		mutex_unlock(&spec->pcm_mutex);
+		return -EBUSY;
+	}
+
+	if (spec->indep_hp_enabled != select) {
+		spec->indep_hp_enabled = select;
+		if (spec->indep_hp_enabled)
+			spec->multiout.hp_out_nid[0] = 0;
+		else
+			spec->multiout.hp_out_nid[0] = spec->alt_dac_nid;
+		return 1;
+	}
+	mutex_unlock(&spec->pcm_mutex);
+	return 0;
+}
+
+static const struct snd_kcontrol_new indep_hp_ctl = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Independent HP",
+	.info = indep_hp_info,
+	.get = indep_hp_get,
+	.put = indep_hp_put,
+};
+
+
+static int create_indep_hp_ctls(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (!spec->indep_hp)
+		return 0;
+	if (!spec->multiout.hp_out_nid[0]) {
+		spec->indep_hp = 0;
+		return 0;
+	}
+
+	spec->indep_hp_enabled = false;
+	spec->alt_dac_nid = spec->multiout.hp_out_nid[0];
+	if (!snd_hda_gen_add_kctl(spec, NULL, &indep_hp_ctl))
+		return -ENOMEM;
+	return 0;
+}
+
+/*
  * channel mode enum control
  */
 
@@ -2905,6 +2977,9 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
 	err = create_speaker_out_ctls(codec);
 	if (err < 0)
 		return err;
+	err = create_indep_hp_ctls(codec);
+	if (err < 0)
+		return err;
 	err = create_shared_input(codec);
 	if (err < 0)
 		return err;
@@ -3057,8 +3132,16 @@ static int playback_pcm_open(struct hda_pcm_stream *hinfo,
 			     struct snd_pcm_substream *substream)
 {
 	struct hda_gen_spec *spec = codec->spec;
-	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
+	int err;
+
+	mutex_lock(&spec->pcm_mutex);
+	err = snd_hda_multi_out_analog_open(codec,
+					    &spec->multiout, substream,
 					     hinfo);
+	if (!err)
+		spec->active_streams |= 1 << STREAM_MULTI_OUT;
+	mutex_unlock(&spec->pcm_mutex);
+	return err;
 }
 
 static int playback_pcm_prepare(struct hda_pcm_stream *hinfo,
@@ -3080,6 +3163,44 @@ static int playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
 	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
 }
 
+static int playback_pcm_close(struct hda_pcm_stream *hinfo,
+			      struct hda_codec *codec,
+			      struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	mutex_lock(&spec->pcm_mutex);
+	spec->active_streams &= ~(1 << STREAM_MULTI_OUT);
+	mutex_unlock(&spec->pcm_mutex);
+	return 0;
+}
+
+static int alt_playback_pcm_open(struct hda_pcm_stream *hinfo,
+				 struct hda_codec *codec,
+				 struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int err = 0;
+
+	mutex_lock(&spec->pcm_mutex);
+	if (!spec->indep_hp_enabled)
+		err = -EBUSY;
+	else
+		spec->active_streams |= 1 << STREAM_INDEP_HP;
+	mutex_unlock(&spec->pcm_mutex);
+	return err;
+}
+
+static int alt_playback_pcm_close(struct hda_pcm_stream *hinfo,
+				  struct hda_codec *codec,
+				  struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	mutex_lock(&spec->pcm_mutex);
+	spec->active_streams &= ~(1 << STREAM_INDEP_HP);
+	mutex_unlock(&spec->pcm_mutex);
+	return 0;
+}
+
 /*
  * Digital out
  */
@@ -3154,6 +3275,7 @@ static const struct hda_pcm_stream pcm_analog_playback = {
 	/* NID is set in build_pcms */
 	.ops = {
 		.open = playback_pcm_open,
+		.close = playback_pcm_close,
 		.prepare = playback_pcm_prepare,
 		.cleanup = playback_pcm_cleanup
 	},
@@ -3171,6 +3293,10 @@ static const struct hda_pcm_stream pcm_analog_alt_playback = {
 	.channels_min = 2,
 	.channels_max = 2,
 	/* NID is set in build_pcms */
+	.ops = {
+		.open = alt_playback_pcm_open,
+		.close = alt_playback_pcm_close
+	},
 };
 
 static const struct hda_pcm_stream pcm_analog_alt_capture = {
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 85d138f..5c1569c 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -65,6 +65,9 @@ struct automic_entry {
 	unsigned int attr;	/* pin attribute (INPUT_PIN_ATTR_*) */
 };
 
+/* active stream id */
+enum { STREAM_MULTI_OUT, STREAM_INDEP_HP };
+
 struct hda_gen_spec {
 	char stream_name_analog[32];	/* analog PCM stream */
 	const struct hda_pcm_stream *stream_analog_playback;
@@ -76,6 +79,10 @@ struct hda_gen_spec {
 	const struct hda_pcm_stream *stream_digital_playback;
 	const struct hda_pcm_stream *stream_digital_capture;
 
+	/* PCM */
+	unsigned int active_streams;
+	struct mutex pcm_mutex;
+
 	/* playback */
 	struct hda_multi_out multiout;	/* playback set-up
 					 * max_channels, dacs must be set
@@ -150,6 +157,8 @@ struct hda_gen_spec {
 	unsigned int inv_dmic_split:1; /* inverted dmic w/a for conexant */
 	unsigned int own_eapd_ctl:1; /* set EAPD by own function */
 	unsigned int vmaster_mute_enum:1; /* add vmaster mute mode enum */
+	unsigned int indep_hp:1; /* independent HP supported */
+	unsigned int indep_hp_enabled:1; /* independent HP enabled */
 
 	/* for virtual master */
 	hda_nid_t vmaster_nid;
-- 
1.8.0.1
