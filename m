From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 6/7] HDA patch_via.c: Independent DAC for
	headphone
Date: Tue, 9 Sep 2008 15:58:27 +0800
Message-ID: <20080909075827.GI9638@prithivi.gnumonks.org>
References: <20080909073717.GC9638@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id E9E7F103853
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:02:43 +0200 (CEST)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.63)
	(envelope-from <HaraldWelte@viatech.com>) id 1KcyBP-0007um-Iw
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 10:02:43 +0200
Received: from laforge by prithivi.gnumonks.org with local (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1Kcy7H-0004zG-SG
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 15:58:27 +0800
Content-Disposition: inline
In-Reply-To: <20080909073717.GC9638@prithivi.gnumonks.org>
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
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Add "Independent Headphone" mode

This mode allows an output stream to have two substreams, one for the
speakers and one for the headphone.  Each of the substreams has independent
PCM data and uses a different DAC.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

Index: linux-2.6/sound/pci/hda/patch_via.c
===================================================================
--- linux-2.6.orig/sound/pci/hda/patch_via.c
+++ linux-2.6/sound/pci/hda/patch_via.c
@@ -33,6 +33,7 @@
 /* 2008-02-03  Lydia Wang  Fix Rear channels and Back channels inverse issue */
 /* 2008-03-06  Lydia Wang  Add VT1702 codec and VT1708S codec support        */
 /* 2008-04-09  Lydia Wang  Add mute front speaker when HP plugin             */
+/* 2008-04-09  Lydia Wang  Add Independent HP feature                        */
 /*                                                                           */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
 
@@ -41,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <sound/core.h>
+#include <sound/asoundef.h>
 #include "hda_codec.h"
 #include "hda_local.h"
 #include "hda_patch.h"
@@ -140,9 +142,13 @@
 	struct auto_pin_cfg autocfg;
 	unsigned int num_kctl_alloc, num_kctl_used;
 	struct snd_kcontrol_new *kctl_alloc;
-	struct hda_input_mux private_imux;
+	struct hda_input_mux private_imux[2];
 	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
 
+	/* HP mode source */
+	const struct hda_input_mux *hp_mux;
+	unsigned int hp_independent_mode;
+
 #ifdef CONFIG_SND_HDA_POWER_SAVE
 	struct hda_loopback_check loopback;
 #endif
@@ -326,6 +332,92 @@
 					     &spec->cur_mux[adc_idx]);
 }
 
