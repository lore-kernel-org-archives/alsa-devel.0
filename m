From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Wed, 8 Jun 2011 16:33:18 +0200
Message-ID: <BANLkTimJb-UMD5Nk3d+_GW-b9Cir13PjMw@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
	<BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
	<BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
	<BANLkTi=tKPpmn0D8-Bj1NYbXSkcOveO99g@mail.gmail.com>
	<BANLkTi=-dE0hvTN96yCvdNzsM59MY=csfA@mail.gmail.com>
	<BANLkTinwNT_bbvSkd5Q106c9SoEmPURzng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 4811D103948
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Jun 2011 16:33:20 +0200 (CEST)
Received: by wyg36 with SMTP id 36so437945wyg.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Jun 2011 07:33:19 -0700 (PDT)
In-Reply-To: <BANLkTinwNT_bbvSkd5Q106c9SoEmPURzng@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/6/7 Raymond Yau <superquad.vortex2@gmail.com>:
> 2011/6/2 alex dot baldacchino dot alsasub at gmail dot com
> <alex.baldacchino.alsasub@gmail.com>:
>
>>>>
>>>> Must these controls be always coupled? Is it a specification
>>>> constraint? What if via_hp_build() didn't execute
>>>>
>>>> knew =3D via_clone_control(spec, &via_hp_mixer[1]);
>>>>
>>>> when side_mute_status() returned '0' ?
>>>>
>>>
>>
>> But I was also asking for the following code:
>>
>>> static const struct snd_kcontrol_new via_hp_mixer[2] =3D {
>>> =A0 =A0 =A0 =A0{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "Independent HP",
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.info =3D via_independent_hp_info,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.get =3D via_independent_hp_get,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.put =3D via_independent_hp_put,
>>> =A0 =A0 =A0 =A0},
>>> =A0 =A0 =A0 =A0{
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iface =3D NID_MAPPING,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "Independent HP",
>>> =A0 =A0 =A0 =A0},
>>> };
>>>
>>
>> Must there be always two "Independent HP" controls in all via codecs,
>> or there could be just one? In the latter case via_hp_mixer[1] could
>> be ignored in some cases.
>>
>
> Refer to commit 3d83e577a8206f0f3822a3840e12f76477142ba2
>
> There are codec which does not support indepedent HP
>
> http://thread.gmane.org/gmane.linux.alsa.devel/68414
>
> NID_MAPPING seem used for debugging only
>
> The error "hda-codec: no NID for mapping control Independent HP:0:0"
> can be fixed by checking =A0the value returned by side_mute_channel()
>
>
> =A0 =A0 =A0 =A0knew =3D via_clone_control(spec, &via_hp_mixer[0]);
> =A0 =A0 =A0 =A0if (knew =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>
> =A0 =A0 =A0 =A0knew->subdevice =3D HDA_SUBDEV_NID_FLAG | nid;
> =A0 =A0 =A0 =A0knew->private_value =3D nid;
> +
> + =A0 =A0 if (side_mute_channel(spec) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
>
> =A0 =A0 =A0 =A0knew =3D via_clone_control(spec, &via_hp_mixer[1]);
> =A0 =A0 =A0 =A0if (knew =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> =A0 =A0 =A0 =A0knew->subdevice =3D side_mute_channel(spec);
>
>


That's something I was thinking about, but wasn't sure if it was
possible (and safe) to ignore via_hp_mixer[1]. Now I'll apply this.
(Perhaps, by adding a further hda_nid_t variable one could avoid
calling side_mute_channel twice:
at the beginning:

- hda_nid_t nid;
+ hda_nid_t nid, side_nid;

then:

+      if( ( side_nid =3D side_mute_channel(spec) ) =3D=3D 0 )
+	return 0;

=A0 =A0 =A0 =A0knew =3D via_clone_control(spec, &via_hp_mixer[1]);
=A0 =A0 =A0 =A0if (knew =3D=3D NULL)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
- =A0 =A0 =A0knew->subdevice =3D side_mute_channel(spec);
+=A0 =A0 =A0knew->subdevice =3D side_nid;

though not that much important).


>>
>>>>
>>>> The last part is interesting. If vt2020 works the same way, the
>>>> 8-channel setup should disallow the "Independent HP" function, that is
>>>> it should be automatically turned off and 0x28 should be either muted,
>>>> or used as a 'duplicate' for 0x0c (same sound of blue jack) or 0x08
>>>> (same sound as rear green jack, as in 'redirected audio' ). If I'm not
>>>> misunderstanding everything, of course.
>>>
>>> static const struct hda_pcm_stream vt1718S_pcm_analog_playback =3D {
>>> =A0 =A0 =A0 =A0.substreams =3D 2,
>>> =A0 =A0 =A0 =A0.channels_min =3D 2,
>>> =A0 =A0 =A0 =A0.channels_max =3D 10,
>>> =A0 =A0 =A0 =A0.nid =3D 0x8, /* NID to query formats and rates */
>>>
>>> This look like vt1718s support 10 channels and 10 channels allow
>>> independent HP and surround71 at the same time
>>>
>>
>> If this part of the driver is correct, you're definitely right. That
>> also means admin's answer at
>>
>> http://www.viaarena.com/forums/showthread.php?t=3D41015
>>
>> is mistaken when he says
>>
>> "Please note that the =93Independent Headphone=94 function requires two
>> channels. Therefore, only six
>> channels will be available if =93Independent Headphone=94 is being used."
>>
>> On the other hand, the picture of via's configuration panel seems to
>> give him right: in "Independent HP" mode ("Auricular independiente" in
>> the picture) the two side speakers for surround effects are grayed out
>> as to mean they're disabled, whereas in 'Redirected Ouptut"
>> ("Auricular redirigido" in the picture) those ones seem to be enabled.
>> Though, there could be a lack of support for all ten channels in the
>> motherboard implementation and/or a limitation in that particular
>> version of via's driver/mixer (if possible at all, I'm just
>> guessing...)
>>
>
> The codec vt1708s mentioned in the thread is a 8 channel codec
>


Sorry for my insistence, I had confused codec names... However, 0x0b
doesn't seem to send audio to front panel line-out (I had made a few
tests an was going to post results, more details below).


>
> if you look at vt1718S_auto_fill_dac_nids() and
> vt1718S_auto_create_hp_ctls() ,
> grey jack use 0x0b and headphone use 0x0c
>


I see, and indeed, in /proc/asound/card0/codec#0, node 0x27 (missing
gray jack) is (would be) connected to 0x0b via 0x1a. Though 0x2a seems
to be connectable only to 0x09 ("Surround Playback Volume" - currently
labeled with an asterisk in 0x2a's connection list) and 0x0c, so
adding support for retasking blue jack as side in codec vt2020/vt1718s
without a grey jack could require some more effort to handle
Independent HP correctly (given 0x0b looks like unusable to 'drive'
0x28)... unless there could be some sort of 'confusion' between 0x2a's
and 0x29's connection lists, given the latter is connected to 0x0b via
0x1c and 0x35 (that is, could respective connection lists be
'inverted' somehow? does it make sense? or is bios-derived autoconfig
the only one usable?).


> yes, it is still possible that vt1718s without a grey jack is just a 8
> channel codec , but those variants of vt1718s which has a grey jack
> are most likely a 10 channel codec
>


That's a chance, unless 0x2a could be connected to 0x0b so that 0x0c
remained available for HP (I guess). Otherwise, 0x0c should be used as
side and front panel hp should be either muted or get input from 0x08
(front, as in redirected output) or 0x0c ('new' side) - again, I'm
guessing.


>>>>> In alsa,
>>>>>
>>>>> when independent HP is on,
>>>>>
>>>>> The HP jack is supposed to connected to [Audio Output] which is not
>>>>> used by the rear panel jacks (i.e. 0x25) and application has to use
>>>>> sudevice 1
>>>>>
>>>>> you can use aplay -Dhw:0,0,1 stereo.wav
>>>>
>>>> Tested: it works. I can get different streams out of rear (front
>>>> playback) and front (hp) line out jacks (used mplayer on the 'default'
>>>> rear channel(s) and aplay as above on the front panel)
>>>>
>>>
>>>
>>>
>>> so you can check whether 0xb can be used instead of 0xc for headphone
>>
>> Before testing your code:
>>
>>>
>>> static int via_independent_hp_put(struct snd_kcontrol *kcontrol,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct snd_ctl_elem_value *ucontrol)
>>> {
>>> =A0 =A0 =A0 =A0struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
>>> =A0 =A0 =A0 =A0struct via_spec *spec =3D codec->spec;
>>> =A0 =A0 =A0 =A0hda_nid_t nid =3D kcontrol->private_value;
>>> =A0 =A0 =A0 =A0unsigned int pinsel =3D ucontrol->value.enumerated.item[=
0];
>>> =A0 =A0 =A0 =A0/* Get Independent Mode index of headphone pin widget */
>>> =A0 =A0 =A0 =A0spec->hp_independent_mode =3D spec->hp_independent_mode_=
index =3D=3D pinsel
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? 1 : 0;
>>> =A0 =A0 =A0 =A0if (spec->codec_type =3D=3D VT1718S)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write(codec, nid, 0,
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 A=
C_VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 A=
C_VERB_SET_CONNECT_SEL, pinsel ?
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
pec->hp_independent_mode_index : 0);
>>>
>>>
>>
>>
>>>[...cut...]
>>>
>>> static const struct hda_verb vt1718S_volume_init_verbs[] =3D {
>>>
>>> - =A0 =A0 =A0 {0x34, AC_VERB_SET_CONNECT_SEL, 0x2},
>>> + =A0 =A0 =A0 {0x34, AC_VERB_SET_CONNECT_SEL, 0x0},
>>> =A0 =A0 =A0 =A0{0x35, AC_VERB_SET_CONNECT_SEL, 0x1},
>>>
>>>
>>
>>

I've tried this part, along with:

static int vt1718S_auto_create_hp_ctls(struct via_spec *spec, hda_nid_t pin)
{
       int err;

       if (!pin)
               return 0;
+   if (spec->autocfg.line_outs =3D=3D 4) {
       spec->multiout.hp_nid =3D 0xc; /* AOW4 */
+       spec->hp_independent_mode_index =3D 2;
+   }
+   else {
+       spec->multiout.hp_nid =3D 0xb;
       spec->hp_independent_mode_index =3D 1;
+}


(from your previous message, reposting for clarity and reference)

but got no audio with aplay -Dhw:0,0,1 stereo.wav

On my first attempt, I noticed node 0x0c still got control "Headphone
Playback Volume", thus I modified vt1718S_auto_create_hp_ctls() so
that:


err =3D via_add_control(spec, VIA_CTL_WIDGET_VOL,
	      "Headphone Playback Volume",
-	      HDA_COMPOSE_AMP_VAL(0x0c, 3, 0, HDA_OUTPUT));
+	      HDA_COMPOSE_AMP_VAL(spec->multiout.hp_nid, 3, 0, HDA_OUTPUT));


which labeled 0x0b as "Headphone Playback Volume", but still no output
came from there; I've also tried to change

{0x34, AC_VERB_SET_CONNECT_SEL, 0x0}

into

{0x34, AC_VERB_SET_CONNECT_SEL, 0x1}

and

{0x35, AC_VERB_SET_CONNECT_SEL, 0x1}

into

{0x35, AC_VERB_SET_CONNECT_SEL, 0x0} or {0x35, AC_VERB_SET_CONNECT_SEL, 0x2}

in case some weird conflict happened when both 0x34 and 0x35 where
initialized with/switched to the same connection, still to no avail.

I've also applied a piece of code you posted earlier and retried those
combinations, but nothing changed -- code being:


static const struct hda_verb vt1718S_volume_init_verbs[] =3D {

       /* Amp Indices: CD =3D 1, Mic1 =3D 2, Line =3D 3, Mic2 =3D 4 */
       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(0)},
       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(1)},
       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(2)},
       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(3)},
+       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_MUTE(4)},
-       {0x21, AC_VERB_SET_AMP_GAIN_MUTE, AMP_IN_UNMUTE(5)},


