From: Li Bo <liboat@gmail.com>
Subject: [PATCH 4/31] HDA patch_via.c: Modify VT1702 AA-Path
	max volume
Date: Mon, 5 Oct 2009 22:24:52 +0800
Message-ID: <16685ee0910050724m1d48f774jb3f1bcf4b984d1f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 8993410384B
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:24:52 +0200 (CEST)
Received: by mail-fx0-f212.google.com with SMTP id 8so2789765fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:24:52 -0700 (PDT)
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

[ALSA] HDA VIA: Modify VT1702 AA-Path max volume

according to customer request, VT1702 AA-Path max volume (12 dB) is too
high, so limit to 0 dB.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-04 23:05:19.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 00:24:34.000000000 +0800
@@ -3166,6 +3166,12 @@
 	err = vt1702_auto_create_hp_ctls(spec, spec->autocfg.hp_pins[0]);
 	if (err < 0)
 		return err;
+	/* limit AA path volume to 0 dB */
+	snd_hda_override_amp_caps(codec, 0x1A, HDA_INPUT,
+				  (0x17 << AC_AMPCAP_OFFSET_SHIFT) |
+				  (0x17 << AC_AMPCAP_NUM_STEPS_SHIFT) |
+				  (0x5 << AC_AMPCAP_STEP_SIZE_SHIFT) |
+				  (1 << AC_AMPCAP_MUTE_SHIFT));
 	err = vt1702_auto_create_analog_input_ctls(spec, &spec->autocfg);
 	if (err < 0)
 		return err;