+static int via_independent_hp_info(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct via_spec *spec = codec->spec;
+	return snd_hda_input_mux_info(spec->hp_mux, uinfo);
+}
+
+static int via_independent_hp_get(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct via_spec *spec = codec->spec;
+	hda_nid_t nid = spec->autocfg.hp_pins[0];
+	unsigned int pinsel = snd_hda_codec_read(codec, nid, 0,
+						 AC_VERB_GET_CONNECT_SEL,
+						 0x00);
+
+	ucontrol->value.enumerated.item[0] = pinsel;
+
+	return 0;
+}
+
+static int via_independent_hp_put(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct via_spec *spec = codec->spec;
+	hda_nid_t nid = spec->autocfg.hp_pins[0];
+	unsigned int pinsel = ucontrol->value.enumerated.item[0];
+	unsigned int con_nid = snd_hda_codec_read(codec, nid, 0,
+					 AC_VERB_GET_CONNECT_LIST, 0) & 0xff;
+
+	if (con_nid == spec->multiout.hp_nid) {
+		if (pinsel == 0) {
+			if (!spec->hp_independent_mode) {
+				if (spec->multiout.num_dacs > 1)
+					spec->multiout.num_dacs -= 1;
+				spec->hp_independent_mode = 1;
+			}
+		} else if (pinsel == 1) {
+		       if (spec->hp_independent_mode) {
+				if (spec->multiout.num_dacs > 1)
+					spec->multiout.num_dacs += 1;
+				spec->hp_independent_mode = 0;
+		       }
+		}
+	} else {
+		if (pinsel == 0) {
+			if (spec->hp_independent_mode) {
+				if (spec->multiout.num_dacs > 1)
+					spec->multiout.num_dacs += 1;
+				spec->hp_independent_mode = 0;
+			}
+		} else if (pinsel == 1) {
+		       if (!spec->hp_independent_mode) {
+				if (spec->multiout.num_dacs > 1)
+					spec->multiout.num_dacs -= 1;
+				spec->hp_independent_mode = 1;
+		       }
+		}
+	}
+	snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_CONNECT_SEL,
+			    pinsel);
+
+	if (spec->multiout.hp_nid &&
+	    spec->multiout.hp_nid != spec->multiout.dac_nids[HDA_FRONT])
+			snd_hda_codec_setup_stream(codec,
+						   spec->multiout.hp_nid,
+						   0, 0, 0);
+
+	return 0;
+}
+
+static struct snd_kcontrol_new via_hp_mixer[] = {
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Independent HP",
+		.count = 1,
+		.info = via_independent_hp_info,
+		.get = via_independent_hp_get,
+		.put = via_independent_hp_put,
+	},
+	{ } /* end */
+};
+
 /* capture mixer elements */
 static struct snd_kcontrol_new vt1708_capture_mixer[] = {
 	HDA_CODEC_VOLUME("Capture Volume", 0x15, 0x0, HDA_INPUT),
@@ -411,6 +503,138 @@
 	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
 }
 
