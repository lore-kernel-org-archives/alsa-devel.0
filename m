From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Refactor Realtek's automute
Date: Tue, 20 Sep 2011 18:04:16 +0200
Message-ID: <4E78B980.8070609@canonical.com>
References: <4E786A56.3080202@canonical.com> <s5hwrd3z29b.wl%tiwai@suse.de>
	<4E78B152.8070903@canonical.com> <s5hr53bz0mw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040802070305030607060106"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 28ECD103A39
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Sep 2011 18:04:16 +0200 (CEST)
In-Reply-To: <s5hr53bz0mw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040802070305030607060106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 09/20/2011 05:36 PM, Takashi Iwai wrote:
> At Tue, 20 Sep 2011 17:29:22 +0200,
> David Henningsson wrote:
>>
>> On 09/20/2011 05:01 PM, Takashi Iwai wrote:
>>> At Tue, 20 Sep 2011 12:26:30 +0200,
>>> David Henningsson wrote:
>>>>
>>>> Ok, my automute refactoring has been rebased to your latest tree. I've
>>>> tested it on my own machine, but I don't know if wider testing is needed
>>>> to ensure there are no regressions.
>>>
>>> Thanks.
>>>
>>> alc_simple_setup_automute() calls can be more simplified.
>>> The function can check spec->autocfg.line_out_pins[0], hp_pins[0] and
>>> speaker_pins[0] to identify detect_hp&   co flags.  Otherwise, the
>>> arguments "1, 0, 0, 1" are hard to understand.
>>>
>>> Other than that, the patch looks good to me.
>>
>> That means a functional change in one place (alc882_quirks.c), where
>> there are line_out_pins but automute for line out is not set:
>>
>> @@ -2568,8 +2554,7 @@ static void alc888_lenovo_ms7195_setup(struct
>> hda_codec *codec)
>>           spec->autocfg.hp_pins[0] = 0x1b;
>>           spec->autocfg.line_out_pins[0] = 0x14;
>>           spec->autocfg.speaker_pins[0] = 0x15;
>> -       spec->automute = 1;
>> -       spec->automute_mode = ALC_AUTOMUTE_AMP;
>> +       alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP, 1, 0, 0, 1);
>>    }
>>
>> If you don't mind that change I can do what you suggest.
>
> The above must be a bug.  It should follow the standard configuration,
> too.  So you'll fix a bug automagically :)

Ok, attaching modified patch.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------040802070305030607060106
Content-Type: text/x-patch;
 name="0001-ALSA-HDA-Refactor-Realtek-s-automute.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-ALSA-HDA-Refactor-Realtek-s-automute.patch"

>From 9eeee0831982ed787ef43eb6f744306efc8c9973 Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 20 Sep 2011 12:04:56 +0200
Subject: [PATCH] ALSA: HDA: Refactor Realtek's automute

Increase readability and understandability in the automute code.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/alc262_quirks.c |   28 +++------
 sound/pci/hda/alc880_quirks.c |   17 ++---
 sound/pci/hda/alc882_quirks.c |   85 +++++++++-----------------
 sound/pci/hda/alc_quirks.c    |   13 ++++
 sound/pci/hda/patch_realtek.c |  136 ++++++++++++++++++++++-------------------
 5 files changed, 131 insertions(+), 148 deletions(-)

diff --git a/sound/pci/hda/alc262_quirks.c b/sound/pci/hda/alc262_quirks.c
index c37e0c2..7894b2b 100644
--- a/sound/pci/hda/alc262_quirks.c
+++ b/sound/pci/hda/alc262_quirks.c
@@ -61,10 +61,6 @@ static const struct snd_kcontrol_new alc262_base_mixer[] = {
 };
 
 /* bind hp and internal speaker mute (with plug check) as master switch */
-static void alc262_hippo_master_update(struct hda_codec *codec)
-{
-	update_speakers(codec);
-}
 
 static int alc262_hippo_master_sw_get(struct snd_kcontrol *kcontrol,
 				      struct snd_ctl_elem_value *ucontrol)
@@ -85,7 +81,7 @@ static int alc262_hippo_master_sw_put(struct snd_kcontrol *kcontrol,
 	if (val == spec->master_mute)
 		return 0;
 	spec->master_mute = val;
-	alc262_hippo_master_update(codec);
+	update_outputs(codec);
 	return 1;
 }
 
