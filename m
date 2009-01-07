From: Mysth-R <mysthr21@gmail.com>
Subject: Re: snd_usb_caiaq bug?
Date: Wed, 7 Jan 2009 21:06:23 +0100
Message-ID: <907c05c70901071206y4bba38bej47f3eba51e6106d3@mail.gmail.com>
References: <31e66c9e0901040829y4bedc1ebgcf91afe10d80341a@mail.gmail.com>
	<s5hprizv0yh.wl%tiwai@suse.de>
	<31e66c9e0901070741i2f6f363l9dc023223954ce2@mail.gmail.com>
	<s5hk597t6pm.wl%tiwai@suse.de>
	<31e66c9e0901071046v36112db7s757788bcf5beaeeb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by alsa0.perex.cz (Postfix) with ESMTP id CE8AD1037E3
	for <alsa-devel@alsa-project.org>; Wed,  7 Jan 2009 21:06:25 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 24so9263953wfg.23
	for <alsa-devel@alsa-project.org>; Wed, 07 Jan 2009 12:06:24 -0800 (PST)
In-Reply-To: <31e66c9e0901071046v36112db7s757788bcf5beaeeb@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Santamaria <marco.santamaria@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I have almost the same problem as Marco. (that is why Marco forwarded me
this message).

Well, Now it seems to be almost perfect. Just to explain to you :

I had a problem with Pure data, each time I wanted to enable the alsa midi
(in pure data). Then I had some problem opening some of my patch, making pd
zombified and Jack output tons of "delay of 1666.000 usecs exceeds estimated
spare time of 1140.000; restart ..." until I stop it and run it again.

Now pd works perfectly. I made some others jackd settings, and the "xruns"
messages seems to gone away.

But like Marco I got this message in the output of dmesg :

[ 20.269196] Adding 530136k swap on /dev/sda3. Priority:-1 extents:1
across:530136k
[ 445.142031] snd-usb-caiaq log: snd_usb_caiaq_midi_send(ffff81007f9380c0):
usb_submit_urb() failed, -22
[ 445.393030] snd-usb-caiaq log: snd_usb_caiaq_midi_send(ffff81007f9380c0):
usb_submit_urb() failed, -22
[ 445.640986] snd-usb-caiaq log: snd_usb_caiaq_midi_send(ffff81007f9380c0):
usb_submit_urb() failed, -22
[ 445.892008] snd-usb-caiaq log: snd_usb_caiaq_midi_send(ffff81007f9380c0):
usb_submit_urb() failed, -22
[ 446.141982] snd-usb-caiaq log: snd_usb_caiaq_midi_send(ffff81007f9380c0):
usb_submit_urb() failed, -22
[ 446.392962] snd-usb-caiaq log: snd_usb_caiaq_midi_send(ffff81007f9380c0):
usb_submit_urb() failed, -22
[ 446.640967] snd-usb-caiaq log: snd_usb_caiaq_midi_send(ffff81007f9380c0):
usb_submit_urb() failed, -22
[ 446.891986] snd-usb-caiaq log: snd_usb_caiaq_midi_send(ffff81007f9380c0):
usb_submit_urb() failed, -22
[ 461.651199] CPU0: Temperature/speed normal
infos :
kernel : 2.6.26.8-rt12   (with the last patch solving alsa midi problems).
OS : Gentoo 64bits.
Sounds card : NI Audio Kontrol 1
alsa : 1.0.16 (with your patchs now.)

Thank you for your help and your great job. I can use pd now, my main
software to make music. So I am very happy :)

Just a thing, when I press the buttons on the top of the Audio Kontrol 1 I
got qbc  (azerty keyboard). but When I move the jog, the system log out.

Did anyone find a way to change the assignation of these buttons ?

Kind regards,

Mysth-R

2009/1/7 Marco Santamaria <marco.santamaria@gmail.com>

