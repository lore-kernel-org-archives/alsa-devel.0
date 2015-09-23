From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH v2- ALSA 2/3] HDA - create headset mic jack
 which use headphone pin sense
Date: Wed, 23 Sep 2015 10:40:48 +0800
Message-ID: <CAN8cciZkD4gyNa6-r2f1JJEF8UhD0hbmxMDPVav9vVF-OU++tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id C0AD3265142
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2015 04:40:49 +0200 (CEST)
Received: by oixx17 with SMTP id x17so16628105oix.0
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 19:40:48 -0700 (PDT)
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

- use __snd_hda_jack_add_kctl to create headset mic jack which use
headphone pin sense

- set headset mic jack as slave of headphone jack

- allow non detectable headset mic pin and hs_mic_use_hp_sense pass check
auto mic availability

Signed-off-by: Raymond Yau <superquad.vortex2@gmail.com>

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 24f9111..e8e4e34 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -4662,7 +4662,9 @@ static int check_auto_mic_availability(struct
hda_codec *codec)
             if (!spec->line_in_auto_switch &&
                 cfg->inputs[i].type != AUTO_PIN_MIC)
                 return 0; /* only mic is allowed */
-            if (!is_jack_detectable(codec, nid))
+            if (!is_jack_detectable(codec, nid) &&
+                !(spec->hs_mic_use_hp_sense &&
+                cfg->inputs[i].is_headset_mic))
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
index d81d65f..c29f05e 100644
--- a/sound/pci/hda/hda_jack.c
+++ b/sound/pci/hda/hda_jack.c
@@ -480,6 +480,10 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
                const struct auto_pin_cfg *cfg)
 {
     const hda_nid_t *p;
+    struct hda_jack_tbl *jack;
+    struct hda_gen_spec *spec = codec->spec;
+    hda_nid_t hp_pin = auto_cfg_hp_pins(cfg)[0];
+    hda_nid_t hs_mic_pin = 0;
     int i, err;

     for (i = 0; i < cfg->num_inputs; i++) {
@@ -493,6 +497,13 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
                 err = add_jack_kctl(codec, cfg->inputs[i].pin,
                             cfg, "Headphone Mic");
         } else
+        if (cfg->inputs[i].is_headset_mic &&
+            !is_jack_detectable(codec, cfg->inputs[i].pin) &&
+             spec->hs_mic_use_hp_sense) {
+            hs_mic_pin = cfg->inputs[i].pin;
+            err = __snd_hda_jack_add_kctl(codec, cfg->inputs[i].pin,
+                    "Headset Mic", false, hp_pin);
+        } else
             err = add_jack_kctl(codec, cfg->inputs[i].pin, cfg,
                         NULL);
         if (err < 0)
@@ -510,6 +521,11 @@ int snd_hda_jack_add_kctls(struct hda_codec *codec,
         err = add_jack_kctl(codec, *p, cfg, NULL);
         if (err < 0)
             return err;
+        if (*p == hp_pin && spec->hs_mic_use_hp_sense && hs_mic_pin) {
+            jack = snd_hda_jack_tbl_get(codec, *p);
+            if (jack)
+                jack->slave_nid = hs_mic_pin;
+        }
     }
     for (i = 0, p = cfg->speaker_pins; i < cfg->speaker_outs; i++, p++) {
         if (*p == *cfg->line_out_pins) /* might be duplicated */
-- 
2.5.0