@@ -147,8 +143,7 @@ static void alc262_hippo_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc262_hippo1_setup(struct hda_codec *codec)
@@ -157,8 +152,7 @@ static void alc262_hippo1_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x14;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 
@@ -221,8 +215,7 @@ static void alc262_tyan_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x15;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 
@@ -364,8 +357,7 @@ static void alc262_toshiba_s06_setup(struct hda_codec *codec)
 	spec->ext_mic_pin = 0x18;
 	spec->int_mic_pin = 0x12;
 	spec->auto_mic = 1;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_PIN;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_PIN);
 }
 
 /*
@@ -446,8 +438,7 @@ static void alc262_fujitsu_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.hp_pins[1] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x15;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 /* bind volumes of both NID 0x0c and 0x0d */
@@ -493,8 +484,7 @@ static void alc262_lenovo_3000_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static const struct snd_kcontrol_new alc262_lenovo_3000_mixer[] = {
@@ -599,8 +589,8 @@ static void alc262_ultra_automute(struct hda_codec *codec)
 	mute = 0;
 	/* auto-mute only when HP is used as HP */
 	if (!spec->cur_mux[0]) {
-		spec->jack_present = snd_hda_jack_detect(codec, 0x15);
-		if (spec->jack_present)
+		spec->hp_jack_present = snd_hda_jack_detect(codec, 0x15);
+		if (spec->hp_jack_present)
 			mute = HDA_AMP_MUTE;
 	}
 	/* mute/unmute internal speaker */
diff --git a/sound/pci/hda/alc880_quirks.c b/sound/pci/hda/alc880_quirks.c
index c844d2b..bea22ed 100644
--- a/sound/pci/hda/alc880_quirks.c
+++ b/sound/pci/hda/alc880_quirks.c
@@ -749,8 +749,7 @@ static void alc880_uniwill_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x16;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc880_uniwill_init_hook(struct hda_codec *codec)
@@ -781,8 +780,7 @@ static void alc880_uniwill_p53_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc880_uniwill_p53_dcvol_automute(struct hda_codec *codec)
@@ -1051,8 +1049,7 @@ static void alc880_lg_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x17;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 /*
@@ -1137,8 +1134,7 @@ static void alc880_lg_lw_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x14;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static const struct snd_kcontrol_new alc880_medion_rim_mixer[] = {
@@ -1188,7 +1184,7 @@ static void alc880_medion_rim_automute(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 	alc_hp_automute(codec);
 	/* toggle EAPD */
-	if (spec->jack_present)
+	if (spec->hp_jack_present)
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 0);
 	else
 		snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_GPIO_DATA, 2);
@@ -1210,8 +1206,7 @@ static void alc880_medion_rim_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x1b;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 #ifdef CONFIG_SND_HDA_POWER_SAVE
diff --git a/sound/pci/hda/alc882_quirks.c b/sound/pci/hda/alc882_quirks.c
index 617d047..e251514 100644
--- a/sound/pci/hda/alc882_quirks.c
+++ b/sound/pci/hda/alc882_quirks.c
@@ -173,8 +173,7 @@ static void alc889_automute_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[2] = 0x17;
 	spec->autocfg.speaker_pins[3] = 0x19;
 	spec->autocfg.speaker_pins[4] = 0x1a;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc889_intel_init_hook(struct hda_codec *codec)
