From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: When select 2.1 profile in pulseaudio,
 how do pulseaudio select notebook 's internal subwoofer or 5.1
 external speaker ?
Date: Sun, 12 Jul 2015 10:16:05 +0800
Message-ID: <CAN8ccia43iJJOkB9w=XOxHBNtaO52ExJ4brKZCFGT=sxcik0VA@mail.gmail.com>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1685415520=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, pulseaudio-discuss@lists.freedesktop.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

--===============1685415520==
Content-Type: multipart/alternative; boundary=047d7b2e41bef5b257051aa42f75

--047d7b2e41bef5b257051aa42f75
Content-Type: text/plain; charset=UTF-8

> >
> > Are you sure that it is alsa driver bug since pulseaudio seem not using
> > line out jack to mute internal speakers ?
>
> No, I'm not. I set all my jacks to line out and it works now.
>

Do pulseaudio 2.1 profile select the internal subwoofer or your 5.1
external speaker ?

diff --git a/sound/pci/hda/hda_auto_parser.c
b/sound/pci/hda/hda_auto_parser.c
index 03b7399..c9e45e7 100644
@@ -952,6 +960,7 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
     const struct snd_pci_quirk *q;
     int id = HDA_FIXUP_ID_NOT_SET;
     const char *name = NULL;
+    int i;

     if (codec->fixup_id != HDA_FIXUP_ID_NOT_SET)
         return;
@@ -966,6 +975,9 @@ void snd_hda_pick_fixup(struct hda_codec *codec,
         return;
     }

