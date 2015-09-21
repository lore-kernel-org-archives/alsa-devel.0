From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH - 1/2] HDA - Add SND_JACK_HEADSET and Headset
	jack kctl
Date: Mon, 21 Sep 2015 10:12:32 +0800
Message-ID: <CAN8cciaSv0Tu_okSE-oXYd0ULrFxazfyZEcfMzTcPyyRCOfqog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f46.google.com (mail-oi0-f46.google.com
 [209.85.218.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 54F1326057F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 04:12:33 +0200 (CEST)
Received: by oibi136 with SMTP id i136so51599550oib.3
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 19:12:32 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de, arthurborsboom@gmail.com
List-Id: alsa-devel@alsa-project.org

>From b3ed187912eccf922000aee09c04f9546b068925 Mon Sep 17 00:00:00 2001
From: Raymond Yau <superquad.vortex2@gmail.com>
Date: Sun, 20 Sep 2015 22:10:18 +0800
Subject: [PATCH -  1/2] HDA - Add SND_JACK_HEADSET and Headset jack kctl

add headset jack kctl for alsa jack type SND_JACK_HEADSET

skip creation of Headset Mic Phantom Jack

use Headset Playback Volume and Headset Playback Switch

allow auto mic selection by using HP pin for jack sense

Signed-off-by: Raymond Yau <superquad.vortex2@gmail.com>

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 24f9111..ce6da6f 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -2140,7 +2140,8 @@ static int create_hp_out_ctls(struct hda_codec *codec)
     struct hda_gen_spec *spec = codec->spec;
     return create_extra_outs(codec, spec->autocfg.hp_outs,
                  spec->hp_paths,
-                 "Headphone");
+                 spec->hs_mic_use_hp_sense ?
+                "Headset" : "Headphone");
 }

 static int create_speaker_out_ctls(struct hda_codec *codec)
@@ -4362,6 +4363,16 @@ void snd_hda_gen_line_automute(struct hda_codec
*codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_line_automute);

+bool is_headset_mic(struct auto_pin_cfg *cfg, hda_nid_t pin)
+{
+    int i;
+
+    for (i = 0; i < cfg->num_inputs; i++)
+        if (cfg->inputs[i].pin == pin)
+            return cfg->inputs[i].is_headset_mic;
+    return 0;
+}
+
 /**
  * snd_hda_gen_mic_autoswitch - standard mic auto-switch helper
  * @codec: the HDA codec
@@ -4381,6 +4392,9 @@ void snd_hda_gen_mic_autoswitch(struct hda_codec
*codec,
         /* don't detect pins retasked as outputs */
         if (snd_hda_codec_get_pin_target(codec, pin) & AC_PINCTL_OUT_EN)
             continue;
+        if (spec->hs_mic_use_hp_sense &&
+            is_headset_mic(&spec->autocfg, pin))
+            pin = auto_cfg_hp_pins(&spec->autocfg)[0];
         if (snd_hda_jack_detect_state(codec, pin) == HDA_JACK_PRESENT) {
             mux_select(codec, 0, spec->am_entry[i].idx);
             return;
@@ -4662,7 +4676,9 @@ static int check_auto_mic_availability(struct
hda_codec *codec)
             if (!spec->line_in_auto_switch &&
                 cfg->inputs[i].type != AUTO_PIN_MIC)
                 return 0; /* only mic is allowed */
-            if (!is_jack_detectable(codec, nid))
+            if (!is_jack_detectable(codec, nid) &&
+                !(cfg->inputs[i].is_headset_mic &&
+                spec->hs_mic_use_hp_sense))
                 return 0; /* no unsol support */
             break;
         }
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 56e4139..96f8214 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -236,6 +236,7 @@ struct hda_gen_spec {
     unsigned int indep_hp_enabled:1; /* independent HP enabled */
     unsigned int have_aamix_ctl:1;
     unsigned int hp_mic_jack_modes:1;
+    unsigned int hs_mic_use_hp_sense:1;

     /* additional mute flags (only effective with auto_mute_via_amp=1) */
     u64 mute_bits;
diff --git a/sound/pci/hda/hda_jack.c b/sound/pci/hda/hda_jack.c
index 366efbf..5fa8ace 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -19,6 +19,7 @@
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_jack.h"
+#include "hda_generic.h"

 /**
  * is_jack_detectable - Check whether the given pin is jack-detectable
@@ -350,11 +351,14 @@ EXPORT_SYMBOL_GPL(snd_hda_jack_report_sync);
 static int get_input_jack_type(struct hda_codec *codec, hda_nid_t nid)
 {
     unsigned int def_conf = snd_hda_codec_get_pincfg(codec, nid);
+    struct hda_gen_spec *spec = codec->spec;
     switch (get_defcfg_device(def_conf)) {
     case AC_JACK_LINE_OUT:
     case AC_JACK_SPEAKER:
         return SND_JACK_LINEOUT;
     case AC_JACK_HP_OUT:
+        if (spec->hs_mic_use_hp_sense)
+            return SND_JACK_HEADSET;
         return SND_JACK_HEADPHONE;
     case AC_JACK_SPDIF_OUT:
     case AC_JACK_DIG_OTHER_OUT:
@@ -434,6 +438,7 @@ static int add_jack_kctl(struct hda_codec *codec,
hda_nid_t nid,
     char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
     int err;
     bool phantom_jack;
+    struct hda_gen_spec *spec = codec->spec;

     if (!nid)
         return 0;
@@ -446,8 +451,13 @@ static int add_jack_kctl(struct hda_codec *codec,
hda_nid_t nid,

     if (base_name)
         strlcpy(name, base_name, sizeof(name));
-    else
+    else {
         snd_hda_get_pin_label(codec, nid, cfg, name, sizeof(name), NULL);
+        if ((strcmp(name, "Headphone") == 0) &&
+            (nid == auto_cfg_hp_pins(cfg)[0]) &&
+            spec->hs_mic_use_hp_sense)
+            strlcpy(name, "Headset", sizeof(name));
+    }
     if (phantom_jack)
         /* Example final name: "Internal Mic Phantom Jack" */
         strncat(name, " Phantom", sizeof(name) - strlen(name) - 1);
@@ -469,6 +479,7 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
                const struct auto_pin_cfg *cfg)
 {
     const hda_nid_t *p;
+    struct hda_gen_spec *spec = codec->spec;
     int i, err;

     for (i = 0; i < cfg->num_inputs; i++) {
@@ -482,6 +493,10 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
                 err = add_jack_kctl(codec, cfg->inputs[i].pin,
                             cfg, "Headphone Mic");
         } else
+        if (cfg->inputs[i].is_headset_mic &&
+            spec->hs_mic_use_hp_sense)
+            err = 0;
+        else
             err = add_jack_kctl(codec, cfg->inputs[i].pin, cfg,
                         NULL);
         if (err < 0)
-- 
2.5.0