@@ -191,8 +190,7 @@ static void alc888_fujitsu_xa3530_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[1] = 0x1b; /* hp */
 	spec->autocfg.speaker_pins[0] = 0x14; /* speaker */
 	spec->autocfg.speaker_pins[1] = 0x15; /* bass */
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 /*
@@ -475,8 +473,7 @@ static void alc888_acer_aspire_4930g_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x17;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc888_acer_aspire_6530g_setup(struct hda_codec *codec)
@@ -487,8 +484,7 @@ static void alc888_acer_aspire_6530g_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x17;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc888_acer_aspire_7730g_setup(struct hda_codec *codec)
@@ -499,8 +495,7 @@ static void alc888_acer_aspire_7730g_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x17;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc889_acer_aspire_8930g_setup(struct hda_codec *codec)
@@ -511,8 +506,7 @@ static void alc889_acer_aspire_8930g_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x1b;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 #define ALC882_DIGOUT_NID	0x06
@@ -1711,8 +1705,7 @@ static void alc885_imac24_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x18;
 	spec->autocfg.speaker_pins[1] = 0x1a;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 #define alc885_mb5_setup	alc885_imac24_setup
@@ -1721,12 +1714,11 @@ static void alc885_imac24_setup(struct hda_codec *codec)
 /* Macbook Air 2,1 */
 static void alc885_mba21_setup(struct hda_codec *codec)
 {
-       struct alc_spec *spec = codec->spec;
+	struct alc_spec *spec = codec->spec;
 
-       spec->autocfg.hp_pins[0] = 0x14;
-       spec->autocfg.speaker_pins[0] = 0x18;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	spec->autocfg.hp_pins[0] = 0x14;
+	spec->autocfg.speaker_pins[0] = 0x18;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 
@@ -1737,8 +1729,7 @@ static void alc885_mbp3_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc885_imac91_setup(struct hda_codec *codec)
@@ -1748,8 +1739,7 @@ static void alc885_imac91_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x18;
 	spec->autocfg.speaker_pins[1] = 0x1a;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static const struct hda_verb alc882_targa_verbs[] = {
@@ -1773,7 +1763,7 @@ static void alc882_targa_automute(struct hda_codec *codec)
 	struct alc_spec *spec = codec->spec;
 	alc_hp_automute(codec);
 	snd_hda_codec_write_cache(codec, 1, 0, AC_VERB_SET_GPIO_DATA,
-				  spec->jack_present ? 1 : 3);
+				  spec->hp_jack_present ? 1 : 3);
 }
 
 static void alc882_targa_setup(struct hda_codec *codec)
