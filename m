From: Stephen Warren <swarren@nvidia.com>
Subject: [PATCH 2/6] ALSA: hda: Allow multple SPDIF controls
	per codec
Date: Wed,  1 Jun 2011 11:14:17 -0600
Message-ID: <1306948461-2402-3-git-send-email-swarren@nvidia.com>
References: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id D19551038C5
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jun 2011 19:14:41 +0200 (CEST)
In-Reply-To: <1306948461-2402-1-git-send-email-swarren@nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, perex@perex.cz, wfg@linux.intel.com
Cc: wni@nvidia.com, Stephen Warren <swarren@nvidia.com>, ndaga@nvidia.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Currently, the data that backs the kcontrols created by
snd_hda_create_spdif_out_ctls is stored directly in struct hda_codec. When
multiple sets of these controls are stored, they will all manipulate the
same data, causing confusion. Instead, store an array of this data, one
copy per converter, to isolate the controls.

This patch would cause a behavioural change in the case where
snd_hda_create_spdif_out_ctls was called multiple times for a single codec.
As best I can tell, this is never the case for any codec.

This will be relevant at least for some HDMI audio codecs, such as the
NVIDIA GeForce 520 and Intel Ibex Peak. A future change will modify the
driver's handling of those codecs to create multiple PCMs per codec. Note
that this issue isn't affected by whether one creates a PCM-per-converter
or PCM-per-pin; there are multiple of both within a single codec in both
of those codecs.

Note that those codecs don't currently create multiple PCMs for the codec
due to the default HW mux state of all pins being to point at the same
converter, hence there is only a single converter routed to any pin, and
hence only a single PCM.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/pci/hda/hda_codec.c  |   80 ++++++++++++++++++++++++++++++--------------
 sound/pci/hda/hda_codec.h  |   12 +++++-
 sound/pci/hda/hda_intel.c  |    5 ++-
 sound/pci/hda/patch_hdmi.c |   19 ++++++----
 sound/pci/hda/patch_via.c  |   12 ++++---
 5 files changed, 87 insertions(+), 41 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 45b4a8d..e17e299 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1083,6 +1083,7 @@ static void snd_hda_codec_free(struct hda_codec *codec)
 	snd_array_free(&codec->mixers);
 	snd_array_free(&codec->nids);
 	snd_array_free(&codec->conn_lists);
+	snd_array_free(&codec->spdif_out);
 	codec->bus->caddr_tbl[codec->addr] = NULL;
 	if (codec->patch_ops.free)
 		codec->patch_ops.free(codec);
