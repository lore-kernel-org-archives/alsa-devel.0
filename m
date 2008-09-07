From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH0/1] hda: slave digital out support
Date: Sun, 07 Sep 2008 14:31:40 -0400
Message-ID: <48C41E0C.8030901@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from easi.embeddedalley.com (easi.embeddedalley.com [71.6.201.124])
	by alsa0.perex.cz (Postfix) with SMTP id 53EE41037F6
	for <alsa-devel@alsa-project.org>;
	Sun,  7 Sep 2008 20:31:55 +0200 (CEST)
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

Added support for playing a stream on multiple digital outs. This is done
by defining codec->slave_dig_outs as array of hda_nid_t with a null-terminated entry to set the
slave SPDIF outs, in which the slave outs have cloned settings of the master out (e.g. dig_out_nid).

---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

diff --git a/pci/hda/hda_codec.c b/pci/hda/hda_codec.c
index 4f32911..696d77e 100644
--- a/pci/hda/hda_codec.c
+++ b/pci/hda/hda_codec.c
@@ -1454,12 +1454,22 @@ static int snd_hda_spdif_default_put(struct snd_kcontrol *kcontrol,
 	codec->spdif_ctls = val;

 	if (change) {
+		hda_nid_t *d;
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1,
 					  val & 0xff);
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_2,
 					  val >> 8);
+
+		for (d = codec->slave_dig_outs; *d; d++) {
+			snd_hda_codec_write_cache(codec, *d, 0,
+					  AC_VERB_SET_DIGI_CONVERT_1,
+					  val & 0xff);
+			snd_hda_codec_write_cache(codec, *d, 0,
+					  AC_VERB_SET_DIGI_CONVERT_2,
+					  val >> 8);
+		}
 	}

 	mutex_unlock(&codec->spdif_mutex);
@@ -1491,10 +1501,16 @@ static int snd_hda_spdif_out_switch_put(struct snd_kcontrol *kcontrol,
 		val |= AC_DIG1_ENABLE;
 	change = codec->spdif_ctls != val;
 	if (change) {
+		hda_nid_t *d;
 		codec->spdif_ctls = val;
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1,
 					  val & 0xff);
+
+		for (d = codec->slave_dig_outs; *d; d++)
+			snd_hda_codec_write_cache(codec, *d, 0,
+					  AC_VERB_SET_DIGI_CONVERT_1,
+					  val & 0xff);
 		/* unmute amp switch (if any) */
 		if ((get_wcaps(codec, nid) & AC_WCAP_OUT_AMP) &&
 		    (val & AC_DIG1_ENABLE))
@@ -1643,9 +1659,14 @@ static int snd_hda_spdif_in_switch_put(struct snd_kcontrol *kcontrol,
 	mutex_lock(&codec->spdif_mutex);
 	change = codec->spdif_in_enable != val;
 	if (change) {
+		hda_nid_t *d;
 		codec->spdif_in_enable = val;
 		snd_hda_codec_write_cache(codec, nid, 0,
 					  AC_VERB_SET_DIGI_CONVERT_1, val);
+
+		for (d = codec->slave_dig_outs; *d; d++)
+			snd_hda_codec_write_cache(codec, *d, 0,
+					  AC_VERB_SET_DIGI_CONVERT_1, val);
 	}
 	mutex_unlock(&codec->spdif_mutex);
 	return change;
@@ -2589,15 +2610,30 @@ int snd_hda_input_mux_put(struct hda_codec *codec,
 static void setup_dig_out_stream(struct hda_codec *codec, hda_nid_t nid,
 				 unsigned int stream_tag, unsigned int format)
 {
+	hda_nid_t *d;
+
 	/* turn off SPDIF once; otherwise the IEC958 bits won't be updated */
-	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE))
+	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE)) {
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
+			    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
+
+		for (d = codec->slave_dig_outs; *d; d++)
+			snd_hda_codec_write(codec, *d, 0,
+					AC_VERB_SET_DIGI_CONVERT_1,
 				    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
+	}
 	snd_hda_codec_setup_stream(codec, nid, stream_tag, 0, format);
 	/* turn on again (if needed) */
-	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE))
+	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE)) {
 		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
 				    codec->spdif_ctls & 0xff);
+
+		for (d = codec->slave_dig_outs; *d; d++)
+			snd_hda_codec_write(codec, *d, 0,
+					AC_VERB_SET_DIGI_CONVERT_1,
+				    codec->spdif_ctls & 0xff);
+	}
+
 }

 /*
@@ -2621,8 +2657,12 @@ int snd_hda_multi_out_dig_prepare(struct hda_codec *codec,
 				  unsigned int format,
 				  struct snd_pcm_substream *substream)
 {
+	hda_nid_t *nid;
 	mutex_lock(&codec->spdif_mutex);
 	setup_dig_out_stream(codec, mout->dig_out_nid, stream_tag, format);
+	if (codec->slave_dig_outs)
+		for (nid = codec->slave_dig_outs; *nid; nid++)
+			setup_dig_out_stream(codec, *nid, stream_tag, format);
 	mutex_unlock(&codec->spdif_mutex);
 	return 0;
 }
@@ -2689,6 +2729,7 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 				     struct snd_pcm_substream *substream)
 {
 	hda_nid_t *nids = mout->dac_nids;
+	hda_nid_t *d;
 	int chs = substream->runtime->channels;
 	int i;

@@ -2702,9 +2743,16 @@ int snd_hda_multi_out_analog_prepare(struct hda_codec *codec,
 			mout->dig_out_used = HDA_DIG_ANALOG_DUP;
 			setup_dig_out_stream(codec, mout->dig_out_nid,
 					     stream_tag, format);
+			if (codec->slave_dig_outs)
+				for (d = codec->slave_dig_outs; *d; d++)
+					setup_dig_out_stream(codec, *d,
+						stream_tag, format);
 		} else {
 			mout->dig_out_used = 0;
 			snd_hda_codec_cleanup_stream(codec, mout->dig_out_nid);
+			if (codec->slave_dig_outs)
+				for (d = codec->slave_dig_outs; *d; d++)
+					snd_hda_codec_cleanup_stream(codec, *d);
 		}
 	}
 	mutex_unlock(&codec->spdif_mutex);
diff --git a/pci/hda/hda_codec.h b/pci/hda/hda_codec.h
index 780e2ff..60468f5 100644
--- a/pci/hda/hda_codec.h
+++ b/pci/hda/hda_codec.h
@@ -725,6 +725,7 @@ struct hda_codec {
 	unsigned int spdif_status;	/* IEC958 status bits */
 	unsigned short spdif_ctls;	/* SPDIF control bits */
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
+	hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */

 	struct snd_hwdep *hwdep;	/* assigned hwdep device */