@@ -1782,8 +1772,7 @@ static void alc882_targa_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x1b;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc882_targa_unsol_event(struct hda_codec *codec, unsigned int res)
@@ -2187,8 +2176,7 @@ static void alc883_medion_wim2160_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1a;
 	spec->autocfg.speaker_pins[0] = 0x15;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static const struct snd_kcontrol_new alc883_acer_aspire_mixer[] = {
@@ -2341,8 +2329,7 @@ static void alc883_mitac_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x17;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static const struct hda_verb alc883_mitac_verbs[] = {
@@ -2507,8 +2494,7 @@ static void alc888_3st_hp_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x16;
 	spec->autocfg.speaker_pins[2] = 0x18;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static const struct hda_verb alc888_3st_hp_verbs[] = {
@@ -2568,8 +2554,7 @@ static void alc888_lenovo_ms7195_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.line_out_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 /* toggle speaker-output according to the hp-jack state */
@@ -2579,8 +2564,7 @@ static void alc883_lenovo_nb0763_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 /* toggle speaker-output according to the hp-jack state */
@@ -2593,8 +2577,7 @@ static void alc883_clevo_m720_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc883_clevo_m720_init_hook(struct hda_codec *codec)
@@ -2623,8 +2606,7 @@ static void alc883_2ch_fujitsu_pi2515_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc883_haier_w66_setup(struct hda_codec *codec)
@@ -2633,8 +2615,7 @@ static void alc883_haier_w66_setup(struct hda_codec *codec)
 
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.speaker_pins[0] = 0x14;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc883_lenovo_101e_setup(struct hda_codec *codec)
@@ -2644,10 +2625,7 @@ static void alc883_lenovo_101e_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x1b;
 	spec->autocfg.line_out_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
-	spec->automute = 1;
-	spec->detect_line = 1;
-	spec->automute_lines = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 /* toggle speaker-output according to the hp-jack state */
@@ -2658,8 +2636,7 @@ static void alc883_acer_aspire_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[1] = 0x16;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static const struct hda_verb alc883_acer_eapd_verbs[] = {
@@ -2689,8 +2666,7 @@ static void alc888_6st_dell_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[1] = 0x15;
 	spec->autocfg.speaker_pins[2] = 0x16;
 	spec->autocfg.speaker_pins[3] = 0x17;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc888_lenovo_sky_setup(struct hda_codec *codec)
@@ -2703,8 +2679,7 @@ static void alc888_lenovo_sky_setup(struct hda_codec *codec)
 	spec->autocfg.speaker_pins[2] = 0x16;
 	spec->autocfg.speaker_pins[3] = 0x17;
 	spec->autocfg.speaker_pins[4] = 0x1a;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static void alc883_vaiott_setup(struct hda_codec *codec)
@@ -2714,8 +2689,7 @@ static void alc883_vaiott_setup(struct hda_codec *codec)
 	spec->autocfg.hp_pins[0] = 0x15;
 	spec->autocfg.speaker_pins[0] = 0x14;
 	spec->autocfg.speaker_pins[1] = 0x17;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static const struct hda_verb alc888_asus_m90v_verbs[] = {
@@ -2739,8 +2713,7 @@ static void alc883_mode2_setup(struct hda_codec *codec)
 	spec->ext_mic_pin = 0x18;
 	spec->int_mic_pin = 0x19;
 	spec->auto_mic = 1;
-	spec->automute = 1;
-	spec->automute_mode = ALC_AUTOMUTE_AMP;
+	alc_simple_setup_automute(spec, ALC_AUTOMUTE_AMP);
 }
 
 static const struct hda_verb alc888_asus_eee1601_verbs[] = {
diff --git a/sound/pci/hda/alc_quirks.c b/sound/pci/hda/alc_quirks.c
index 2be1129..a18952e 100644
--- a/sound/pci/hda/alc_quirks.c
+++ b/sound/pci/hda/alc_quirks.c
@@ -453,6 +453,19 @@ static void setup_preset(struct hda_codec *codec,
 	alc_fixup_autocfg_pin_nums(codec);
 }
 
+static void alc_simple_setup_automute(struct alc_spec *spec, int mode)
+{
+	int lo_pin = spec->autocfg.line_out_pins[0];
+
+	if (lo_pin == spec->autocfg.speaker_pins[0] ||
+		lo_pin == spec->autocfg.hp_pins[0])
+		lo_pin = 0;
+	spec->automute_mode = mode;
+	spec->detect_hp = !!spec->autocfg.hp_pins[0];
+	spec->detect_lo = !!lo_pin;
+	spec->automute_lo = spec->automute_lo_possible = !!lo_pin;
+	spec->automute_speaker = spec->automute_speaker_possible = !!spec->autocfg.speaker_pins[0];
+}
 
 /* auto-toggle front mic */
 static void alc88x_simple_mic_automute(struct hda_codec *codec)
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1b3c89c..de9a26b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -162,15 +162,17 @@ struct alc_spec {
 	void (*automute_hook)(struct hda_codec *codec);
 
 	/* for pin sensing */
-	unsigned int jack_present: 1;
+	unsigned int hp_jack_present:1;
 	unsigned int line_jack_present:1;
 	unsigned int master_mute:1;
 	unsigned int auto_mic:1;
 	unsigned int auto_mic_valid_imux:1;	/* valid imux for auto-mic */
-	unsigned int automute:1;	/* HP automute enabled */
-	unsigned int detect_line:1;	/* Line-out detection enabled */
-	unsigned int automute_lines:1;	/* automute line-out as well; NOP when automute_hp_lo isn't set */
-	unsigned int automute_hp_lo:1;	/* both HP and LO available */
+	unsigned int automute_speaker:1; /* automute speaker outputs */
+	unsigned int automute_lo:1; /* automute LO outputs */
+	unsigned int detect_hp:1;	/* Headphone detection enabled */
+	unsigned int detect_lo:1;	/* Line-out detection enabled */
+	unsigned int automute_speaker_possible:1; /* there are speakers and either LO or HP */
+	unsigned int automute_lo_possible:1;	  /* there are line outs and HP */
 
 	/* other flags */
 	unsigned int no_analog :1; /* digital I/O only */
@@ -530,8 +532,8 @@ static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
 	}
 }
 
-/* Toggle internal speakers muting */
-static void update_speakers(struct hda_codec *codec)
+/* Toggle outputs muting */
+static void update_outputs(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	int on;
@@ -543,10 +545,10 @@ static void update_speakers(struct hda_codec *codec)
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
 		    spec->autocfg.hp_pins, spec->master_mute, true);
 
-	if (!spec->automute)
+	if (!spec->automute_speaker)
 		on = 0;
 	else
-		on = spec->jack_present | spec->line_jack_present;
+		on = spec->hp_jack_present | spec->line_jack_present;
 	on |= spec->master_mute;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.speaker_pins),
 		    spec->autocfg.speaker_pins, on, false);
@@ -556,22 +558,22 @@ static void update_speakers(struct hda_codec *codec)
 	if (spec->autocfg.line_out_pins[0] == spec->autocfg.hp_pins[0] ||
 	    spec->autocfg.line_out_pins[0] == spec->autocfg.speaker_pins[0])
 		return;
-	if (!spec->automute || (spec->automute_hp_lo && !spec->automute_lines))
+	if (!spec->automute_lo)
 		on = 0;
 	else
-		on = spec->jack_present;
+		on = spec->hp_jack_present;
 	on |= spec->master_mute;
 	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
 		    spec->autocfg.line_out_pins, on, false);
 }
 
