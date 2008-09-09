From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 7/7] HDA patch_via.c: Second S/PDIF (HDMI)
	support
Date: Tue, 9 Sep 2008 16:02:09 +0800
Message-ID: <20080909080209.GJ9638@prithivi.gnumonks.org>
References: <20080909073717.GC9638@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 1780A103852
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:02:44 +0200 (CEST)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.63)
	(envelope-from <HaraldWelte@viatech.com>) id 1KcyBP-0007uq-Ox
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 10:02:43 +0200
Received: from laforge by prithivi.gnumonks.org with local (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1KcyAr-0004zT-8D
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 16:02:09 +0800
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

[ALSA] HDA VIA: Add second S/PDIF output support for VT1702 and VT1708S

The VT1702 and VT1708S have a second S/PDIF output which is used to
connect to a HDMI transmitter.  This patch adds support for it.

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

Index: linux-2.6/sound/pci/hda/patch_via.c
===================================================================
--- linux-2.6.orig/sound/pci/hda/patch_via.c
+++ linux-2.6/sound/pci/hda/patch_via.c
@@ -34,6 +34,7 @@
 /* 2008-03-06  Lydia Wang  Add VT1702 codec and VT1708S codec support        */
 /* 2008-04-09  Lydia Wang  Add mute front speaker when HP plugin             */
 /* 2008-04-09  Lydia Wang  Add Independent HP feature                        */
+/* 2008-05-28  Lydia Wang  Add second S/PDIF Out support for VT1702	     */
 /*                                                                           */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
 
@@ -122,9 +123,11 @@
 	char *stream_name_digital;
 	struct hda_pcm_stream *stream_digital_playback;
 	struct hda_pcm_stream *stream_digital_capture;
+	struct hda_pcm_stream *stream_extra_digital_playback;
 
 	/* playback */
 	struct hda_multi_out multiout;
+	hda_nid_t extra_dig_out_nid;
 
 	/* capture */
 	unsigned int num_adc_nids;
@@ -136,7 +139,7 @@
 	unsigned int cur_mux[3];
 
 	/* PCM information */
-	struct hda_pcm pcm_rec[2];
+	struct hda_pcm pcm_rec[3];
 
 	/* dynamic controls, init_verbs and input_mux */
 	struct auto_pin_cfg autocfg;
@@ -665,6 +668,36 @@
 					     stream_tag, format, substream);
 }
 
+/* setup SPDIF output stream */
+static void setup_dig_playback_stream(struct hda_codec *codec, hda_nid_t nid,
+				 unsigned int stream_tag, unsigned int format)
+{
+	/* turn off SPDIF once; otherwise the IEC958 bits won't be updated */
+	if (codec->spdif_ctls & AC_DIG1_ENABLE)
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
+				    codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
+	snd_hda_codec_setup_stream(codec, nid, stream_tag, 0, format);
+	/* turn on again (if needed) */
+	if (codec->spdif_ctls & AC_DIG1_ENABLE)
+		snd_hda_codec_write(codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
+				    codec->spdif_ctls & 0xff);
+}
+
+static int via_extra_dig_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
+					struct hda_codec *codec,
+					unsigned int stream_tag,
+					unsigned int format,
+					struct snd_pcm_substream *substream)
+{
+	struct via_spec *spec = codec->spec;
+
+	mutex_lock(&codec->spdif_mutex);
+	setup_dig_playback_stream(codec, spec->extra_dig_out_nid, stream_tag,
+				  format);
+	mutex_unlock(&codec->spdif_mutex);
+	return 0;
+}
+
 /*
  * Analog capture
  */
@@ -765,6 +798,13 @@
 		if (err < 0)
 			return err;
 		spec->multiout.share_spdif = 1;
+
+		if (spec->extra_dig_out_nid) {
+			err = snd_hda_create_spdif_out_ctls(codec,
+						    spec->extra_dig_out_nid);
+			if (err < 0)
+				return err;
+		}
 	}
 	if (spec->dig_in_nid) {
 		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
@@ -815,6 +849,17 @@
 		}
 	}
 
+	if (spec->extra_dig_out_nid) {
+		codec->num_pcms++;
+		info++;
+		info->name = spec->stream_name_digital;
+		info->pcm_type = HDA_PCM_TYPE_HDMI;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
+				*(spec->stream_extra_digital_playback);
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
+				spec->extra_dig_out_nid;
+	}
+
 	return 0;
 }
 
@@ -2470,6 +2515,16 @@
 	},
 };
 
+static struct hda_pcm_stream vt1708S_pcm_extra_digital_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in via_build_pcms */
+	.ops = {
+		.prepare = via_extra_dig_playback_pcm_prepare
+	},
+};
+
 /* fill in the dac_nids table from the parsed pin configuration */
 static int vt1708S_auto_fill_dac_nids(struct via_spec *spec,
 				     const struct auto_pin_cfg *cfg)
@@ -2706,6 +2761,8 @@
 	if (spec->autocfg.dig_out_pin)
 		spec->multiout.dig_out_nid = VT1708S_DIGOUT_NID;
 
+	spec->extra_dig_out_nid = 0x15;
+
 	if (spec->kctl_alloc)
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
@@ -2757,6 +2814,8 @@
 
 	spec->stream_name_digital = "VT1708S Digital";
 	spec->stream_digital_playback = &vt1708S_pcm_digital_playback;
+	spec->stream_extra_digital_playback =
+					&vt1708S_pcm_extra_digital_playback;
 
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1708S_adc_nids;
@@ -2872,6 +2931,16 @@
 	},
 };
 
+static struct hda_pcm_stream vt1702_pcm_extra_digital_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in via_build_pcms */
+	.ops = {
+		.prepare = via_extra_dig_playback_pcm_prepare
+	},
+};
+
 /* fill in the dac_nids table from the parsed pin configuration */
 static int vt1702_auto_fill_dac_nids(struct via_spec *spec,
 				     const struct auto_pin_cfg *cfg)
@@ -3023,6 +3092,8 @@
 	if (spec->autocfg.dig_out_pin)
 		spec->multiout.dig_out_nid = VT1702_DIGOUT_NID;
 
+	spec->extra_dig_out_nid = 0x1B;
+
 	if (spec->kctl_alloc)
 		spec->mixers[spec->num_mixers++] = spec->kctl_alloc;
 
@@ -3076,6 +3147,8 @@
 
 	spec->stream_name_digital = "VT1702 Digital";
 	spec->stream_digital_playback = &vt1702_pcm_digital_playback;
+	spec->stream_extra_digital_playback =
+					&vt1702_pcm_extra_digital_playback;
 
 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1702_adc_nids;
-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
