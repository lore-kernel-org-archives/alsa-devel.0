From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 2/7] HDA patch_via.c: HP and CD pin connect
	config
Date: Tue, 9 Sep 2008 15:50:37 +0800
Message-ID: <20080909075037.GE9638@prithivi.gnumonks.org>
References: <20080909073717.GC9638@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 2480C10384A
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 10:02:43 +0200 (CEST)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.63)
	(envelope-from <HaraldWelte@viatech.com>) id 1KcyBO-0007uZ-NS
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 10:02:42 +0200
Received: from laforge by prithivi.gnumonks.org with local (Exim 4.69)
	(envelope-from <HaraldWelte@viatech.com>) id 1Kcxzh-0004yG-IH
	for alsa-devel@alsa-project.org; Tue, 09 Sep 2008 15:50:37 +0800
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

[ALSA] HDA VIA: Add HP and CD pin connect config

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>

diff --git a/sound/pci/hda/patch_via.c b/sound/pci/hda/patch_via.c
index e7e4352..ad8eeb5 100644
--- a/sound/pci/hda/patch_via.c
+++ b/sound/pci/hda/patch_via.c
@@ -3,8 +3,8 @@
  *
  * HD audio interface patch for VIA VT1708 codec
  *
- * Copyright (c) 2006 Lydia Wang <lydiawang@viatech.com>
- *                    Takashi Iwai <tiwai@suse.de>
+ * Copyright (c) 2006-2008 Lydia Wang <lydiawang@viatech.com>
+ *			   Takashi Iwai <tiwai@suse.de>
  *
  *  This driver is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -29,6 +29,7 @@
 /* 2006-09-08  Lydia Wang  Fix internal loopback recording source select bug */
 /* 2007-09-12  Lydia Wang  Add EAPD enable during driver initialization      */
 /* 2007-09-17  Lydia Wang  Add VT1708B codec support                        */
+/* 2007-11-14  Lydia Wang  Add VT1708A codec HP and CD pin connect config    */
 /*                                                                           */
 /* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */
 
@@ -53,6 +54,8 @@
 #define VT1708_DIGOUT_NID	0x14
 #define VT1708_DIGIN_NID	0x16
 #define VT1708_DIGIN_PIN	0x26
+#define VT1708_HP_PIN_NID      0x20
+#define VT1708_CD_PIN_NID      0x24
 
 #define VT1709_HP_DAC_NID	0x28
 #define VT1709_DIGOUT_NID	0x13
@@ -840,11 +843,36 @@ static struct hda_amp_list vt1708_loopbacks[] = {
 };
 #endif
 
+static void vt1708_set_pinconfig_connect(struct hda_codec *codec, hda_nid_t nid)
+{
+	unsigned int def_conf;
+	unsigned char seqassoc;
+
+	def_conf = snd_hda_codec_read(codec, nid, 0,
+				      AC_VERB_GET_CONFIG_DEFAULT, 0);
+	seqassoc = (unsigned char) get_defcfg_association(def_conf);
+	seqassoc = (seqassoc << 4) | get_defcfg_sequence(def_conf);
+	if (get_defcfg_connect(def_conf) == AC_JACK_PORT_NONE) {
+		if (seqassoc == 0xff) {
+			def_conf = def_conf & (~(AC_JACK_PORT_BOTH << 30));
+			snd_hda_codec_write(codec, nid, 0,
+					    AC_VERB_SET_CONFIG_DEFAULT_BYTES_3,
+					    def_conf >> 24);
+		}
+	}
+
+	return;
+}
+
 static int vt1708_parse_auto_config(struct hda_codec *codec)
 {
 	struct via_spec *spec = codec->spec;
 	int err;
 
+	/* Add HP and CD pin config connect bit re-config action */
+	vt1708_set_pinconfig_connect(codec, VT1708_HP_PIN_NID);
+	vt1708_set_pinconfig_connect(codec, VT1708_CD_PIN_NID);
+
 	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
 	if (err < 0)
 		return err;
-- 
- Harald Welte <HaraldWelte@viatech.com>	    http://linux.via.com.tw/
============================================================================
VIA Open Source Liaison