(apparently should be unrelated, though trying to access a connection
that doesn't exist for 0x21 shouldn't be very safe/correct, so I've
kept the above).

This other code (from your same message addressing 0x21 access to a
wrong connection):


info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =3D
        spec->multiout.dac_nids[0];
+    info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams =3D
+       ( snd_hda_find_mixer_ctl(codec, "Independent HP") ? 2 : 1);

    info->stream[SNDRV_PCM_STREAM_CAPTURE] =3D *(spec->stream_analog_captur=
e);


didn't work at all:

executing 'aplay -Dhw:0,0,1 stereo.wav' failed with error:


aplay: main:660: audio open error: Device or resource busy


executing 'aplay -l' showed the second subdevice for card#0 analog
device hadn't been created:


**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT2020 Analog [VT2020 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: VT2020 Digital [VT2020 Digital]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
card 1: HDMI [HDA ATI HDMI], device 3: HDMI 0 [HDMI 0]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


(this happened with front audio panel _enabled_ in BIOS)

Adding a few printk()'s to file "patch_via.c" showed me function
via_hp_build() is called before via_build_pcms() (unless front panel
is disabled in BIOS, in which case via_hp_build() isn't invoked at
all), therefore, when a control "Independent HP" is created, it should
be 'visible' by via_build_pcms(); however,
snd_hda_find_mixer_ctl(codec, "Independent HP") fails to find it until
the following loop is executed inside via_build_controls:


	for (i =3D 0; i < spec->num_mixers; i++) {
		err =3D snd_hda_add_new_ctls(codec, spec->mixers[i]);
		if (err < 0)
			return err;
	}


and via_build_controls() is called after via_build_pcms(), but then
it's too late (or seemed to be such) to modify the number of playback
substreams. At last, I've tried the following, which worked:

static int via_build_pcms(struct hda_codec *codec)
{
	struct via_spec *spec =3D codec->spec;
	struct hda_pcm *info =3D spec->pcm_rec;
+	const struct snd_kcontrol_new *knew;
+	int index, found=3D0;

[ ... ]
	info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =3D
		spec->multiout.dac_nids[0];
+
+	/* is this a multistream-capable environment? let's assume no and
check if yes instead */
+	info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams =3D 1;
+	for( index =3D 0; index < spec->num_mixers; index++ ){
+		knew =3D spec->mixers[ index ];
+		while( knew->name ){
+			if( !strcmp( knew->name, "Independent HP" ) ){
+				/* it looks like there's a front panel */
+				info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams =3D 2;
+				found =3D 1;
+				break;
+			}
+			knew++;
+		}
+		if( found )
+			break;
+	}
+
	info->stream[SNDRV_PCM_STREAM_CAPTURE] =3D *(spec->stream_analog_capture);


(I'm omitting debug printk() calls and the rest of the function)

But, perhaps, struct via_spec could have a flag initialized to zero
(somewhere, before via_hp_build() and via_build_pcms() are invoked,
perhaps in via_new_spec() ) and set to 1 when via_hp_build() succeeds
cloning via_hp_mixer[0], that is:

	knew =3D via_clone_control(spec, &via_hp_mixer[0]);
	if (knew =3D=3D NULL)
		return -ENOMEM;

	knew->subdevice =3D HDA_SUBDEV_NID_FLAG | nid;
	knew->private_value =3D nid;
+	spec->front_panel =3D HDA_HW_WITH_FRONT_PANEL;

( "#define HDA_HW_WITH_FRONT_PANEL 1" and "#define
HDA_HW_WITHOUT_FRONT_PANEL 0" put somewhere in the file)

 so that via_build_pcms() could just do something like:


info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams =3D 1 + spec->front_pane=
l;


but via_hp_build() is called if spec->hp_mux is not null, therefore
one might think (mistakenly, according to me) to do just the
following:


info->stream[SNDRV_PCM_STREAM_PLAYBACK].substreams =3D
         ( spec->hp_mux ? 2 : 1 );


however, that shouldn't work, because even if spec->hp_mux has been
created, via_hp_build() might not create an "Independent HP" control,
for instance because of a wrong number of connections to the relevant
nid:


	if (spec->codec_type !=3D VT1708) {
		nums =3D snd_hda_get_connections(codec, nid,
					       conn, HDA_MAX_CONNECTIONS);
		if (nums <=3D 1)
			return 0;
	}


Anyway, I'm posting output of asla-info.sh for the above code I've
tested with front audio panel disabled in BIOS (the loop inside
via_build_pcms, I mean, for now I've preferred not to touch struct
via_spec)


http://pastebin.ca/2076750


By the way, should something like the above be done for capture
streams as well? I've noticed (with front panel disabled) that
controls "Front Mic Playback Volume" and "Front Mic Playback Switch"
are correctly missing from audio-mixer widget 0x21, but node 0x29 is
still 'attached' to control "Front Mic Boost Capture Volume", which is
accessible through a mixer (though I didn't try to play with it; it is
listed also by amixer output in above linked document). Is this the
wanted/expected behaviour? (I understand there must be, anyway, two
captures and two input sources, because there's still one line-in plus
one (rear) mic, plus stereo-mix to deal with, and one "boost capture
volume" control for the rear mic does make sense, my doubt is about
its corresponding control for the now missing front mic).

If there are any other tests you wish me to do (such as sending raw
verbs to the hw and posting results), just let me know.
