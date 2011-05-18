From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd jack report and unsolicited event ad1988
Date: Wed, 18 May 2011 10:10:32 +0800
Message-ID: <BANLkTinLyZW7HO1nV+tXso2LGtipD25rLw@mail.gmail.com>
References: <BANLkTikbOGHJp9VJ+yyA4dJxgcbuNk4LeA@mail.gmail.com>
	<s5hsjstmq6i.wl%tiwai@suse.de>
	<BANLkTinNiWDMKVt8U-7o9GRvJG3KmC-osQ@mail.gmail.com>
	<s5haaewjcrz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 712B41037E3
	for <alsa-devel@alsa-project.org>;
	Wed, 18 May 2011 04:10:32 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1027537fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 17 May 2011 19:10:32 -0700 (PDT)
In-Reply-To: <s5haaewjcrz.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/5/9 Takashi Iwai <tiwai@suse.de>:
> At Mon, 9 May 2011 11:56:11 +0800,
> Raymond Yau wrote:
>>
>> 2011/5/5 Takashi Iwai <tiwai@suse.de>
>>
>> >> This mean that the driver need to define FRONT_MIC_EVENT, REAR_MIC_EV=
ENT,
>> >> LINE_IN_EVENT in addition to HP_EVENT
>>
>> >Does it mean that the codec can't accept the same id tag for multiple
>> >pins?
>>
>> No, the event can be received by the event handler but there is no way to
>> know the event is related to which jack
>
> Yeah, sure, if you want to distinguish each pin, you have to assign
> different ids. =A0But it's independent from my question.
>
> Your statement sounded as if the multiple pins aren't allowed to have
> the same tag on AD codec. =A0But, it seems that it's OK, judging from
> your follow up.
>

If you assign the same tag, you have to perform snd_jack_detect() on
multiple pin complex  and the driver won't know exactly which jack is
plugged in/out unless it store the previous state of 8 jacks

>
>> >> Can =A0snd_jack_report used to report the mic event of two pink jacks
>> (front
>> >> panel and rear panel) of the desktop to the user space program?
>>
>> > I assumed so, but someone needs to confirm.
>> > Assigning different tags is easy and safe, so even if it worked, we
>> > can go forward for individual tags.
>>
>> So =A0the point is whether the user space program need to know
>>
>> 1) the event is related to the plug in or out of the front mic jack / re=
ar
>> mic jack
>> 2) whether earphone or speaker is plugged into correct/wrong jacks by
>> measured impedance .
>
> In some time future, yes, a program like PulseAudio would like to know
> and behave reactively to the plug state. =A0But, in that case, the whole
> driver design should be changed -- the kernel driver should do as
> little as possible regarding the jack task switching.
>

Do snd_jack_report allow the driver to add two jacks input for front
mic and rear mic ?

>>
>> =A0So, adding some delay like below makes it working?
>> >
>>
>> =A0 =A0 =A0 =A0if (!codec->no_trigger_sense) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pincap =3D snd_hda_query_pin_caps(codec=
, nid);
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pincap & AC_PINCAP_TRIG_REQ) /* need=
 trigger? */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pincap & AC_PINCAP_TRIG_REQ) { /* ne=
ed trigger? */
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_read(code=
c, nid, 0,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0AC_VERB_SET_PIN_SENSE, 0);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (codec->trigger_delay=
 > 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(c=
odec->trigger_delay);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> > =A0 =A0 =A0 =A0}
>> > =A0 =A0 =A0 =A0return snd_hda_codec_read(codec, nid, 0,
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AC_=
VERB_GET_PIN_SENSE, 0);
>> >
>>
>> Noise appear =A0when delay is add at here
>
> In which situation? =A0From unplugged to plugged?
>
>> Have to wait until someone find a safe way to get the impedance without =
any
>> side effect
>
> Looks so.

The noise appear until system shutdown


>
>> =A0 =A0 =A0 =A0spec->vmaster_nid =3D 0x04;
>> >
>> > - =A0 =A0 =A0 codec->no_trigger_sense =3D 1;
>> > + =A0 =A0 =A0 /* codec->no_trigger_sense =3D 1; */
>> > + =A0 =A0 =A0 codec->trigger_delay =3D 5;
>> > =A0 =A0 =A0 =A0codec->no_sticky_stream =3D 1;
>> >
>> > =A0 =A0 =A0 =A0return 0;
>> >
>>
>>
>> So no need to change if the objective of snd_hda_jack_detect() is to get
>> presence detect bit
>>
>> As mentioned in 729d55ba972348234759f8e40abf8d
>> e020f0d505
>>
>> use tigger at pin-sensing seem generate a lot of responses
>
> When the unsol events are triggered, more exactly?
> If these are issued at once, the events can be filtered out by
> checking some flag or checking some timeout, etc. =A0If an event is
> still triggered at 100ms after the actual plugging, it's a bit
> problem...
>

my unsol event handler just perform jack detect according to the tag
and print the result to system log only  and still don't have any
mute/unmute statement

It seem that the following command also trigger a repsonse to
unsol_event handler

./hda-verb /dev/snd/hwC1D0 0x12 SET_PIN_SENSE 0
nid =3D 0x12, verb =3D 0x709, param =3D 0x0
value =3D 0x0

dmesg
unsol event res 48000000 tag 12
pincap 1014010 : 12  no jack detected Color =3D Green Line Out at Ext Rear



./hda-verb /dev/snd/hwC1D0 0x16 SET_PIN_SENSE 0
nid =3D 0x16, verb =3D 0x709, param =3D 0x0
value =3D 0x0

dmesg
unsol event res 58000000 tag 16
pincap 1011012 : 16  sense 1e Color =3D Black Line Out at Ext Rear
