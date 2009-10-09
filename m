From: <LoganLi@viatech.com.cn>
Subject: [PATCH 17/30] ALSA: HDA VIA: Add 2nd S/PDIF out for
	VT1708S and VT1702.
Date: Fri, 9 Oct 2009 18:40:49 +0800
Message-ID: <5B2BE0DB92BC8F4694F815C2F34E0D5F123C3E@exchbj03.viatech.com.bj>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from exchtp08.via.com.tw (exchtp08.via.com.tw [61.66.243.7])
	by alsa0.perex.cz (Postfix) with ESMTP id 77CC0103A87
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 12:40:43 +0200 (CEST)
Content-class: urn:content-classes:message
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
Cc: tiwai@suse.de, HaraldWelte@viatech.com, LydiaWang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

From: Lydia Wang <lydiawang@viatech.com.cn>
Subject: ALSA: HDA VIA: Add 2nd S/PDIF out for VT1708S and VT1702.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>
Signed-off-by: Logan Li <loganli@viatech.com.cn>

---
 pci/hda/patch_via.c |   37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

--- a/pci/hda/patch_via.c
+++ b/pci/hda/patch_via.c
@@ -107,7 +107,7 @@
 
 	/* playback */
 	struct hda_multi_out multiout;
-	hda_nid_t slave_dig_outs[2];
+	hda_nid_t second_dig_out;
 
 	/* capture */
 	unsigned int num_adc_nids;
@@ -1179,8 +1179,23 @@
 					struct snd_pcm_substream
*substream)
 {
 	struct via_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_prepare(codec, &spec->multiout,
-					     stream_tag, format,
substream);
+	hda_nid_t nid = substream->number == 0
+		? spec->multiout.dig_out_nid : spec->second_dig_out;
+	mutex_lock(&codec->spdif_mutex);
+	/* copy from hda_codec.c: setup_dig_out_stream */
+	/* turn off SPDIF once; otherwise the IEC958 bits won't be
updated */
+	if (codec->spdif_status_reset && (codec->spdif_ctls &
AC_DIG1_ENABLE))
+		snd_hda_codec_write_cache(
+			codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
+			codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
+	snd_hda_codec_setup_stream(codec, nid, stream_tag, 0, format);
+	/* turn on again (if needed) */
+	if (codec->spdif_status_reset && (codec->spdif_ctls &
AC_DIG1_ENABLE))
+		snd_hda_codec_write_cache(
+			codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
+			codec->spdif_ctls & 0xff);
+	mutex_unlock(&codec->spdif_mutex);
+	return 0;
 }
 
 static int via_dig_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
@@ -1298,6 +1313,13 @@
 		if (err < 0)
 			return err;
 		spec->multiout.share_spdif = 1;
+		/* add second spdif out */
+		if (spec->second_dig_out) {
+			err = snd_hda_create_spdif_out_ctls(
+				codec, spec->second_dig_out);
+			if (err < 0)
+				return err;
+		}
 	}
 	if (spec->dig_in_nid) {
 		err = snd_hda_create_spdif_in_ctls(codec,
spec->dig_in_nid);
@@ -1472,11 +1494,6 @@
 	} else /* enable SPDIF-input pin */
 		snd_hda_codec_write(codec, spec->autocfg.dig_in_pin, 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL,
PIN_IN);
-
-	/* assign slave outs */
-	if (spec->slave_dig_outs[0])
-		codec->slave_dig_outs = spec->slave_dig_outs;
-
  	return 0;
 }
 
@@ -3163,7 +3180,7 @@
 };
 
 static struct hda_pcm_stream vt1708S_pcm_digital_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
 	/* NID is set in via_build_pcms */
@@ -3399,7 +3416,7 @@
 		if (!spec->multiout.dig_out_nid)
 			spec->multiout.dig_out_nid = nid;
 		else {
-			spec->slave_dig_outs[0] = nid;
+			spec->second_dig_out = nid;
 			break; /* at most two dig outs */
 		}
 	}
