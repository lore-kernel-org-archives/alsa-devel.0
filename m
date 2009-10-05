From: Li Bo <liboat@gmail.com>
Subject: [PATCH 15/31] HDA patch_via.c: Modify
	vt1708_set_pinconfig_connect function.
Date: Mon, 5 Oct 2009 22:27:26 +0800
Message-ID: <16685ee0910050727y2734efd5yf931cbb4a79d07cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AA6710385F
	for <alsa-devel@alsa-project.org>;
	Mon,  5 Oct 2009 16:27:26 +0200 (CEST)
Received: by mail-fx0-f212.google.com with SMTP id 8so2792157fxm.45
	for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2009 07:27:26 -0700 (PDT)
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

[ALSA] HDA VIA: Modify vt1708_set_pinconfig_connect function.

like seqassoc 0xff, seqassoc 0xf0 of vt1708 should override Port
Connectivity field into 'AC_JACK_PORT_COMPLEX'

Signed-off-by: Lydia Wang <lydiawang@viatech.com.cn>

Index: sound-2.6/sound/pci/hda/patch_via.c
===================================================================
--- sound-2.6.orig/sound/pci/hda/patch_via.c	2009-10-05 15:10:36.000000000 +0800
+++ sound-2.6/sound/pci/hda/patch_via.c	2009-10-05 15:10:49.000000000 +0800
@@ -1725,11 +1725,10 @@
 	def_conf = snd_hda_codec_get_pincfg(codec, nid);
 	seqassoc = (unsigned char) get_defcfg_association(def_conf);
 	seqassoc = (seqassoc << 4) | get_defcfg_sequence(def_conf);
-	if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE) {
-		if (seqassoc == 0xff) {
-			def_conf = def_conf & (~(AC_JACK_PORT_BOTH << 30));
-			snd_hda_codec_set_pincfg(codec, nid, def_conf);
-		}
+	if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE
+	    && (seqassoc == 0xf0 || seqassoc == 0xff)) {
+		def_conf = def_conf & (~(AC_JACK_PORT_BOTH << 30));
+		snd_hda_codec_set_pincfg(codec, nid, def_conf);
 	}

 	return;