+
+static void playback_multi_pcm_prep_0(struct hda_codec *codec,
+				      unsigned int stream_tag,
+				      unsigned int format,
+				      struct snd_pcm_substream *substream)
+{
+	struct via_spec *spec = codec->spec;
+	struct hda_multi_out *mout = &spec->multiout;
+	hda_nid_t *nids = mout->dac_nids;
+	int chs = substream->runtime->channels;
+	int i;
+
+	mutex_lock(&codec->spdif_mutex);
+	if (mout->dig_out_nid && mout->dig_out_used != HDA_DIG_EXCLUSIVE) {
+		if (chs == 2 &&
+		    snd_hda_is_supported_format(codec, mout->dig_out_nid,
+						format) &&
+		    !(codec->spdif_status & IEC958_AES0_NONAUDIO)) {
+			mout->dig_out_used = HDA_DIG_ANALOG_DUP;
+			/* turn off SPDIF once; otherwise the IEC958 bits won't
+			 * be updated */
+			if (codec->spdif_ctls & AC_DIG1_ENABLE)
+				snd_hda_codec_write(codec, mout->dig_out_nid, 0,
+						    AC_VERB_SET_DIGI_CONVERT_1,
+						    codec->spdif_ctls &
+							~AC_DIG1_ENABLE & 0xff);
+			snd_hda_codec_setup_stream(codec, mout->dig_out_nid,
+						   stream_tag, 0, format);
+			/* turn on again (if needed) */
+			if (codec->spdif_ctls & AC_DIG1_ENABLE)
+				snd_hda_codec_write(codec, mout->dig_out_nid, 0,
+						    AC_VERB_SET_DIGI_CONVERT_1,
+						    codec->spdif_ctls & 0xff);
+		} else {
+			mout->dig_out_used = 0;
+			snd_hda_codec_setup_stream(codec, mout->dig_out_nid,
+						   0, 0, 0);
+		}
+	}
+	mutex_unlock(&codec->spdif_mutex);
+
+	/* front */
+	snd_hda_codec_setup_stream(codec, nids[HDA_FRONT], stream_tag,
+				   0, format);
+
+	if (mout->hp_nid && mout->hp_nid != nids[HDA_FRONT] &&
+	    !spec->hp_independent_mode)
+		/* headphone out will just decode front left/right (stereo) */
+		snd_hda_codec_setup_stream(codec, mout->hp_nid, stream_tag,
+					   0, format);
+
+	/* extra outputs copied from front */
+	for (i = 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
+		if (mout->extra_out_nid[i])
+			snd_hda_codec_setup_stream(codec,
+						   mout->extra_out_nid[i],
+						   stream_tag, 0, format);
+
+	/* surrounds */
+	for (i = 1; i < mout->num_dacs; i++) {
+		if (chs >= (i + 1) * 2) /* independent out */
+			snd_hda_codec_setup_stream(codec, nids[i], stream_tag,
+						   i * 2, format);
+		else /* copy front */
+			snd_hda_codec_setup_stream(codec, nids[i], stream_tag,
+						   0, format);
+	}
+}
+
+static int via_playback_multi_pcm_prepare(struct hda_pcm_stream *hinfo,
+					  struct hda_codec *codec,
+					  unsigned int stream_tag,
+					  unsigned int format,
+					  struct snd_pcm_substream *substream)
+{
+	struct via_spec *spec = codec->spec;
+	struct hda_multi_out *mout = &spec->multiout;
+	hda_nid_t *nids = mout->dac_nids;
+
+	if (substream->number == 0)
+		playback_multi_pcm_prep_0(codec, stream_tag, format,
+					  substream);
+	else {
+		if (mout->hp_nid && mout->hp_nid != nids[HDA_FRONT] &&
+		    spec->hp_independent_mode)
+			snd_hda_codec_setup_stream(codec, mout->hp_nid,
+						   stream_tag, 0, format);
+	}
+
+	return 0;
+}
+
+static int via_playback_multi_pcm_cleanup(struct hda_pcm_stream *hinfo,
+				    struct hda_codec *codec,
+				    struct snd_pcm_substream *substream)
+{
+	struct via_spec *spec = codec->spec;
+	struct hda_multi_out *mout = &spec->multiout;
+	hda_nid_t *nids = mout->dac_nids;
+	int i;
+
+	if (substream->number == 0) {
+		for (i = 0; i < mout->num_dacs; i++)
+			snd_hda_codec_setup_stream(codec, nids[i], 0, 0, 0);
+
+		if (mout->hp_nid && !spec->hp_independent_mode)
+			snd_hda_codec_setup_stream(codec, mout->hp_nid,
+						   0, 0, 0);
+
+		for (i = 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
+			if (mout->extra_out_nid[i])
+				snd_hda_codec_setup_stream(codec,
+							mout->extra_out_nid[i],
+							0, 0, 0);
+		mutex_lock(&codec->spdif_mutex);
+		if (mout->dig_out_nid &&
+		    mout->dig_out_used == HDA_DIG_ANALOG_DUP) {
+			snd_hda_codec_setup_stream(codec, mout->dig_out_nid,
+						   0, 0, 0);
+			mout->dig_out_used = 0;
+		}
+		mutex_unlock(&codec->spdif_mutex);
+	} else {
+		if (mout->hp_nid && mout->hp_nid != nids[HDA_FRONT] &&
+		    spec->hp_independent_mode)
+			snd_hda_codec_setup_stream(codec, mout->hp_nid,
+						   0, 0, 0);
+	}
+
+	return 0;
+}
+
 /*
  * Digital out
  */
@@ -467,14 +691,14 @@
 }
 
 static struct hda_pcm_stream vt1708_pcm_analog_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 8,
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup
 	},
 };
 
@@ -866,6 +1090,24 @@
 	return 0;
 }
 
+static void create_hp_imux(struct via_spec *spec)
+{
+	int i;
+	struct hda_input_mux *imux = &spec->private_imux[1];
+	static const char *texts[] = { "OFF", "ON", NULL};
+
+	/* for hp mode select */
+	i = 0;
+	while (texts[i] != NULL) {
+		imux->items[imux->num_items].label =  texts[i];
+		imux->items[imux->num_items].index = i;
+		imux->num_items++;
+		i++;
+	}
+
+	spec->hp_mux = &spec->private_imux[1];
+}
+
 static int vt1708_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
 {
 	int err;
@@ -886,6 +1128,8 @@
 	if (err < 0)
 		return err;
 
+	create_hp_imux(spec);
+
 	return 0;
 }
 
