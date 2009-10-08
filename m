From: Li Bo <liboat@gmail.com>
Subject: Re: [PATCH 17/31] HDA patch_via.c: Add second S/PDIF
	out control for VT1708S and VT1702.
Date: Thu, 8 Oct 2009 13:32:15 +0800
Message-ID: <16685ee0910072232s76b7482ehe84003f4fbb97c94@mail.gmail.com>
References: <16685ee0910050727n4f3eb80ah113d214815de6342@mail.gmail.com>
	<s5h63at6fff.wl%tiwai@suse.de>
	<16685ee0910052201n74138c01g69c08e5fe7f59f04@mail.gmail.com>
	<s5hfx9xrrci.wl%tiwai@suse.de>
	<16685ee0910060843q57923499q5fa80d642362fb6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 36C62103937
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Oct 2009 07:32:17 +0200 (CEST)
Received: by bwz25 with SMTP id 25so1461381bwz.32
	for <alsa-devel@alsa-project.org>; Wed, 07 Oct 2009 22:32:16 -0700 (PDT)
In-Reply-To: <16685ee0910060843q57923499q5fa80d642362fb6e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: LoganLi@viatech.com.cn, alsa-devel@alsa-project.org, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Add second S/PDIF out control for VT1708S and VT1702.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

---
 sound/pci/hda/patch_via.c |   37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -107,7 +107,7 @@

 	/* playback */
 	struct hda_multi_out multiout;
-	hda_nid_t slave_dig_outs[2];
+	hda_nid_t second_dig_out;

 	/* capture */
 	unsigned int num_adc_nids;
@@ -1177,8 +1177,23 @@
 					struct snd_pcm_substream *substream)
 {
 	struct via_spec *spec = codec->spec;
-	return snd_hda_multi_out_dig_prepare(codec, &spec->multiout,
-					     stream_tag, format, substream);
+	hda_nid_t nid = substream->number == 0
+		? spec->multiout.dig_out_nid : spec->second_dig_out;
+	mutex_lock(&codec->spdif_mutex);
+	/* copy from hda_codec.c: setup_dig_out_stream */
+	/* turn off SPDIF once; otherwise the IEC958 bits won't be updated */
+	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE))
+		snd_hda_codec_write_cache(
+			codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
+			codec->spdif_ctls & ~AC_DIG1_ENABLE & 0xff);
+	snd_hda_codec_setup_stream(codec, nid, stream_tag, 0, format);
+	/* turn on again (if needed) */
+	if (codec->spdif_status_reset && (codec->spdif_ctls & AC_DIG1_ENABLE))
+		snd_hda_codec_write_cache(
+			codec, nid, 0, AC_VERB_SET_DIGI_CONVERT_1,
+			codec->spdif_ctls & 0xff);
+	mutex_unlock(&codec->spdif_mutex);
+	return 0;
 }

 static int via_dig_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
@@ -1296,6 +1311,13 @@
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
 		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
@@ -1470,11 +1492,6 @@
 	} else /* enable SPDIF-input pin */
 		snd_hda_codec_write(codec, spec->autocfg.dig_in_pin, 0,
 				    AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN);
-
-	/* assign slave outs */
-	if (spec->slave_dig_outs[0])
-		codec->slave_dig_outs = spec->slave_dig_outs;
-
  	return 0;
 }

@@ -3162,7 +3179,7 @@
 };

 static struct hda_pcm_stream vt1708S_pcm_digital_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
 	/* NID is set in via_build_pcms */
@@ -3398,7 +3415,7 @@
 		if (!spec->multiout.dig_out_nid)
 			spec->multiout.dig_out_nid = nid;
 		else {
-			spec->slave_dig_outs[0] = nid;
+			spec->second_dig_out = nid;
 			break; /* at most two dig outs */
 		}
 	}
