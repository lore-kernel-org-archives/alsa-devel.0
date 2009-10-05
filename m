From: Li Bo <liboat@gmail.com>
Subject: [PATCH 17/31] HDA patch_via.c: Add second S/PDIF out
	control for VT1708S and VT1702.
Date: Mon, 5 Oct 2009 22:27:35 +0800
Message-ID: <16685ee0910050727n4f3eb80ah113d214815de6342@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id A2DA71038A3
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:27:35 +0200 (CEST)
Received: by mail-bw0-f225.google.com with SMTP id 25so10052327bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:27:35 -0700 (PDT)
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

[ALSA] HDA VIA: Add second S/PDIF out control for VT1708S and VT1702.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:10:59.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:11:02.000000000 +0800
@@ -1265,6 +1265,13 @@
 		if (err < 0)
 			return err;
 		spec->multiout.share_spdif = 1;
+		/* lydia add for second spdif out */
+		if (spec->slave_dig_outs[0]) {
+			err = snd_hda_create_spdif_out_ctls(codec,
+						    spec->slave_dig_outs[0]);
+			if (err < 0)
+				return err;
+		}
 	}
 	if (spec->dig_in_nid) {
 		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
@@ -3127,7 +3134,7 @@
 };

 static struct hda_pcm_stream vt1708S_pcm_digital_playback = {
-	.substreams = 1,
+	.substreams = 2,
 	.channels_min = 2,
 	.channels_max = 2,
 	/* NID is set in via_build_pcms */
