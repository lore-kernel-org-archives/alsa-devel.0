From: Li Bo <liboat@gmail.com>
Subject: [PATCH 24/31] HDA patch_via.c: Add VT1828S and VT2020
	support.
Date: Mon, 5 Oct 2009 22:28:11 +0800
Message-ID: <16685ee0910050728j1784825q6c11779a6913c0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id D8EE51038E5
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:28:11 +0200 (CEST)
Received: by mail-bw0-f225.google.com with SMTP id 25so10052327bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:28:11 -0700 (PDT)
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
Cc: tiwai@suse.de, LoganLi@viatech.com.cn, HaraldWelte@viatech.com, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

[ALSA] HDA VIA: Add VT1828S and VT2020 support.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:11:24.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:11:26.000000000 +0800
@@ -121,6 +121,8 @@
 	else if ((dev_id & 0xfff) == 0x428
 		 && (dev_id >> 12) < 8)
 		codec_type = VT1718S;
+	else if (dev_id == 0x0441 || dev_id == 0x4441)
+		codec_type = VT1718S;
 	else
 		codec_type = UNKNOWN;
 	return codec_type;
@@ -4298,21 +4300,31 @@
 	spec->init_verbs[spec->num_iverbs++] = vt1718S_volume_init_verbs;
 	spec->init_verbs[spec->num_iverbs++] = vt1718S_uniwill_init_verbs;

-	spec->stream_name_analog = "VT1718S Analog";
+	if (codec->vendor_id == 0x11060441)
+		spec->stream_name_analog = "VT2020 Analog";
+	else if (codec->vendor_id == 0x11064441)
+		spec->stream_name_analog = "VT1828S Analog";
+	else
+		spec->stream_name_analog = "VT1718S Analog";
 	spec->stream_analog_playback = &vt1718S_pcm_analog_playback;
 	spec->stream_analog_capture = &vt1718S_pcm_analog_capture;

-	spec->stream_name_digital = "VT1718S Digital";
+	if (codec->vendor_id == 0x11060441)
+		spec->stream_name_digital = "VT2020 Digital";
+	else if (codec->vendor_id == 0x11064441)
+		spec->stream_name_digital = "VT1828S Digital";
+	else
+		spec->stream_name_digital = "VT1718S Digital";
 	spec->stream_digital_playback = &vt1718S_pcm_digital_playback;
-	if (codec->vendor_id == 0x11060428)
+	if (codec->vendor_id == 0x11060428 || codec->vendor_id == 0x11060441)
 		spec->stream_digital_capture = &vt1718S_pcm_digital_capture;

 	if (!spec->adc_nids && spec->input_mux) {
 		spec->adc_nids = vt1718S_adc_nids;
 		spec->num_adc_nids = ARRAY_SIZE(vt1718S_adc_nids);
 		get_mux_nids(codec);
-		override_mic_boost(codec, 0x1a, 0, 3, 40);
-		override_mic_boost(codec, 0x1e, 0, 3, 40);
+		override_mic_boost(codec, 0x2b, 0, 3, 40);
+		override_mic_boost(codec, 0x29, 0, 3, 40);
 		spec->mixers[spec->num_mixers] = vt1718S_capture_mixer;
 		spec->num_mixers++;
 	}
@@ -4404,6 +4416,10 @@
 	  .patch = patch_vt1718S},
 	{ .id = 0x11064428, .name = "VT1718S",
 	  .patch = patch_vt1718S},
+	{ .id = 0x11060441, .name = "VT2020",
+	  .patch = patch_vt1718S},
+	{ .id = 0x11064441, .name = "VT1828S",
+	  .patch = patch_vt1718S},
 	{} /* terminator */
 };