@@ -896,7 +1140,7 @@
 	static char *labels[] = {
 		"Mic", "Front Mic", "Line", "Front Line", "CD", "Aux", NULL
 	};
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, err, idx = 0;
 
 	/* for internal loopback recording select */
@@ -1007,7 +1251,9 @@
 
 	spec->init_verbs[spec->num_iverbs++] = vt1708_volume_init_verbs;
 
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
+
+	spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
 	return 1;
 }
@@ -1402,7 +1648,7 @@
 	static char *labels[] = {
 		"Mic", "Front Mic", "Line", "Front Line", "CD", "Aux", NULL
 	};
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, err, idx = 0;
 
 	/* for internal loopback recording select */
@@ -1476,7 +1722,7 @@
 	if (spec->kctl_alloc)
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
 
 	return 1;
 }
@@ -1734,26 +1980,26 @@
 };
 
 static struct hda_pcm_stream vt1708B_8ch_pcm_analog_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 8,
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup
 	},
 };
 
 static struct hda_pcm_stream vt1708B_4ch_pcm_analog_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 4,
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup
 	},
 };
 
@@ -1932,6 +2178,8 @@
 	if (err < 0)
 		return err;
 
+	create_hp_imux(spec);
+
 	return 0;
 }
 
@@ -1942,7 +2190,7 @@
 	static char *labels[] = {
 		"Mic", "Front Mic", "Line", "Front Line", "CD", "Aux", NULL
 	};
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, err, idx = 0;
 
 	/* for internal loopback recording select */
@@ -2016,7 +2264,9 @@
 	if (spec->kctl_alloc)
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
+
+	spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
 	return 1;
 }
@@ -2373,6 +2623,8 @@
 	if (err < 0)
 		return err;
 
+	create_hp_imux(spec);
+
 	return 0;
 }
 
@@ -2383,7 +2635,7 @@
 	static char *labels[] = {
 		"Mic", "Front Mic", "Line", "Front Line", "CD", "Aux", NULL
 	};
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, err, idx = 0;
 
 	/* for internal loopback recording select */
@@ -2457,7 +2709,9 @@
 	if (spec->kctl_alloc)
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
+
+	spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
 	return 1;
 }
@@ -2584,14 +2838,14 @@
 };
 
 static struct hda_pcm_stream vt1702_pcm_analog_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
 	.nid = 0x10, /* NID to query formats and rates */
 	.ops = {
 		.open = via_playback_pcm_open,
-		.prepare = via_playback_pcm_prepare,
-		.cleanup = via_playback_pcm_cleanup
+		.prepare = via_playback_multi_pcm_prepare,
+		.cleanup = via_playback_multi_pcm_cleanup
 	},
 };
 
@@ -2690,6 +2944,8 @@
 	if (err < 0)
 		return err;
 
+	create_hp_imux(spec);
+
 	return 0;
 }
 
@@ -2700,7 +2956,7 @@
 	static char *labels[] = {
 		"Mic", "Front Mic", "Line", "Front Line", "CD", "Aux", NULL
 	};
-	struct hda_input_mux *imux = &spec->private_imux;
+	struct hda_input_mux *imux = &spec->private_imux[0];
 	int i, err, idx = 0;
 
 	/* for internal loopback recording select */
@@ -2770,7 +3026,9 @@
 	if (spec->kctl_alloc)
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
-	spec->input_mux = &spec->private_imux;
+	spec->input_mux = &spec->private_imux[0];
+
+	spec->mixers[spec->num_mixers++] = via_hp_mixer;
 
 	return 1;
 }
-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
