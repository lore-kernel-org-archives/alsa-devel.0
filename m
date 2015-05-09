From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [alsa-devel] Front speakers doesn't work
 in multichannel output, regression in ALC888
Date: Sat, 9 May 2015 14:00:49 +0800
Message-ID: <CAN8cciYwq8N6SHReQdre=G16E2gFbRdkuHNEAj0fb29e4M9xKQ@mail.gmail.com>
References: <2927807.UsnFnTlWVL@luklap.workgroup>
 <29807127.PULdKhJLmi@luklap.workgroup>
 <CAN8cciapcbygVjS20+Ln6aDJbd3poieo6-8Zq3x69brsqr+Raw@mail.gmail.com>
 <4324603.tPLEjaP5mH@luklap.workgroup>
Reply-To: General PulseAudio Discussion
 <pulseaudio-discuss@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0602430079=="
Return-path: <pulseaudio-discuss-bounces@lists.freedesktop.org>
In-Reply-To: <4324603.tPLEjaP5mH@luklap.workgroup>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@lists.freedesktop.org>
List-Help: <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss>,
 <mailto:pulseaudio-discuss-request@lists.freedesktop.org?subject=subscribe>
Errors-To: pulseaudio-discuss-bounces@lists.freedesktop.org
Sender: "pulseaudio-discuss" <pulseaudio-discuss-bounces@lists.freedesktop.org>
To: =?UTF-8?B?xYF1a2FzeiBXb2puacWCb3dpY3o=?= <lukasz.wojnilowicz@gmail.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

--===============0602430079==
Content-Type: multipart/alternative; boundary=001a113dcdd2d6154605159fdd22

--001a113dcdd2d6154605159fdd22
Content-Type: text/plain; charset=UTF-8

>
> >
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/mixe
> > > > r/paths/analog-output-headphones.conf
> > > >
> > > > pulseaudio mute external center/lfe controls when headphone jack is
> >
> > plugged
>
> That would be unwanted.
>

This is common to all notebook using headphone jack and two other jacks to
support surround51 or surround71 since pulseaudio mute the other retasked
mio jack when headphone jack is plugged


>
> > > I used hdajackretask to override:
> > > PIN ID: 0x15 to "Line out (front)"
>

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/patch/sound/pci/hda/patch_realtek.c?id=c3e837bbcc03e39991da5dd1f791c06cde9f7a45

When the static model were used, the jack was configured as line out
instead of headphone jack and there is no headphone playback volume