@@ -1144,6 +1145,7 @@ int /*__devinit*/ snd_hda_codec_new(struct hda_bus *bus,
 	snd_array_init(&codec->driver_pins, sizeof(struct hda_pincfg), 16);
 	snd_array_init(&codec->cvt_setups, sizeof(struct hda_cvt_setup), 8);
 	snd_array_init(&codec->conn_lists, sizeof(hda_nid_t), 64);
+	snd_array_init(&codec->spdif_out, sizeof(struct hda_spdif_out), 16);
 	if (codec->bus->modelname) {
 		codec->modelname = kstrdup(codec->bus->modelname, GFP_KERNEL);
 		if (!codec->modelname) {
@@ -2555,11 +2557,13 @@ static int snd_hda_spdif_default_get(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	int idx = kcontrol->private_value;
+	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
 
-	ucontrol->value.iec958.status[0] = codec->spdif_status & 0xff;
-	ucontrol->value.iec958.status[1] = (codec->spdif_status >> 8) & 0xff;
-	ucontrol->value.iec958.status[2] = (codec->spdif_status >> 16) & 0xff;
-	ucontrol->value.iec958.status[3] = (codec->spdif_status >> 24) & 0xff;
+	ucontrol->value.iec958.status[0] = spdif->status & 0xff;
+	ucontrol->value.iec958.status[1] = (spdif->status >> 8) & 0xff;
+	ucontrol->value.iec958.status[2] = (spdif->status >> 16) & 0xff;
+	ucontrol->value.iec958.status[3] = (spdif->status >> 24) & 0xff;
 
 	return 0;
 }
@@ -2644,19 +2648,21 @@ static int snd_hda_spdif_default_put(struct snd_kcontrol *kcontrol,
 				     struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	hda_nid_t nid = kcontrol->private_value;
+	int idx = kcontrol->private_value;
+	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
+	hda_nid_t nid = spdif->nid;
 	unsigned short val;
 	int change;
 
 	mutex_lock(&codec->spdif_mutex);
-	codec->spdif_status = ucontrol->value.iec958.status[0] |
+	spdif->status = ucontrol->value.iec958.status[0] |
 		((unsigned int)ucontrol->value.iec958.status[1] << 8) |
 		((unsigned int)ucontrol->value.iec958.status[2] << 16) |
 		((unsigned int)ucontrol->value.iec958.status[3] << 24);
-	val = convert_from_spdif_status(codec->spdif_status);
-	val |= codec->spdif_ctls & 1;
-	change = codec->spdif_ctls != val;
-	codec->spdif_ctls = val;
+	val = convert_from_spdif_status(spdif->status);
+	val |= spdif->ctls & 1;
+	change = spdif->ctls != val;
+	spdif->ctls = val;
 
 	if (change)
 		set_dig_out_convert(codec, nid, val & 0xff, (val >> 8) & 0xff);
@@ -2671,8 +2677,10 @@ static int snd_hda_spdif_out_switch_get(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	int idx = kcontrol->private_value;
+	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
 
-	ucontrol->value.integer.value[0] = codec->spdif_ctls & AC_DIG1_ENABLE;
+	ucontrol->value.integer.value[0] = spdif->ctls & AC_DIG1_ENABLE;
 	return 0;
 }
 
@@ -2680,17 +2688,19 @@ static int snd_hda_spdif_out_switch_put(struct snd_kcontrol *kcontrol,
 					struct snd_ctl_elem_value *ucontrol)
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	hda_nid_t nid = kcontrol->private_value;
+	int idx = kcontrol->private_value;
+	struct hda_spdif_out *spdif = snd_array_elem(&codec->spdif_out, idx);
+	hda_nid_t nid = spdif->nid;
 	unsigned short val;
 	int change;
 
 	mutex_lock(&codec->spdif_mutex);
-	val = codec->spdif_ctls & ~AC_DIG1_ENABLE;
+	val = spdif->ctls & ~AC_DIG1_ENABLE;
 	if (ucontrol->value.integer.value[0])
 		val |= AC_DIG1_ENABLE;
-	change = codec->spdif_ctls != val;
+	change = spdif->ctls != val;
 	if (change) {
-		codec->spdif_ctls = val;
+		spdif->ctls = val;
 		set_dig_out_convert(codec, nid, val & 0xff, -1);
 		/* unmute amp switch (if any) */
 		if ((get_wcaps(codec, nid) & AC_WCAP_OUT_AMP) &&
@@ -2750,30 +2760,46 @@ int snd_hda_create_spdif_out_ctls(struct hda_codec *codec, hda_nid_t nid)
 	struct snd_kcontrol *kctl;
 	struct snd_kcontrol_new *dig_mix;
 	int idx;
+	struct hda_spdif_out *spdif;
 
 	idx = find_empty_mixer_ctl_idx(codec, "IEC958 Playback Switch");
 	if (idx < 0) {
 		printk(KERN_ERR "hda_codec: too many IEC958 outputs\n");
 		return -EBUSY;
 	}
+	spdif = snd_array_new(&codec->spdif_out);
 	for (dig_mix = dig_mixes; dig_mix->name; dig_mix++) {
 		kctl = snd_ctl_new1(dig_mix, codec);
 		if (!kctl)
 			return -ENOMEM;
 		kctl->id.index = idx;
-		kctl->private_value = nid;
+		kctl->private_value = codec->spdif_out.used - 1;
 		err = snd_hda_ctl_add(codec, nid, kctl);
 		if (err < 0)
 			return err;
 	}
-	codec->spdif_ctls =
-		snd_hda_codec_read(codec, nid, 0,
-				   AC_VERB_GET_DIGI_CONVERT_1, 0);
-	codec->spdif_status = convert_to_spdif_status(codec->spdif_ctls);
+	spdif->nid = nid;
+	spdif->ctls = snd_hda_codec_read(codec, nid, 0,
+					 AC_VERB_GET_DIGI_CONVERT_1, 0);
+	spdif->status = convert_to_spdif_status(spdif->ctls);
 	return 0;
 }
 EXPORT_SYMBOL_HDA(snd_hda_create_spdif_out_ctls);
 
+struct hda_spdif_out *snd_hda_spdif_out_of_nid(struct hda_codec *codec,
+					       hda_nid_t nid)
+{
+	int i;
+	for (i = 0; i < codec->spdif_out.used; i++) {
+		struct hda_spdif_out *spdif =
+				snd_array_elem(&codec->spdif_out, i);
+		if (spdif->nid == nid)
+			return spdif;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_HDA(snd_hda_spdif_out_of_nid);
+
 /*
  * SPDIF sharing with analog output
  */
@@ -4177,10 +4203,12 @@ EXPORT_SYMBOL_HDA(snd_hda_input_mux_put);
 static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
 				 unsigned int stream_tag, unsigned int format)
 {
+	struct hda_spdif_out *spdif = snd_hda_spdif_out_of_nid(codec, nid);
+
 	/* turn off SPDIF once; otherwise the IEC958 bits won't be updated */
-	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE))
+	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE))
 		set_dig_out_convert(codec, nid,
-				    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff,
+				    spdif->ctls & ~AC_DIG1_ENABLE & 0xff,
 				    -1);
 	snd_hda_codec_setup_stream(codec, nid, stream_tag, 0, format);
 	if (codec->slave_dig_outs) {
@@ -4190,9 +4218,9 @@ static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
 						   format);
 	}
 	/* turn on again (if needed) */
-	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE))
+	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE))
 		set_dig_out_convert(codec, nid,
-				    codec->spdif_ctls & 0xff, -1);
+				    spdif->ctls & 0xff, -1);
 }
 
 static void cleanup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid)
