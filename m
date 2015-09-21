From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: [PATCH - 2/2] HDA - add headset-sonicmaster and
 headset-multi-sonicmaster models
Date: Mon, 21 Sep 2015 10:12:44 +0800
Message-ID: <CAN8cciY918bWjx7-GouR5biH072M=46YS0y6oMnzFOSrTQtTZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f178.google.com (mail-ob0-f178.google.com
 [209.85.214.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 81C4F26057F
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 04:12:45 +0200 (CEST)
Received: by obbmp4 with SMTP id mp4so38253548obb.3
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 19:12:45 -0700 (PDT)
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

>From e97383136359c5d3ef93282888540bbb20939a9e Mon Sep 17 00:00:00 2001
From: Raymond Yau <superquad.vortex2@gmail.com>
Date: Sun, 20 Sep 2015 22:18:56 +0800
Subject: [PATCH -  2/2] HDA - add headset-sonicmaster and
 headset-multi-sonicmaster models

add headset only model for ALC668 with Sonic Master Subwoofer

add 625ms delay after headset is plugged for correct detection of headset
type for ALC668

add headset multi model with Sonice Master Subwoofer

update HD-Audio-Models.txt

Signed-off-by: Raymond Yau <superquad.vortex2@gmail.com>

diff --git a/Documentation/sound/alsa/HD-Audio-Models.txt
b/Documentation/sound/alsa/HD-Audio-Models.txt
index ec099d4..8baddac 100644
--- a/Documentation/sound/alsa/HD-Audio-Models.txt
+++ b/Documentation/sound/alsa/HD-Audio-Models.txt
@@ -55,7 +55,12 @@ ALC66x/67x/892
   asus-mode7        ASUS
   asus-mode8        ASUS
   inv-dmic        Inverted internal mic workaround
+
+ALC668
+======
   dell-headset-multi    Headset jack, which can also be used as mic-in
+  headset-sonicmaster   Headset jack and SonicMaster Subwoofer
+  headset-multi-sonicmaster    Headset, HP or Mic and SonicMaster Subwoofer

 ALC680
 ======
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index a75b561..91de00c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4029,7 +4029,13 @@ static void alc_update_headset_mode(struct hda_codec
*codec)
                           PIN_VREFHIZ);
     }
     spec->current_headset_mode = new_headset_mode;
-
+    if (codec->core.vendor_id == 0x10ec0668) {
+        if (spec->gen.hs_mic_use_hp_sense && spec->gen.auto_mic) {
+            if (new_headset_mode == ALC_HEADSET_MODE_HEADPHONE)
+                msleep(625);
+            snd_hda_gen_mic_autoswitch(codec, NULL);
+        };
+    }
     snd_hda_gen_update_outputs(codec);
 }

@@ -6071,6 +6077,42 @@ static void alc662_fixup_led_gpio1(struct hda_codec
*codec,
     }
 }

+static void alc668_fixup_asus_headset_only(struct hda_codec *codec,
+                    const struct hda_fixup *fix, int action)
+{
+    const struct hda_pintbl hs_mic_pin[] = {
+        { 0x1b, 0x03a1113c }, /* headset mic */
+        { }
+    };
+    struct alc_spec *spec = codec->spec;
+
+    switch (action) {
+    case HDA_FIXUP_ACT_PRE_PROBE:
+        snd_hda_apply_pincfgs(codec, hs_mic_pin);
+        spec->gen.hs_mic_use_hp_sense = 1;
+        alc_fixup_disable_aamix(codec, fix, action);
+        break;
+    }
+}
+
+static void alc668_fixup_sonicmaster(struct hda_codec *codec,
+                    const struct hda_fixup *fix, int action)
+{
+    const struct hda_pintbl bass_pin[] = {
+        { 0x1a, 0x04110011 }, /* external subwoofer */
+        { }
+    };
+
+    switch (action) {
+    case HDA_FIXUP_ACT_PRE_PROBE:
+        snd_hda_apply_pincfgs(codec, bass_pin);
+        break;
+    case HDA_FIXUP_ACT_BUILD:
+        alc_fixup_bass_chmap(codec, fix, action);
+        break;
+    }
+}
+
 static struct coef_fw alc668_coefs[] = {
     WRITE_COEF(0x01, 0xbebe), WRITE_COEF(0x02, 0xaaaa),
WRITE_COEF(0x03,    0x0),
     WRITE_COEF(0x04, 0x0180), WRITE_COEF(0x06,    0x0), WRITE_COEF(0x07,
0x0f80),
@@ -6130,6 +6172,9 @@ enum {
     ALC668_FIXUP_AUTO_MUTE,
     ALC668_FIXUP_DELL_DISABLE_AAMIX,
     ALC668_FIXUP_DELL_XPS13,
+    ALC668_FIXUP_HEADSET_ONLY,
+    ALC668_FIXUP_HEADSET_SONICMASTER,
+    ALC668_FIXUP_HEADSET_MULTI_SONICMASTER,
 };

 static const struct hda_fixup alc662_fixups[] = {
@@ -6370,6 +6415,24 @@ static const struct hda_fixup alc662_fixups[] = {
         .type = HDA_FIXUP_FUNC,
         .v.func = alc_fixup_bass_chmap,
     },
+    [ALC668_FIXUP_HEADSET_ONLY] = {
+        .type = HDA_FIXUP_FUNC,
+        .v.func = alc668_fixup_asus_headset_only,
+        .chained = true,
+        .chain_id = ALC668_FIXUP_HEADSET_MODE,
+    },
+    [ALC668_FIXUP_HEADSET_SONICMASTER] = {
+        .type = HDA_FIXUP_FUNC,
+        .v.func = alc668_fixup_sonicmaster,
+        .chained = true,
+        .chain_id = ALC668_FIXUP_HEADSET_ONLY,
+    },
+    [ALC668_FIXUP_HEADSET_MULTI_SONICMASTER] = {
+        .type = HDA_FIXUP_FUNC,
+        .v.func = alc668_fixup_sonicmaster,
+        .chained = true,
+        .chain_id = ALC668_FIXUP_DELL_DISABLE_AAMIX,
+    },
 };

 static const struct snd_pci_quirk alc662_fixup_tbl[] = {
@@ -6476,6 +6539,9 @@ static const struct hda_model_fixup
alc662_fixup_models[] = {
     {.id = ALC662_FIXUP_ASUS_MODE8, .name = "asus-mode8"},
     {.id = ALC662_FIXUP_INV_DMIC, .name = "inv-dmic"},
     {.id = ALC668_FIXUP_DELL_MIC_NO_PRESENCE, .name =
"dell-headset-multi"},
+    {.id = ALC668_FIXUP_HEADSET_SONICMASTER, .name =
"headset-sonicmaster"},
+    {.id = ALC668_FIXUP_HEADSET_MULTI_SONICMASTER,
+        .name = "headset-multi-sonicmaster"},
     {}
 };

-- 
2.5.0