-static const struct hda_verb alc888_acer_aspire_4930g_verbs[] = {
-/* Enable unsolicited event for HP jack */
-    {0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC_HP_EVENT | AC_USRSP_EN},
-/* Connect HP out to front */
-    {0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_OUT},
-    {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_UNMUTE},
-    {0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
-    {0x15, AC_VERB_SET_EAPD_BTLENABLE, 2},

-static const struct snd_kcontrol_new alc888_acer_aspire_4930g_mixer[] = {
-    HDA_CODEC_VOLUME("Front Playback Volume", 0x0c, 0x0, HDA_OUTPUT),
-    HDA_BIND_MUTE("Front Playback Switch", 0x0c, 2, HDA_INPUT),

The jack is configured as headphone jack after the auto parser is used


> > Pulseaudio don't know node 0x15 is headphone / Line Out (External
> speaker)
> >
> > select speaker profile mute the headphone playback switch
>
> Doesn't HP mean HeadPhone? Isn't solution to my problem obvious, namely add
> Line out capability to 0x15?
>
>
Are there any side effect if you change the headphone jack to Line Out jack
as the jack no longer enable HP amp ?


use add_out_jack_modes for create Headphone/Line Out jack mode control to
change Headphone to Line Out and vice versa


diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 3d2597b..f25cd23 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -180,10 +180,10 @@ static void parse_user_hints(struct hda_codec *codec)
     /* the following two are just for compatibility */
     val = snd_hda_get_bool_hint(codec, "add_out_jack_modes");
     if (val >= 0)
-        spec->add_jack_modes = !!val;
+        spec->add_out_jack_modes = !!val;
     val = snd_hda_get_bool_hint(codec, "add_in_jack_modes");
     if (val >= 0)
        spec->add_jack_modes = !!val;
@@ -2640,7 +2642,7 @@ static void get_jack_mode_name(struct hda_codec
*codec, hda_nid_t pin,
 static int get_out_jack_num_items(struct hda_codec *codec, hda_nid_t pin)
 {
     struct hda_gen_spec *spec = codec->spec;
-    if (spec->add_jack_modes) {
+    if (spec->add_out_jack_modes || spec->add_jack_modes) {
         unsigned int pincap = snd_hda_query_pin_caps(codec, pin);
         if ((pincap & AC_PINCAP_OUT) && (pincap & AC_PINCAP_HP_DRV))
             return 2;
@@ -4892,7 +4895,7 @@ int snd_hda_gen_parse_auto_config(struct hda_codec
*codec,
             return err;
     }

-    if (spec->add_jack_modes) {
+    if (spec->add_out_jack_modes || spec->add_jack_modes) {
         if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
             err = create_out_jack_modes(codec, cfg->line_outs,
                             cfg->line_out_pins);
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
index 56e4139..8d7568b 100644
--- a/sound/pci/hda/hda_generic.h
+++ b/sound/pci/hda/hda_generic.h
@@ -227,6 +227,8 @@ struct hda_gen_spec {
     unsigned int prefer_hp_amp:1; /* enable HP amp for speaker if any */
     unsigned int add_stereo_mix_input:2; /* add aamix as a capture src */
     unsigned int add_jack_modes:1; /* add i/o jack mode enum ctls */
+    unsigned int add_out_jack_modes:1;
     unsigned int power_down_unused:1; /* power down unused widgets */
     unsigned int dac_min_mute:1; /* minimal = mute for DACs */

--001a113dcdd2d6154605159fdd22
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><div class=3D"gmail_quote">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><span>
<br>
&gt; <a href=3D"http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/=
modules/alsa/mixe" target=3D"_blank">http://cgit.freedesktop.org/pulseaudio=
/pulseaudio/tree/src/modules/alsa/mixe</a><br>
&gt; &gt; &gt; r/paths/analog-output-headphones.conf<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; pulseaudio mute external center/lfe controls when headphone =
jack is<br>
&gt;<br>
&gt; plugged<br>
<br>
</span>That would be unwanted.<br></blockquote><div><br></div><div>This is =
common to all notebook using headphone jack and two other jacks to support =
surround51 or surround71 since pulseaudio mute the other retasked mio jack =
when headphone jack is plugged<br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<span><br>
&gt; &gt; I used hdajackretask to override:<br>
&gt; &gt; PIN ID: 0x15 to &quot;Line out (front)&quot;<br></span></blockquo=
te><div>=C2=A0<span><br><a href=3D"https://git.kernel.org/cgit/linux/kernel=
/git/tiwai/sound.git/patch/sound/pci/hda/patch_realtek.c?id=3Dc3e837bbcc03e=
39991da5dd1f791c06cde9f7a45" target=3D"_blank">https://git.kernel.org/cgit/=
linux/kernel/git/tiwai/sound.git/patch/sound/pci/hda/patch_realtek.c?id=3Dc=
3e837bbcc03e39991da5dd1f791c06cde9f7a45</a><br></span><span><span><br></spa=
n>When the static model were used, the jack was configured as line out inst=
ead of headphone jack and there is no headphone playback volume<br><br>-sta=
tic const struct hda_verb alc888_acer_aspire_4930g_verbs[] =3D {<br>-/* Ena=
ble unsolicited event for HP jack */<br>-=C2=A0=C2=A0=C2=A0 {0x15, AC_VERB_=
SET_UNSOLICITED_ENABLE, ALC_HP_EVENT | AC_USRSP_EN},<br>-/* Connect HP out =
to front */<br>-=C2=A0=C2=A0=C2=A0 {0x15, AC_VERB_SET_PIN_WIDGET_CONTROL, P=
IN_OUT},<br>-=C2=A0=C2=A0=C2=A0 {0x15, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_U=
NMUTE},<br>-=C2=A0=C2=A0=C2=A0 {0x15, AC_VERB_SET_CONNECT_SEL, 0x00},<br>-=
=C2=A0=C2=A0=C2=A0 {0x15, AC_VERB_SET_EAPD_BTLENABLE, 2},<br><br>-static co=
nst struct snd_kcontrol_new alc888_acer_aspire_4930g_mixer[] =3D {<br>-=C2=
=A0=C2=A0=C2=A0 HDA_CODEC_VOLUME(&quot;Front Playback Volume&quot;, 0x0c, 0=
x0, HDA_OUTPUT),<br>-=C2=A0=C2=A0=C2=A0 HDA_BIND_MUTE(&quot;Front Playback =
Switch&quot;, 0x0c, 2, HDA_INPUT),<br><br></span></div><div><span>The jack =
is configured as headphone jack after the auto parser is used <br></span></=
div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><span>=
</span><div><div><span>
<br>
</span><span>&gt; Pulseaudio don&#39;t know node 0x15 is headphone / Line O=
ut (External speaker)<br>
&gt;<br>
&gt; select speaker profile mute the headphone playback switch<br>
<br>
</span>Doesn&#39;t HP mean HeadPhone? Isn&#39;t solution to my problem obvi=
ous, namely add<br>
Line out capability to 0x15?<br>
<br>
</div></div></blockquote></div><br></div><div class=3D"gmail_extra">Are the=
re any side effect if you change the headphone jack to Line Out jack as the=
 jack no longer enable HP amp ?<br><br></div><div class=3D"gmail_extra"><br=
></div><div class=3D"gmail_extra">use add_out_jack_modes for create Headpho=
ne/Line Out jack mode control to change Headphone to Line Out and vice vers=
a<br></div><div class=3D"gmail_extra"><br><br>diff --git a/sound/pci/hda/hd=
a_generic.c b/sound/pci/hda/hda_generic.c<br>index 3d2597b..f25cd23 100644<=
br>--- a/sound/pci/hda/hda_generic.c<br>+++ b/sound/pci/hda/hda_generic.c<b=
r>@@ -180,10 +180,10 @@ static void parse_user_hints(struct hda_codec *code=
c)<br>=C2=A0=C2=A0=C2=A0=C2=A0 /* the following two are just for compatibil=
ity */<br>=C2=A0=C2=A0=C2=A0=C2=A0 val =3D snd_hda_get_bool_hint(codec, &qu=
ot;add_out_jack_modes&quot;);<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (val &gt;=3D 0=
)<br>-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;add_jack_modes =3D !!v=
al;<br>+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;add_out_jack_modes =
=3D !!val;<br>=C2=A0=C2=A0=C2=A0=C2=A0 val =3D snd_hda_get_bool_hint(codec,=
 &quot;add_in_jack_modes&quot;);<br>=C2=A0=C2=A0=C2=A0=C2=A0 if (val &gt;=
=3D 0)<br>=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 spec-&gt;add_jack_modes =3D=
 !!val;<br>@@ -2640,7 +2642,7 @@ static void get_jack_mode_name(struct hda_=
codec *codec, hda_nid_t pin,<br>=C2=A0static int get_out_jack_num_items(str=
uct hda_codec *codec, hda_nid_t pin)<br>=C2=A0{<br>=C2=A0=C2=A0=C2=A0=C2=A0=
 struct hda_gen_spec *spec =3D codec-&gt;spec;<br>-=C2=A0=C2=A0=C2=A0 if (s=
pec-&gt;add_jack_modes) {<br>+=C2=A0=C2=A0=C2=A0 if (spec-&gt;add_out_jack_=
modes || spec-&gt;add_jack_modes) {<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=
=A0=C2=A0 unsigned int pincap =3D snd_hda_query_pin_caps(codec, pin);<br>=
=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if ((pincap &amp; AC_PINCAP_OUT=
) &amp;&amp; (pincap &amp; AC_PINCAP_HP_DRV))<br>=C2=A0=C2=A0=C2=A0=C2=A0 =
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return 2;<br>@@ -4892,7 +4895,7 @@ in=
t snd_hda_gen_parse_auto_config(struct hda_codec *codec,<br>=C2=A0=C2=A0=C2=
=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return err;<br>=C2=A0=C2=A0=
=C2=A0=C2=A0 }<br>=C2=A0<br>-=C2=A0=C2=A0=C2=A0 if (spec-&gt;add_jack_modes=
) {<br>+=C2=A0=C2=A0=C2=A0 if (spec-&gt;add_out_jack_modes || spec-&gt;add_=
jack_modes) {<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (cfg-&gt;li=
ne_out_type !=3D AUTO_PIN_SPEAKER_OUT) {<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=
=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 err =3D create_out_jack_modes(codec, cfg-&g=
t;line_outs,<br>=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 cfg-&gt;line_out_pins);<br>diff --git a/sound/pci/hda/hda_generic.h =
b/sound/pci/hda/hda_generic.h<br>index 56e4139..8d7568b 100644<br>--- a/sou=
nd/pci/hda/hda_generic.h<br>+++ b/sound/pci/hda/hda_generic.h<br>@@ -227,6 =
+227,8 @@ struct hda_gen_spec {<br>=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int pr=
efer_hp_amp:1; /* enable HP amp for speaker if any */<br>=C2=A0=C2=A0=C2=A0=
=C2=A0 unsigned int add_stereo_mix_input:2; /* add aamix as a capture src *=
/<br>=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int add_jack_modes:1; /* add i/o jac=
k mode enum ctls */<br>+=C2=A0=C2=A0=C2=A0 unsigned int add_out_jack_modes:=
1; <br>=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int power_down_unused:1; /* power =
down unused widgets */<br>=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int dac_min_mut=
e:1; /* minimal =3D mute for DACs */<br>=C2=A0<br><br></div></div>

--001a113dcdd2d6154605159fdd22--

--===============0602430079==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KcHVsc2VhdWRp
by1kaXNjdXNzIG1haWxpbmcgbGlzdApwdWxzZWF1ZGlvLWRpc2N1c3NAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9wdWxz
ZWF1ZGlvLWRpc2N1c3MK

--===============0602430079==--
