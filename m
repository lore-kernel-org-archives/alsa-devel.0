From: asd <asd@marian1000.go.ro>
Subject: Patch for power on headphone amp on Realtek 883
Date: Mon, 09 Jun 2014 10:06:59 +0300
Message-ID: <1552287.TJAWsn00qn@marian1000.go.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7057536488488087875=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from marian1000.go.ro (5-14-228-204.residential.rdsnet.ro
 [5.14.228.204]) by alsa0.perex.cz (Postfix) with ESMTP id BC4C926554B
 for <Alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 09:07:00 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=marian1000.go.ro)
 by marian1000.go.ro with esmtp (Exim 4.82)
 (envelope-from <asd@marian1000.go.ro>) id 1WttfX-0001BQ-Px
 for Alsa-devel@alsa-project.org; Mon, 09 Jun 2014 10:06:59 +0300
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--===============7057536488488087875==
Content-Type: text/x-patch; charset="UTF-8"; name="parch_realtek_new.patch"
Content-Transfer-Encoding: 7Bit
Content-Disposition: attachment; filename="parch_realtek_new.patch"

Index: hda/hda_codec.h
===================================================================
--- hda.orig/hda_codec.h	2014-06-08 22:54:07.000000000 +0300
+++ hda/hda_codec.h	2014-06-09 09:43:42.359115743 +0300
@@ -259,6 +259,7 @@
 	HDA_PCM_NTYPES
 };
 
+
 /* for PCM creation */
 struct hda_pcm {
 	char *name;
@@ -287,6 +288,14 @@
 	u32 subsystem_id;
 	u32 revision_id;
 
+	/* custom pin complex headphone amp */
+	bool hp_set;
+	hda_nid_t hp_front;
+	hda_nid_t hp_rear;
+	hda_nid_t hp_clfe;
+	hda_nid_t hp_side;
+	hda_nid_t hp_fout;
+
 	/* detected preset */
 	const struct hda_codec_preset *preset;
 	struct module *owner;
Index: hda/patch_realtek.c
===================================================================
--- hda.orig/patch_realtek.c	2014-06-07 12:38:24.000000000 +0300
+++ hda/patch_realtek.c	2014-06-09 09:22:53.306622242 +0300
@@ -322,6 +322,12 @@
 		case 0x10ec0880:
 		case 0x10ec0882:
 		case 0x10ec0883:
+			codec->hp_set = 1;
+			codec->hp_front = 0x14;
+			codec->hp_rear = 0x15;
+			codec->hp_clfe = 0x16;
+			codec->hp_side = 0x17;
+			codec->hp_fout = 0x1b;
 		case 0x10ec0885:
 		case 0x10ec0887:
 		/*case 0x10ec0889:*/ /* this causes an SPDIF problem */
Index: hda/hda_codec.c
===================================================================
--- hda.orig/hda_codec.c	2014-06-08 22:54:07.000000000 +0300
+++ hda/hda_codec.c	2014-06-09 09:45:32.473468469 +0300
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <linux/module.h>
 #include <linux/async.h>
+#include <linux/delay.h>
 #include <sound/core.h>
 #include "hda_codec.h"
 #include <sound/asoundef.h>
@@ -120,6 +121,56 @@
 #define hda_call_pm_notify(codec, state) {}
 #endif
 
+static void enable_hp_codec(struct hda_codec *codec)
+{
+
+	mutex_unlock(&codec->control_mutex);
+	if ((codec->hp_set = 1)) {
+	snd_hda_codec_write(codec, codec->hp_front, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
+
+	snd_hda_codec_write(codec, codec->hp_rear, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
+
+	snd_hda_codec_write(codec, codec->hp_clfe, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
+
+	snd_hda_codec_write(codec, codec->hp_side, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
+
+	snd_hda_codec_write(codec, codec->hp_fout, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc0);
+	} 
+
+	mutex_lock(&codec->control_mutex);
+
+}
+
+static void mute_all_analog_outs(struct hda_codec *codec)
+{
+	mutex_unlock(&codec->control_mutex);
+	if ((codec->hp_set = 1)) {
+	snd_hda_codec_write(codec,codec->hp_front, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+	snd_hda_codec_write(codec,codec->hp_rear, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+	snd_hda_codec_write(codec,codec->hp_clfe, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+	snd_hda_codec_write(codec,codec->hp_side, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+
+	snd_hda_codec_write(codec,codec->hp_fout, 0,
+			    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
+	}
+	mutex_lock(&codec->control_mutex);
+}
+
+
+
+
 /**
  * snd_hda_get_jack_location - Give a location string of the jack
  * @cfg: pin default config value
@@ -5418,8 +5469,9 @@
 				/* FIXME: need notify? */
 			}
 		}
-		mutex_unlock(&codec->spdif_mutex);
+		mutex_unlock(&codec->spdif_mutex);    
 	}
+	enable_hp_codec(codec);
 	return snd_pcm_hw_constraint_step(substream->runtime, 0,
 					  SNDRV_PCM_HW_PARAM_CHANNELS, 2);
 }
@@ -5530,6 +5582,7 @@
 		mout->dig_out_used = 0;
 	}
 	mutex_unlock(&codec->spdif_mutex);
+	mute_all_analog_outs(codec);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_hda_multi_out_analog_cleanup);

--===============7057536488488087875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7057536488488087875==--