+    if (!snd_hda_get_int_hint(codec, "alt_config", &i))
+        codec->alt_config = i;
+
     if (codec->modelname && models) {
         while (models->name) {
             if (!strcmp(codec->modelname, models->name)) {
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 12837ab..38841db 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -283,6 +283,8 @@ struct hda_codec {

     /* additional init verbs */
     struct snd_array verbs;
+    int alt_config;
+    int combo_jack;
 };

 #define dev_to_hda_codec(_dev)    container_of(_dev, struct hda_codec,
core.dev)
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index ac0db16..12ee7f7 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -39,7 +39,6 @@
 #include "hda_beep.h"
 #include "hda_generic.h"

-
 /**
  * snd_hda_gen_spec_init - initialize hda_gen_spec struct
  * @spec: hda_gen_spec object to initialize
@@ -180,10 +179,10 @@ static void parse_user_hints(struct hda_codec *codec)
     /* the following two are just for compatibility */
     val = snd_hda_get_bool_hint(codec, "add_out_jack_modes");
     if (val >= 0)
-        spec->add_jack_modes = !!val;
+        spec->add_out_jack_modes = !!val;
     val = snd_hda_get_bool_hint(codec, "add_in_jack_modes");
     if (val >= 0)
-        spec->add_jack_modes = !!val;
+        spec->add_in_jack_modes = !!val;
     val = snd_hda_get_bool_hint(codec, "add_jack_modes");
     if (val >= 0)
         spec->add_jack_modes = !!val;
@@ -2648,7 +2720,7 @@ static void get_jack_mode_name(struct hda_codec
*codec, hda_nid_t pin,
 static int get_out_jack_num_items(struct hda_codec *codec, hda_nid_t pin)
 {
     struct hda_gen_spec *spec = codec->spec;
-    if (spec->add_jack_modes) {
+    if (spec->add_jack_modes || spec->add_out_jack_modes) {
         unsigned int pincap = snd_hda_query_pin_caps(codec, pin);
         if ((pincap & AC_PINCAP_OUT) && (pincap & AC_PINCAP_HP_DRV))
             return 2;
@@ -2791,7 +2863,7 @@ static int get_in_jack_num_items(struct hda_codec
*codec, hda_nid_t pin)
 {
     struct hda_gen_spec *spec = codec->spec;
     int nitems = 0;
-    if (spec->add_jack_modes)
+    if (spec->add_jack_modes || spec->add_in_jack_modes)
         nitems = hweight32(get_vref_caps(codec, pin));
     return nitems ? nitems : 1;
 }
@@ -3287,7 +3359,7 @@ static int create_input_ctls(struct hda_codec *codec)
         if (err < 0)
             return err;

-        if (spec->add_jack_modes) {
+        if (spec->add_jack_modes || spec->add_in_jack_modes) {
             err = create_in_jack_mode(codec, pin);
             if (err < 0)
                 return err;
@@ -4895,13 +4971,13 @@ int snd_hda_gen_parse_auto_config(struct hda_codec
*codec,
      */
     if (spec->hp_mic_pin &&
         (spec->auto_mic || spec->input_mux.num_items == 1 ||
-         spec->add_jack_modes)) {
+         spec->add_jack_modes || spec->add_in_jack_modes)) {
         err = create_hp_mic_jack_mode(codec, spec->hp_mic_pin);
         if (err < 0)
             return err;
     }

-    if (spec->add_jack_modes) {
+    if (spec->add_jack_modes || spec->add_out_jack_modes) {
         if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
             err = create_out_jack_modes(codec, cfg->line_outs,
                             cfg->line_out_pins);
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 56e4139..f10c55b 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -227,6 +229,8 @@ struct hda_gen_spec {
     unsigned int prefer_hp_amp:1; /* enable HP amp for speaker if any */
     unsigned int add_stereo_mix_input:2; /* add aamix as a capture src */
     unsigned int add_jack_modes:1; /* add i/o jack mode enum ctls */
+    unsigned int add_in_jack_modes:1; /* add in jack mode enum ctls */
+    unsigned int add_out_jack_modes:1; /* add out jack mode enum ctls */
     unsigned int power_down_unused:1; /* power down unused widgets */
     unsigned int dac_min_mute:1; /* minimal = mute for DACs */

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8e02cdf..b13f588 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1914,6 +1914,62 @@ static void alc889_fixup_mba21_vref(struct hda_codec
*codec,
         alc889_fixup_mac_pins(codec, nids, ARRAY_SIZE(nids));
 }

+static const struct snd_pcm_chmap_elem acer_pcm_chmaps[] = {
+    { .channels = 2,
+      .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
+    { .channels = 4,
+      .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+           SNDRV_CHMAP_LFE, SNDRV_CHMAP_NA } }, /* LFE only on left */
+    { .channels = 4,
+      .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+           SNDRV_CHMAP_RL, SNDRV_CHMAP_RR } },
+    { .channels = 6,
+      .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,
+           SNDRV_CHMAP_RL, SNDRV_CHMAP_RR,
+           SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE } },
+    { }
+};
+
+static void alc888_fixup_acer_aspire_4930g(struct hda_codec *codec,
+                    const struct hda_fixup *fix, int action)
+{
+    static const struct hda_pintbl subwoofer_cfg[] = {
+        { 0x16, 0x90170111 }, /* internal subwoofer */
+        {}
+    };
+    static const struct hda_pintbl front_cfg[] = {
+        { 0x15, 0x02014010},
+        {}
+    };
+    static const struct hda_pintbl rear_cfg[] = {
+        { 0x1a, 0x02014011},
+        {}
+    };
+    static const struct hda_pintbl clfe_cfg[] = {
+        { 0x18, 0x02014012},
+        {}
+    };
+    struct alc_spec *spec = codec->spec;
+    switch(action){
+    case HDA_FIXUP_ACT_PRE_PROBE:
+        snd_hda_apply_pincfgs(codec, subwoofer_cfg);
+        spec->gen.add_out_jack_modes = true;
+        switch(codec->alt_config){
+        case 3:
+            snd_hda_apply_pincfgs(codec, clfe_cfg);
+        case 2:
+            snd_hda_apply_pincfgs(codec, rear_cfg);
+        case 1:
+            snd_hda_apply_pincfgs(codec, front_cfg);
+            break;
+        }
+        break;
+    case HDA_FIXUP_ACT_BUILD:
+        spec->gen.pcm_rec[0]->stream[0].chmap = acer_pcm_chmaps;
+        break;
+    }
+}
+
 /* Don't take HP output as primary
  * Strangely, the speaker output doesn't work on Vaio Z and some Vaio
  * all-in-one desktop PCs (for example VGC-LN51JGB) through DAC 0x05
@@ -2048,12 +2104,8 @@ static const struct hda_fixup alc882_fixups[] = {
         .v.func = alc889_fixup_coef,
     },
     [ALC882_FIXUP_ACER_ASPIRE_4930G] = {
-        .type = HDA_FIXUP_PINS,
-        .v.pins = (const struct hda_pintbl[]) {
-            { 0x16, 0x99130111 }, /* CLFE speaker */
-            { 0x17, 0x99130112 }, /* surround speaker */
-            { }
-        },
+        .type = HDA_FIXUP_FUNC,
+        .v.func = alc888_fixup_acer_aspire_4930g,
         .chained = true,
         .chain_id = ALC882_FIXUP_GPIO1,
     },

--047d7b2e41bef5b257051aa42f75
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div><div>
&gt;<br>
&gt; Are you sure that it is alsa driver bug since pulseaudio seem not usin=
g<br>
&gt; line out jack to mute internal speakers ?<br>
<br>
</div></div>No, I&#39;m not. I set all my jacks to line out and it works no=
w.<br></blockquote><div><br></div></div>Do pulseaudio 2.1 profile select th=
e internal subwoofer or your 5.1 external speaker ?<br><br>diff --git a/sou=
nd/pci/hda/hda_auto_parser.c b/sound/pci/hda/hda_auto_parser.c<br>index 03b=
7399..c9e45e7 100644<br>@@ -952,6 +960,7 @@ void snd_hda_pick_fixup(struct =
hda_codec *codec,<br>=C2=A0=C2=A0=C2=A0=C2=A0 const struct snd_pci_quirk *q=
;<br>=C2=A0=C2=A0=C2=A0=C2=A0 int id =3D HDA_FIXUP_ID_NOT_SET;<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 const char *name =3D NULL;<br>+=C2=A0=C2=A0=C2=A0 int i;<br=
>=C2=A0<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (codec-&gt;fixup_id !=3D HDA_FIXUP_I=
D_NOT_SET)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return;<br>@@ -96=
6,6 +975,9 @@ void snd_hda_pick_fixup(struct hda_codec *codec,<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return;<br>=C2=A0=C2=A0=C2=A0=C2=A0 }<br=
>=C2=A0<br>+=C2=A0=C2=A0=C2=A0 if (!snd_hda_get_int_hint(codec, &quot;alt_c=
onfig&quot;, &amp;i))<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 codec-&gt;a=
lt_config =3D i;<br>+<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (codec-&gt;modelname &=
amp;&amp; models) {<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 while (m=
odels-&gt;name) {<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 if (!strcmp(codec-&gt;modelname, models-&gt;name)) {<br>diff --gi=
t a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h<br>index 12837ab.=
.38841db 100644<br>--- a/sound/pci/hda/hda_codec.h<br>+++ b/sound/pci/hda/h=
da_codec.h<br>@@ -283,6 +283,8 @@ struct hda_codec {<br>=C2=A0<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 /* additional init verbs */<br>=C2=A0=C2=A0=C2=A0=C2=A0 str=
uct snd_array verbs;<br>+=C2=A0=C2=A0=C2=A0 int alt_config;<br>+=C2=A0=C2=
=A0=C2=A0 int combo_jack;<br>=C2=A0};<br>=C2=A0<br>=C2=A0#define dev_to_hda=
_codec(_dev)=C2=A0=C2=A0=C2=A0 container_of(_dev, struct hda_codec, core.de=
v)<br>diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.=
c<br>index ac0db16..12ee7f7 100644<br>--- a/sound/pci/hda/hda_generic.c<br>=
+++ b/sound/pci/hda/hda_generic.c<br>@@ -39,7 +39,6 @@<br>=C2=A0#include &q=
uot;hda_beep.h&quot;<br>=C2=A0#include &quot;hda_generic.h&quot;<br>=C2=A0<=
br>-<br>=C2=A0/**<br>=C2=A0 * snd_hda_gen_spec_init - initialize hda_gen_sp=
ec struct<br>=C2=A0 * @spec: hda_gen_spec object to initialize<br>@@ -180,1=
0 +179,10 @@ static void parse_user_hints(struct hda_codec *codec)<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 /* the following two are just for compatibility */<br=
>=C2=A0=C2=A0=C2=A0=C2=A0 val =3D snd_hda_get_bool_hint(codec, &quot;add_ou=
t_jack_modes&quot;);<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (val &gt;=3D 0)<br>-=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;add_jack_modes =3D !!val;<br>+=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;add_out_jack_modes =3D !!val=
;<br>=C2=A0=C2=A0=C2=A0=C2=A0 val =3D snd_hda_get_bool_hint(codec, &quot;ad=
d_in_jack_modes&quot;);<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (val &gt;=3D 0)<br>-=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;add_jack_modes =3D !!val;<br=
>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;add_in_jack_modes =3D !!va=
l;<br>=C2=A0=C2=A0=C2=A0=C2=A0 val =3D snd_hda_get_bool_hint(codec, &quot;a=
dd_jack_modes&quot;);<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (val &gt;=3D 0)<br>=C2=
=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;add_jack_modes =3D !!val;=
<br>@@ -2648,7 +2720,7 @@ static void get_jack_mode_name(struct hda_codec *=
codec, hda_nid_t pin,<br>=C2=A0static int get_out_jack_num_items(struct hda=
_codec *codec, hda_nid_t pin)<br>=C2=A0{<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct=
 hda_gen_spec *spec =3D codec-&gt;spec;<br>-=C2=A0=C2=A0=C2=A0 if (spec-&gt=
;add_jack_modes) {<br>+=C2=A0=C2=A0=C2=A0 if (spec-&gt;add_jack_modes || sp=
ec-&gt;add_out_jack_modes) {<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 unsigned int pincap =3D snd_hda_query_pin_caps(codec, pin);<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if ((pincap &amp; AC_PINCAP_OUT) &amp;&a=
mp; (pincap &amp; AC_PINCAP_HP_DRV))<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 2;<br>@@ -2791,7 +2863,7 @@ static int =
get_in_jack_num_items(struct hda_codec *codec, hda_nid_t pin)<br>=C2=A0{<br=
>=C2=A0=C2=A0=C2=A0=C2=A0 struct hda_gen_spec *spec =3D codec-&gt;spec;<br>=
=C2=A0=C2=A0=C2=A0=C2=A0 int nitems =3D 0;<br>-=C2=A0=C2=A0=C2=A0 if (spec-=
&gt;add_jack_modes)<br>+=C2=A0=C2=A0=C2=A0 if (spec-&gt;add_jack_modes || s=
pec-&gt;add_in_jack_modes)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 n=
items =3D hweight32(get_vref_caps(codec, pin));<br>=C2=A0=C2=A0=C2=A0=C2=A0=
 return nitems ? nitems : 1;<br>=C2=A0}<br>@@ -3287,7 +3359,7 @@ static int=
 create_input_ctls(struct hda_codec *codec)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 if (err &lt; 0)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 return err;<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 if (spec-&gt;add_jack_modes) {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 if (spec-&gt;add_jack_modes || spec-&gt;add_in_jack_modes) {<b=
r>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 err =3D cr=
eate_in_jack_mode(codec, pin);<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 if (err &lt; 0)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return err;<br>@@ -4895,=
13 +4971,13 @@ int snd_hda_gen_parse_auto_config(struct hda_codec *codec,<b=
r>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0*/<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (spec-&g=
t;hp_mic_pin &amp;&amp;<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (spe=
c-&gt;auto_mic || spec-&gt;input_mux.num_items =3D=3D 1 ||<br>-=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 spec-&gt;add_jack_modes)) {<br>+=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 spec-&gt;add_jack_modes || spec-&gt;add_=
in_jack_modes)) {<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 err =3D cr=
eate_hp_mic_jack_mode(codec, spec-&gt;hp_mic_pin);<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 if (err &lt; 0)<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return err;<br>=C2=A0=C2=A0=C2=A0=C2=A0 }<b=
r>=C2=A0<br>-=C2=A0=C2=A0=C2=A0 if (spec-&gt;add_jack_modes) {<br>+=C2=A0=
=C2=A0=C2=A0 if (spec-&gt;add_jack_modes || spec-&gt;add_out_jack_modes) {<=
br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (cfg-&gt;line_out_type !=
=3D AUTO_PIN_SPEAKER_OUT) {<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 err =3D create_out_jack_modes(codec, cfg-&gt;line_outs,<=
br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cfg-&gt;=
line_out_pins);<br>diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda=
/hda_generic.h<br>index 56e4139..f10c55b 100644<br>--- a/sound/pci/hda/hda_=
generic.h<br>+++ b/sound/pci/hda/hda_generic.h<br>@@ -227,6 +229,8 @@ struc=
t hda_gen_spec {<br>=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int prefer_hp_amp:1; =
/* enable HP amp for speaker if any */<br>=C2=A0=C2=A0=C2=A0=C2=A0 unsigned=
 int add_stereo_mix_input:2; /* add aamix as a capture src */<br>=C2=A0=C2=
=A0=C2=A0=C2=A0 unsigned int add_jack_modes:1; /* add i/o jack mode enum ct=
ls */<br>+=C2=A0=C2=A0=C2=A0 unsigned int add_in_jack_modes:1; /* add in ja=
ck mode enum ctls */<br>+=C2=A0=C2=A0=C2=A0 unsigned int add_out_jack_modes=
:1; /* add out jack mode enum ctls */<br>=C2=A0=C2=A0=C2=A0=C2=A0 unsigned =
int power_down_unused:1; /* power down unused widgets */<br>=C2=A0=C2=A0=C2=
=A0=C2=A0 unsigned int dac_min_mute:1; /* minimal =3D mute for DACs */<br>=
=C2=A0<br>diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_=
realtek.c<br>index 8e02cdf..b13f588 100644<br>--- a/sound/pci/hda/patch_rea=
ltek.c<br>+++ b/sound/pci/hda/patch_realtek.c<br>@@ -1914,6 +1914,62 @@ sta=
tic void alc889_fixup_mba21_vref(struct hda_codec *codec,<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 alc889_fixup_mac_pins(codec, nids, ARRAY_SI=
ZE(nids));<br>=C2=A0}<br>=C2=A0<br>+static const struct snd_pcm_chmap_elem =
acer_pcm_chmaps[] =3D {<br>+=C2=A0=C2=A0=C2=A0 { .channels =3D 2,<br>+=C2=
=A0=C2=A0=C2=A0 =C2=A0 .map =3D { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },<br>+=
=C2=A0=C2=A0=C2=A0 { .channels =3D 4,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0 .map =
=3D { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0 SNDRV_CHMAP_LFE, SNDRV_CHMAP_NA } }, /* LFE only on lef=
t */<br>+=C2=A0=C2=A0=C2=A0 { .channels =3D 4,<br>+=C2=A0=C2=A0=C2=A0 =C2=
=A0 .map =3D { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,<br>+=C2=A0=C2=A0=C2=A0 =C2=
=A0=C2=A0=C2=A0 =C2=A0=C2=A0 SNDRV_CHMAP_RL, SNDRV_CHMAP_RR } }, <br>+=C2=
=A0=C2=A0=C2=A0 { .channels =3D 6,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0 .map =3D {=
 SNDRV_CHMAP_FL, SNDRV_CHMAP_FR,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0 SNDRV_CHMAP_RL, SNDRV_CHMAP_RR,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0 SNDRV_CHMAP_FC, SNDRV_CHMAP_LFE } },<br>+=C2=A0=
=C2=A0=C2=A0 { }<br>+};<br>+<br>+static void alc888_fixup_acer_aspire_4930g=
(struct hda_codec *codec,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 const struct hda_fixup *=
fix, int action)<br>+{<br>+=C2=A0=C2=A0=C2=A0 static const struct hda_pintb=
l subwoofer_cfg[] =3D {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 { 0x16, 0=
x90170111 }, /* internal subwoofer */=C2=A0=C2=A0=C2=A0 <br>+=C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 {}<br>+=C2=A0=C2=A0=C2=A0 };<br>+=C2=A0=C2=A0=C2=
=A0 static const struct hda_pintbl front_cfg[] =3D {<br>+=C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 { 0x15, 0x02014010},<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 {}<br>+=C2=A0=C2=A0=C2=A0 };<br>+=C2=A0=C2=A0=C2=A0 static const =
struct hda_pintbl rear_cfg[] =3D {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 { 0x1a, 0x02014011},<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 {}<br>+=
=C2=A0=C2=A0=C2=A0 };<br>+=C2=A0=C2=A0=C2=A0 static const struct hda_pintbl=
 clfe_cfg[] =3D {<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 { 0x18, 0x02014=
012},<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 {}<br>+=C2=A0=C2=A0=C2=A0 }=
;<br>+=C2=A0=C2=A0=C2=A0 struct alc_spec *spec =3D codec-&gt;spec;<br>+=C2=
=A0=C2=A0=C2=A0 switch(action){<br>+=C2=A0=C2=A0=C2=A0 case HDA_FIXUP_ACT_P=
RE_PROBE:<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 snd_hda_apply_pincfgs(c=
odec, subwoofer_cfg);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;ge=
n.add_out_jack_modes =3D true;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 sw=
itch(codec-&gt;alt_config){<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 case =
3:<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 snd_hda_app=
ly_pincfgs(codec, clfe_cfg);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 case=
 2:<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 snd_hda_ap=
ply_pincfgs(codec, rear_cfg);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 cas=
e 1:<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 snd_hda_a=
pply_pincfgs(codec, front_cfg);<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 break;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }<br>+=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;<br>+=C2=A0=C2=A0=C2=A0 case HD=
A_FIXUP_ACT_BUILD:<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;gen.p=
cm_rec[0]-&gt;stream[0].chmap =3D acer_pcm_chmaps;<br>+=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 break;<br>+=C2=A0=C2=A0=C2=A0 }<br>+}<br>+<br>=C2=A0/* D=
on&#39;t take HP output as primary<br>=C2=A0 * Strangely, the speaker outpu=
t doesn&#39;t work on Vaio Z and some Vaio<br>=C2=A0 * all-in-one desktop P=
Cs (for example VGC-LN51JGB) through DAC 0x05<br>@@ -2048,12 +2104,8 @@ sta=
tic const struct hda_fixup alc882_fixups[] =3D {<br>=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 .v.func =3D alc889_fixup_coef,<br>=C2=A0=C2=A0=C2=A0=
=C2=A0 },<br>=C2=A0=C2=A0=C2=A0=C2=A0 [ALC882_FIXUP_ACER_ASPIRE_4930G] =3D =
{<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =3D HDA_FIXUP_PINS,<br>-=
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .v.pins =3D (const struct hda_pintbl[=
]) {<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 { 0x16, 0=
x99130111 }, /* CLFE speaker */<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 { 0x17, 0x99130112 }, /* surround speaker */<br>-=C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 { }<br>-=C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 },<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .type =
=3D HDA_FIXUP_FUNC,<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .v.func =3D a=
lc888_fixup_acer_aspire_4930g,<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 .chained =3D true,<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 .chai=
n_id =3D ALC882_FIXUP_GPIO1,<br>=C2=A0=C2=A0=C2=A0=C2=A0 },<br><br></div></=
div>

--047d7b2e41bef5b257051aa42f75--

--===============1685415520==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============1685415520==--