@@ -4348,6 +4376,8 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 {
 	const hda_nid_t *nids = mout->dac_nids;
 	int chs = substream->runtime->channels;
+	struct hda_spdif_out *spdif =
+			snd_hda_spdif_out_of_nid(codec, mout->dig_out_nid);
 	int i;
 
 	mutex_lock(&codec->spdif_mutex);
@@ -4356,7 +4386,7 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 		if (chs == 2 &&
 		    snd_hda_is_supported_format(codec, mout->dig_out_nid,
 						format) &&
-		    !(codec->spdif_status & IEC958_AES0_NONAUDIO)) {
+		    !(spdif->status & IEC958_AES0_NONAUDIO)) {
 			mout->dig_out_used = HDA_DIG_ANALOG_DUP;
 			setup_dig_out_stream(codec, mout->dig_out_nid,
 					     stream_tag, format);
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 59c9730..1d21c06 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -829,8 +829,7 @@ struct hda_codec {
 
 	struct mutex spdif_mutex;
 	struct mutex control_mutex;
-	unsigned int spdif_status;	/* IEC958 status bits */
-	unsigned short spdif_ctls;	/* SPDIF control bits */
+	struct snd_array spdif_out;
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
 	const hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */
 	struct snd_array init_pins;	/* initial (BIOS) pin configurations */
@@ -947,6 +946,15 @@ int snd_hda_add_pincfg(struct hda_codec *codec, struct snd_array *list,
 		       hda_nid_t nid, unsigned int cfg); /* for hwdep */
 void snd_hda_shutup_pins(struct hda_codec *codec);
 
+/* SPDIF controls */
+struct hda_spdif_out {
+	hda_nid_t nid;		/* Converter nid values relate to */
+	unsigned int status;	/* IEC958 status bits */
+	unsigned short ctls;	/* SPDIF control bits */
+};
+struct hda_spdif_out *snd_hda_spdif_out_of_nid(struct hda_codec *codec,
+					       hda_nid_t nid);
+
 /*
  * Mixer
  */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 486f6de..966f401 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1706,13 +1706,16 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	unsigned int bufsize, period_bytes, format_val, stream_tag;
 	int err;
+	struct hda_spdif_out *spdif =
+		snd_hda_spdif_out_of_nid(apcm->codec, hinfo->nid);
+	unsigned short ctls = spdif ? spdif->ctls : 0;
 
 	azx_stream_reset(chip, azx_dev);
 	format_val = snd_hda_calc_stream_format(runtime->rate,
 						runtime->channels,
 						runtime->format,
 						hinfo->maxbps,
-						apcm->codec->spdif_ctls);
+						ctls);
 	if (!format_val) {
 		snd_printk(KERN_ERR SFX
 			   "invalid format_val, rate=%d, ch=%d, format=%d\n",
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 8ccec72..86b35a0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1352,6 +1352,9 @@ static int nvhdmi_8ch_7x_pcm_prepare(struct hda_pcm_stream *hinfo,
 	int chs;
 	unsigned int dataDCC1, dataDCC2, channel_id;
 	int i;
+	struct hdmi_spec *spec = codec->spec;
+	struct hda_spdif_out *spdif =
+		snd_hda_spdif_out_of_nid(codec, spec->cvt[0]);
 
 	mutex_lock(&codec->spdif_mutex);
 
@@ -1361,12 +1364,12 @@ static int nvhdmi_8ch_7x_pcm_prepare(struct hda_pcm_stream *hinfo,
 	dataDCC2 = 0x2;
 
 	/* turn off SPDIF once; otherwise the IEC958 bits won't be updated */
-	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE))
+	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE))
 		snd_hda_codec_write(codec,
 				nvhdmi_master_con_nid_7x,
 				0,
 				AC_VERB_SET_DIGI_CONVERT_1,
-				codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
+				spdif->ctls & ~AC_DIG1_ENABLE & 0xff);
 
 	/* set the stream id */
 	snd_hda_codec_write(codec, nvhdmi_master_con_nid_7x, 0,
@@ -1378,12 +1381,12 @@ static int nvhdmi_8ch_7x_pcm_prepare(struct hda_pcm_stream *hinfo,
 
 	/* turn on again (if needed) */
 	/* enable and set the channel status audio/data flag */
-	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE)) {
+	if (codec->spdif_status_reset && (spdif->ctls & AC_DIG1_ENABLE)) {
 		snd_hda_codec_write(codec,
 				nvhdmi_master_con_nid_7x,
 				0,
 				AC_VERB_SET_DIGI_CONVERT_1,
-				codec->spdif_ctls & 0xff);
+				spdif->ctls & 0xff);
 		snd_hda_codec_write(codec,
 				nvhdmi_master_con_nid_7x,
 				0,
@@ -1400,12 +1403,12 @@ static int nvhdmi_8ch_7x_pcm_prepare(struct hda_pcm_stream *hinfo,
 		 *otherwise the IEC958 bits won't be updated
 		 */
 		if (codec->spdif_status_reset &&
-		(codec->spdif_ctls & AC_DIG1_ENABLE))
+		(spdif->ctls & AC_DIG1_ENABLE))
 			snd_hda_codec_write(codec,
 				nvhdmi_con_nids_7x[i],
 				0,
 				AC_VERB_SET_DIGI_CONVERT_1,
-				codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
+				spdif->ctls & ~AC_DIG1_ENABLE & 0xff);
 		/* set the stream id */
 		snd_hda_codec_write(codec,
 				nvhdmi_con_nids_7x[i],
@@ -1421,12 +1424,12 @@ static int nvhdmi_8ch_7x_pcm_prepare(struct hda_pcm_stream *hinfo,
 		/* turn on again (if needed) */
 		/* enable and set the channel status audio/data flag */
 		if (codec->spdif_status_reset &&
-		(codec->spdif_ctls & AC_DIG1_ENABLE)) {
+		(spdif->ctls & AC_DIG1_ENABLE)) {
 			snd_hda_codec_write(codec,
 					nvhdmi_con_nids_7x[i],
 					0,
 					AC_VERB_SET_DIGI_CONVERT_1,
-					codec->spdif_ctls & 0xff);
+					spdif->ctls & 0xff);
 			snd_hda_codec_write(codec,
 					nvhdmi_con_nids_7x[i],
 					0,
diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index 605c99e..8304c74 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -1236,28 +1236,30 @@ static void playback_multi_pcm_prep_0(struct hda_codec *codec,
 	const hda_nid_t *nids = mout->dac_nids;
 	int chs = substream->runtime->channels;
 	int i;
+	struct hda_spdif_out *spdif =
+		snd_hda_spdif_out_of_nid(codec, spec->multiout.dig_out_nid);
 
 	mutex_lock(&codec->spdif_mutex);
 	if (mout->dig_out_nid && mout->dig_out_used != HDA_DIG_EXCLUSIVE) {
 		if (chs == 2 &&
 		    snd_hda_is_supported_format(codec, mout->dig_out_nid,
 						format) &&
-		    !(codec->spdif_status & IEC958_AES0_NONAUDIO)) {
+		    !(spdif->status & IEC958_AES0_NONAUDIO)) {
 			mout->dig_out_used = HDA_DIG_ANALOG_DUP;
 			/* turn off SPDIF once; otherwise the IEC958 bits won't
 			 * be updated */
-			if (codec->spdif_ctls & AC_DIG1_ENABLE)
+			if (spdif->ctls & AC_DIG1_ENABLE)
 				snd_hda_codec_write(codec, mout->dig_out_nid, 0,
 						    AC_VERB_SET_DIGI_CONVERT_1,
-						    codec->spdif_ctls &
+						    spdif->ctls &
 							~AC_DIG1_ENABLE & 0xff);
 			snd_hda_codec_setup_stream(codec, mout->dig_out_nid,
 						   stream_tag, 0, format);
 			/* turn on again (if needed) */
-			if (codec->spdif_ctls & AC_DIG1_ENABLE)
+			if (spdif->ctls & AC_DIG1_ENABLE)
 				snd_hda_codec_write(codec, mout->dig_out_nid, 0,
 						    AC_VERB_SET_DIGI_CONVERT_1,
-						    codec->spdif_ctls & 0xff);
+						    spdif->ctls & 0xff);
 		} else {
 			mout->dig_out_used = 0;
 			snd_hda_codec_setup_stream(codec, mout->dig_out_nid,
-- 
1.7.0.4