-static void call_update_speakers(struct hda_codec *codec)
+static void call_update_outputs(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	if (spec->automute_hook)
 		spec->automute_hook(codec);
 	else
-		update_speakers(codec);
+		update_outputs(codec);
 }
 
 /* standard HP-automute helper */
@@ -579,12 +581,12 @@ static void alc_hp_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 
-	spec->jack_present =
+	spec->hp_jack_present =
 		detect_jacks(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
 			     spec->autocfg.hp_pins);
-	if (!spec->automute)
+	if (!spec->detect_hp || (!spec->automute_speaker && !spec->automute_lo))
 		return;
-	call_update_speakers(codec);
+	call_update_outputs(codec);
 }
 
 /* standard line-out-automute helper */
@@ -595,9 +597,9 @@ static void alc_line_automute(struct hda_codec *codec)
 	spec->line_jack_present =
 		detect_jacks(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
 			     spec->autocfg.line_out_pins);
-	if (!spec->automute || !spec->detect_line)
+	if (!spec->automute_speaker || !spec->detect_lo)
 		return;
-	call_update_speakers(codec);
+	call_update_outputs(codec);
 }
 
 #define get_connection_index(codec, mux, nid) \
@@ -795,7 +797,7 @@ static int alc_automute_mode_info(struct snd_kcontrol *kcontrol,
 
 	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
 	uinfo->count = 1;
-	if (spec->automute_hp_lo) {
+	if (spec->automute_speaker_possible && spec->automute_lo_possible) {
 		uinfo->value.enumerated.items = 3;
 		texts = texts3;
 	} else {
@@ -814,13 +816,12 @@ static int alc_automute_mode_get(struct snd_kcontrol *kcontrol,
 {
 	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
 	struct alc_spec *spec = codec->spec;
-	unsigned int val;
-	if (!spec->automute)
-		val = 0;
-	else if (!spec->automute_hp_lo || !spec->automute_lines)
-		val = 1;
-	else
-		val = 2;
+	unsigned int val = 0;
+	if (spec->automute_speaker)
+		val++;
+	if (spec->automute_lo)
+		val++;
+
 	ucontrol->value.enumerated.item[0] = val;
 	return 0;
 }
@@ -833,29 +834,36 @@ static int alc_automute_mode_put(struct snd_kcontrol *kcontrol,
 
 	switch (ucontrol->value.enumerated.item[0]) {
 	case 0:
-		if (!spec->automute)
+		if (!spec->automute_speaker && !spec->automute_lo)
 			return 0;
-		spec->automute = 0;
+		spec->automute_speaker = 0;
+		spec->automute_lo = 0;
 		break;
 	case 1:
-		if (spec->automute &&
-		    (!spec->automute_hp_lo || !spec->automute_lines))
-			return 0;
-		spec->automute = 1;
-		spec->automute_lines = 0;
+		if (spec->automute_speaker_possible) {
+			if (!spec->automute_lo && spec->automute_speaker)
+				return 0;
+			spec->automute_speaker = 1;
+			spec->automute_lo = 0;
+		} else if (spec->automute_lo_possible) {
+			if (spec->automute_lo)
+				return 0;
+			spec->automute_lo = 1;
+		} else
+			return -EINVAL;
 		break;
 	case 2:
-		if (!spec->automute_hp_lo)
+		if (!spec->automute_lo_possible || !spec->automute_speaker_possible)
 			return -EINVAL;
-		if (spec->automute && spec->automute_lines)
+		if (spec->automute_speaker && spec->automute_lo)
 			return 0;
-		spec->automute = 1;
-		spec->automute_lines = 1;
+		spec->automute_speaker = 1;
+		spec->automute_lo = 1;
 		break;
 	default:
 		return -EINVAL;
 	}
-	call_update_speakers(codec);
+	call_update_outputs(codec);
 	return 1;
 }
 
@@ -892,7 +900,7 @@ static int alc_add_automute_mode_enum(struct hda_codec *codec)
  * Check the availability of HP/line-out auto-mute;
  * Set up appropriately if really supported
  */
-static void alc_init_auto_hp(struct hda_codec *codec)
+static void alc_init_automute(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
 	struct auto_pin_cfg *cfg = &spec->autocfg;
@@ -907,8 +915,6 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		present++;
 	if (present < 2) /* need two different output types */
 		return;
-	if (present == 3)
-		spec->automute_hp_lo = 1; /* both HP and LO automute */
 
 	if (!cfg->speaker_pins[0] &&
 	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
@@ -924,6 +930,8 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		cfg->hp_outs = cfg->line_outs;
 	}
 
+	spec->automute_mode = ALC_AUTOMUTE_PIN;
+
 	for (i = 0; i < cfg->hp_outs; i++) {
 		hda_nid_t nid = cfg->hp_pins[i];
 		if (!is_jack_detectable(codec, nid))
@@ -933,28 +941,32 @@ static void alc_init_auto_hp(struct hda_codec *codec)
 		snd_hda_codec_write_cache(codec, nid, 0,
 				  AC_VERB_SET_UNSOLICITED_ENABLE,
 				  AC_USRSP_EN | ALC_HP_EVENT);
-		spec->automute = 1;
-		spec->automute_mode = ALC_AUTOMUTE_PIN;
-	}
-	if (spec->automute && cfg->line_out_pins[0] &&
-	    cfg->speaker_pins[0] &&
-	    cfg->line_out_pins[0] != cfg->hp_pins[0] &&
-	    cfg->line_out_pins[0] != cfg->speaker_pins[0]) {
-		for (i = 0; i < cfg->line_outs; i++) {
-			hda_nid_t nid = cfg->line_out_pins[i];
-			if (!is_jack_detectable(codec, nid))
-				continue;
-			snd_printdd("realtek: Enable Line-Out auto-muting "
-				    "on NID 0x%x\n", nid);
-			snd_hda_codec_write_cache(codec, nid, 0,
-					AC_VERB_SET_UNSOLICITED_ENABLE,
-					AC_USRSP_EN | ALC_FRONT_EVENT);
-			spec->detect_line = 1;
+		spec->detect_hp = 1;
+	}
+
+	if (cfg->line_out_type == AUTO_PIN_LINE_OUT && cfg->line_outs) {
+		if (cfg->speaker_outs)
+			for (i = 0; i < cfg->line_outs; i++) {
+				hda_nid_t nid = cfg->line_out_pins[i];
+				if (!is_jack_detectable(codec, nid))
+					continue;
+				snd_printdd("realtek: Enable Line-Out "
+					    "auto-muting on NID 0x%x\n", nid);
+				snd_hda_codec_write_cache(codec, nid, 0,
+						AC_VERB_SET_UNSOLICITED_ENABLE,
+						AC_USRSP_EN | ALC_FRONT_EVENT);
+				spec->detect_lo = 1;
 		}
-		spec->automute_lines = spec->detect_line;
+		spec->automute_lo_possible = spec->detect_hp;
 	}
 
-	if (spec->automute) {
+	spec->automute_speaker_possible = cfg->speaker_outs &&
+		(spec->detect_hp || spec->detect_lo);
+
+	spec->automute_lo = spec->automute_lo_possible;
+	spec->automute_speaker = spec->automute_speaker_possible;
+
+	if (spec->automute_speaker_possible || spec->automute_lo_possible) {
 		/* create a control for automute mode */
 		alc_add_automute_mode_enum(codec);
 		spec->unsol_event = alc_sku_unsol_event;
@@ -1155,7 +1167,7 @@ static void alc_init_auto_mic(struct hda_codec *codec)
 /* check the availabilities of auto-mute and auto-mic switches */
 static void alc_auto_check_switches(struct hda_codec *codec)
 {
-	alc_init_auto_hp(codec);
+	alc_init_automute(codec);
 	alc_init_auto_mic(codec);
 }
 
@@ -4641,7 +4653,7 @@ static void alc269_fixup_stereo_dmic(struct hda_codec *codec,
 
 static void alc269_quanta_automute(struct hda_codec *codec)
 {
-	update_speakers(codec);
+	update_outputs(codec);
 
 	snd_hda_codec_write(codec, 0x20, 0,
 			AC_VERB_SET_COEF_INDEX, 0x0c);
-- 
1.7.5.4


--------------040802070305030607060106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040802070305030607060106--
