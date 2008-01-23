From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH1/2] hda: Added mono_out_pin to autoconfig
Date: Wed, 23 Jan 2008 13:46:15 -0500
Message-ID: <47978B77.6080108@embeddedalley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp102.biz.mail.re2.yahoo.com (smtp102.biz.mail.re2.yahoo.com
	[68.142.229.216])
	by alsa0.perex.cz (Postfix) with SMTP id E7D63103850
	for <alsa-devel@alsa-project.org>; Wed, 23 Jan 2008 19:46:22 +0100 (CET)
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Added a mono_out_pin field to autocfg struct, and code to parse for the mono_out_line.

Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
---
diff -r 5492010913f0 pci/hda/hda_codec.c
--- a/pci/hda/hda_codec.c	Tue Jan 22 15:37:13 2008 +0100
+++ b/pci/hda/hda_codec.c	Wed Jan 23 10:55:11 2008 -0500
@@ -769,7 +769,7 @@ get_alloc_amp_hash(struct hda_codec *cod
 /*
  * query AMP capabilities for the given widget and direction
  */
-static u32 query_amp_caps(struct hda_codec *codec, hda_nid_t nid, int direction)
+u32 query_amp_caps(struct hda_codec *codec, hda_nid_t nid, int direction)
 {
 	struct hda_amp_info *info;
 
@@ -2708,6 +2708,10 @@ int snd_hda_parse_pin_def_config(struct 
 		case AC_JACK_LINE_OUT:
 			seq = get_defcfg_sequence(def_conf);
 			assoc = get_defcfg_association(def_conf);
+
+			if (!(wid_caps & AC_WCAP_STEREO))
+				if (!cfg->mono_out_pin)
+					cfg->mono_out_pin = nid;
 			if (!assoc)
 				continue;
 			if (!assoc_line_out)
@@ -2856,6 +2860,7 @@ int snd_hda_parse_pin_def_config(struct 
 		   cfg->hp_outs, cfg->hp_pins[0],
 		   cfg->hp_pins[1], cfg->hp_pins[2],
 		   cfg->hp_pins[3], cfg->hp_pins[4]);
+	snd_printd("   mono: mono_out=0x%x\n", cfg->mono_out_pin);
 	snd_printd("   inputs: mic=0x%x, fmic=0x%x, line=0x%x, fline=0x%x,"
 		   " cd=0x%x, aux=0x%x\n",
 		   cfg->input_pins[AUTO_PIN_MIC],
diff -r 5492010913f0 pci/hda/hda_local.h
--- a/pci/hda/hda_local.h	Tue Jan 22 15:37:13 2008 +0100
+++ b/pci/hda/hda_local.h	Wed Jan 23 10:56:40 2008 -0500
@@ -332,6 +332,7 @@ struct auto_pin_cfg {
 	hda_nid_t input_pins[AUTO_PIN_LAST];
 	hda_nid_t dig_out_pin;
 	hda_nid_t dig_in_pin;
+	hda_nid_t mono_out_pin;
 };
 
 #define get_defcfg_connect(cfg) \
@@ -374,6 +375,7 @@ static inline u32 get_wcaps(struct hda_c
 	return codec->wcaps[nid - codec->start_nid];
 }
 
+u32 query_amp_caps(struct hda_codec *codec, hda_nid_t nid, int direction);
 int snd_hda_override_amp_caps(struct hda_codec *codec, hda_nid_t nid, int dir,
 			      unsigned int caps);
