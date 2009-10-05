From: Li Bo <liboat@gmail.com>
Subject: [PATCH 11/31] HDA patch_via.c: When changing input
	source, update 	jack power state.
Date: Mon, 5 Oct 2009 22:25:30 +0800
Message-ID: <16685ee0910050725g4dbd2884w4ca6d9d928f18c6a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com
	[209.85.218.225])
	by alsa0.perex.cz (Postfix) with ESMTP id C9AB310386B
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:25:30 +0200 (CEST)
Received: by mail-bw0-f225.google.com with SMTP id 25so10047195bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:25:30 -0700 (PDT)
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

[ALSA] HDA VIA: When changing input source, update jack power state.

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:09:55.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:10:05.000000000 +0800
@@ -548,6 +548,14 @@

 	if (!spec->mux_nids[adc_idx])
 		return -EINVAL;
+	/* switch to D0 beofre change index */
+	if (snd_hda_codec_read(codec, spec->mux_nids[adc_idx], 0,
+			       AC_VERB_GET_POWER_STATE, 0x00) != AC_PWRST_D0)
+		snd_hda_codec_write(codec, spec->mux_nids[adc_idx], 0,
+				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+	/* update jack power state */
+	set_jack_power_state(codec);
+
 	return snd_hda_input_mux_put(codec, spec->input_mux, ucontrol,
 				     spec->mux_nids[adc_idx],
 				     &spec->cur_mux[adc_idx]);