> The "rawmidi drain error" went away.
> Now if I start and shut down jackd nothing bad happens.
> But when I launch Rosegarden there are several lines containing the
> following new message:
>
> [  455.025168] ALSA
> /home/marco/build/linux-2.6.24-19-rt/alsa-1.0.17/driver-patched/alsa-driv=
er-1.0.17/usb/caiaq/../../alsa-kernel/usb/caiaq/caiaq-midi.c:84:
> snd-usb-caiaq log: snd_usb_caiaq_midi_send(f76a5ac0): usb_submit_urb()
> failed, -22
>
> Furthermore the first time I rebooted my system, it freezed during the
> startup procedure (loading hardware drivers), but it didn't happen again.
>
>
> Marco
>
> 2009/1/7 Takashi Iwai <tiwai@suse.de>
>
>> At Wed, 7 Jan 2009 16:41:21 +0100,
>> Marco Santamaria wrote:
>> >
>> > I applied the patch (or I think so...). I just removed the line:
>> >
>> > dev->midi_out_substream =3D NULL;
>> >
>> > from the function snd_usb_caiaq_midi_output_done in the file
>> caiaq-midi.c.
>> > Then I recompiled the driver.
>> >
>> > The main issue is sorted out: I can start and shut down jackd without
>> big
>> > problems.
>> >
>> > But with dmesg I still have the following message:
>> >
>> > ALSA /home/marco/build/linux-2.6.24-19-rt/alsa-1.0.17/driver-patched/
>> > alsa-driver-1.0.17/acore/rawmidi.c:196: rawmidi drain error (avail =3D
>> 4095,
>> > buffer_size =3D 4096)
>> >
>> > Not sure if it is safe to ignore it.
>>
>> Hmm, what about the patch below?
>>
>>
>> Takashi
>>
>> ---
>> diff --git a/sound/usb/caiaq/caiaq-midi.c b/sound/usb/caiaq/caiaq-midi.c
>> index 30b57f9..9557635 100644
>> --- a/sound/usb/caiaq/caiaq-midi.c
>> +++ b/sound/usb/caiaq/caiaq-midi.c
>> @@ -69,7 +69,8 @@ static void snd_usb_caiaq_midi_send(struct
>> snd_usb_caiaqdev *dev,
>>
>>        dev->midi_out_buf[0] =3D EP1_CMD_MIDI_WRITE;
>>        dev->midi_out_buf[1] =3D 0; /* port */
>> -       len =3D snd_rawmidi_transmit_peek(substream, dev->midi_out_buf+3,
>> EP1_BUFSIZE-3);
>> +       len =3D snd_rawmidi_transmit(substream, dev->midi_out_buf + 3,
>> +                                  EP1_BUFSIZE - 3);
>>
>>        if (len <=3D 0)
>>                return;
>> @@ -87,16 +88,12 @@ static void snd_usb_caiaq_midi_output_trigger(struct
>> snd_rawmidi_substream *subs
>>  {
>>        struct snd_usb_caiaqdev *dev =3D substream->rmidi->private_data;
>>
>> -       if (dev->midi_out_substream !=3D NULL)
>> -               return;
>> -
>> -       if (!up) {
>> +       if (up) {
>> +               dev->midi_out_substream =3D substream;
>> +               snd_usb_caiaq_midi_send(dev, substream);
>> +       } else {
>>                 dev->midi_out_substream =3D NULL;
>> -               return;
>>        }
>> -
>> -       dev->midi_out_substream =3D substream;
>> -       snd_usb_caiaq_midi_send(dev, substream);
>>  }
>>
>>
>> @@ -169,8 +166,6 @@ void snd_usb_caiaq_midi_output_done(struct urb* urb)
>>        if (!dev->midi_out_substream)
>>                 return;
>>
>> -       snd_rawmidi_transmit_ack(dev->midi_out_substream, buf[2]);
>> -       dev->midi_out_substream =3D NULL;
>>        snd_usb_caiaq_midi_send(dev, dev->midi_out_substream);
>>  }
>>
>>
>


-- =

*
***************************************************************************=
************
*  {^_^} Mysth-R {^_^}
*  <=3D Aide Auditive =3D>
*
* http://myspace.com/mysthr
* http://myspace.com/aideauditive
* http://mysthr.free.fr/Joomla  =3D> Site d=E9di=E9 =E0 l'audio sous
Fedora/PlanetCCRMA.
*
***************************************************************************=
************
