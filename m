From: Torben Schulz <public@letorbi.de>
Subject: [PATCH 1/1] ALC889A chip identification
Date: Fri, 15 May 2009 02:34:07 +0200
Message-ID: <4A0CB87F.70405@letorbi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lvps87-230-79-166.dedicated.hosteurope.de
	(lvps87-230-79-166.dedicated.hosteurope.de [87.230.79.166])
	by alsa0.perex.cz (Postfix) with ESMTP id 5013E103925
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 02:34:44 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-Devel <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

With this patch the ALC889A chip will be identified correctly. The functions patch_alc882() and patch_alc883() have been altered to set the stream names correctly. Without this patch 'aplay -l' would identify an ALC889A chip as ALC885 for example. Apart from that a kernel info message will be printed if ALC885 or ALC889A chips are handled by the wrong patch function.

Signed-off by: Torben Schulz <public@letorbi.de>

--- alsa-driver/alsa-kernel/pci/hda/patch_realtek.c	2009-05-14 18:23:17.000000000 +0200
+++ alsa-driver-mod/alsa-kernel/pci/hda/patch_realtek.c	2009-05-15 01:08:16.000000000 +0200
@@ -7338,8 +7338,17 @@
		setup_preset(spec, &alc882_presets[board_config]);

	if (codec->vendor_id == 0x10ec0885) {
-		spec->stream_name_analog = "ALC885 Analog";
-		spec->stream_name_digital = "ALC885 Digital";
+		if ((codec->revision_id == 0x100101) ||
+ 		    (codec->revision_id == 0x100103)) {
+ 			spec->stream_name_analog = "ALC889A Analog";
+ 			spec->stream_name_digital = "ALC889A Digital";
+			printk(KERN_INFO
+			       "hda_codec: ALC889A handled by patch_alc882(),"
+				" should be handled by patch_alc883()\n");
+ 		} else {
+ 			spec->stream_name_analog = "ALC885 Analog";
+ 			spec->stream_name_digital = "ALC885 Digital";
+ 		}
	} else {
		spec->stream_name_analog = "ALC882 Analog";
		spec->stream_name_digital = "ALC882 Digital";
@@ -9231,6 +9240,27 @@
		setup_preset(spec, &alc883_presets[board_config]);

	switch (codec->vendor_id) {
+ 	case 0x10ec0885:
+ 		if ((codec->revision_id == 0x100101) ||
+ 		    (codec->revision_id == 0x100103)) {
+ 			spec->stream_name_analog = "ALC889A Analog";
+ 			spec->stream_name_digital = "ALC889A Digital";
+			if (!spec->num_adc_nids) {
+				spec->num_adc_nids = ARRAY_SIZE(alc883_adc_nids);
+				spec->adc_nids = alc883_adc_nids;
+			}
+			if (!spec->capsrc_nids)
+				spec->capsrc_nids = alc883_capsrc_nids;
+			spec->capture_style = CAPT_MIX; /* matrix-style capture */
+			spec->init_amp = ALC_INIT_DEFAULT; /* always initialize */
+ 		} else {
+ 			spec->stream_name_analog = "ALC885 Analog";
+ 			spec->stream_name_digital = "ALC885 Digital";
+			printk(KERN_INFO
+			       "hda_codec: ALC885 handled by patch_alc883(),"
+				" should be handled by patch_alc882()\n");
+ 		}
+ 		break;
	case 0x10ec0888:
		if (codec->revision_id == 0x100101) {
			spec->stream_name_analog = "ALC1200 Analog";
