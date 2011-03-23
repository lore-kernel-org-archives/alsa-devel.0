From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: issue with AD1989A HDA codec and alsamixer
Date: Wed, 23 Mar 2011 14:51:11 +0800
Message-ID: <AANLkTinB+tTUDZ97Pz0WO9=_ErmcBtCdqxTBOD2qHCQi@mail.gmail.com>
References: <AANLkTin8tsrNrcoYaPvQz0uO=OtD-tow1Ds0i8WTJyh7@mail.gmail.com>
	<AANLkTinec0di98dMdyNoANXBoLG_uRJ+NghEyboCuMUa@mail.gmail.com>
	<AANLkTim-Vq6bhd=nHOVkToMSuT9R1n3nnQi-J4bzZNc_@mail.gmail.com>
	<AANLkTikRJtbkSewNxEC_SqapNXQookdcHit4cDDix_s7@mail.gmail.com>
	<AANLkTinoF-RqGFo7w57E8C+L5=zKH_hQ+0G0defh0WX-@mail.gmail.com>
	<AANLkTikugTHmj5aKZqXSi3g50gkqLDXiWmTshBbd9TGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id EA72D243FB
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2011 07:51:14 +0100 (CET)
Received: by fxm6 with SMTP id 6so7015989fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 23:51:11 -0700 (PDT)
In-Reply-To: <AANLkTikugTHmj5aKZqXSi3g50gkqLDXiWmTshBbd9TGQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/2/7 Vincent Meserette <vmeserette@aldebaran-robotics.com>

> Hi Raymond,
>
> Thanks for your reply.
>
> To reply to your question, indeed the AD1989A codec is seen by alsa as a
> device containing three subdevices (the three ADC) :
>
>  result of arecord -l :
>  List of CAPTURE Hardware Devices :
>
>  card 0: MID [HDA Intel MID], device 0: AD198x Analog [AD198x Analog]
>
>  Subdevices: 3/3
>  Subdevice #0: subdevice #0
>  Subdevice #1: subdevice #1
>  Subdevice #2: subdevice #2
>
>
> To record four channels simultaneously, I have created the following alsa=
 configuration file :
>
> *# output device
> pcm.AD1989A{
>     type hw
>     card 0
> }
>
> # input device* *
> pcm.quad {
>         type multi
>
>         slaves.a.pcm "hw:0,0,0" # ADC 0 of the codec (left and right mics)
>         slaves.a.channels 2
>         slaves.b.pcm "hw:0,0,1" # ADC 1 of the codec (front and rear mics)
>         slaves.b.channels 2
>
>         bindings.0.slave a
>         bindings.0.channel 0
>         bindings.1.slave a
>         bindings.1.channel 1
>         bindings.2.slave b
>         bindings.2.channel 0
>         bindings.3.slave b
>         bindings.3.channel 1
> }
>
> # input device containing interleaved data
> pcm.quad2 {
>         type route
>         slave.pcm "quad"
>         ttable.0.0 1
>         ttable.1.1 1
>         ttable.2.2 1
>         ttable.3.3 1
> }
>
> ### CTL DEVICES (controls)
> ctl.mixer0 {
>     type hw
>     card 0
> }*
>
> With this configuration file, I am able to record the four channels
> simultaneously with the following command :
>
> arecord -c4 -fS16_LE -r48000 -D =ABquad2 =BB -d5 /tmp/recording.wav
>
>
> I found from where came my problem with the capture gains by adding some
> logs in the hda_codec.c file.
> When I set one of the capture gain, the put_vol_mute function well write =
in
> the AMP_GAIN_MUTE verb of the corresponding ADC selector (0x0c, 0x0d or 0=
x0e
> widget) but the mute bit is always set to 1.
> Indeed, the value associated to the AMP_GAIN_MUTE verb is formated as fol=
ow
> :
> bits  0 to 6 : gain
> bit 7 : mute
> bits 8 to 11 : index
> bit 12 : set right amp
> bit 13 : set left amp
> bit 14 : set input amp
> bit 15 : set output amp
>
> and alsa sets the value of this register from a080 / b080 to a0b6 / b0b6
> when i change the gain from -58.5 dB to 22.5dB
>
> Do you know how alsa and thus the alsamixer determine the minimum and
> maximum values for the capture gain, and how to say to alsa the the gain =
is
> only a 7bits step value ?
>
> Thanks in advance.
>
> Best regards
>
> Vincent
>
>
>
>
>
> 2011/2/5 Raymond Yau <superquad.vortex2@gmail.com>
>
>> 2011/2/3 Vincent Meserette <vmeserette@aldebaran-robotics.com>
>>
>> > Hi Raymond,
>> >
>> > Many thanks for your answer.
>> >
>> > Looking the AD1989A datasheet (which can be found here :
>> > http://www.conexant.com/products/entry.jsp?id=3D599) the vendor id of =
the
>> > codec seems to be 11D4989A
>> > So, I think the codec taken into account in the "patch_analog.c" file =
is
>> > well the AD1989A because I found these lines in the source code :
>> >
>> > /*
>> >  * patch entries
>> >  */
>> > static struct hda_codec_preset snd_hda_preset_analog[] =3D {
>> >    ...
>> >     { .id =3D 0x11d4989a, .name =3D "AD1989A", .patch =3D patch_ad1988=
 },
>> >    ...
>> >     {} /* terminator */
>> > };
>> >
>> > Concerning the digital microphone input of the codec, I don't use it. I
>> > have four electret microphones connected to the B and C ports of the
>> codec
>> > (one on the PORT-B_L pin, one on the PORT-B_R pin, one on the PORT-C_L
>> pin
>> > and one on the PORT-C_R pin). I have connected by software configurati=
on
>> the
>> > port B to the ADC1 and the port C to the ADC0.
>> > Maybe my problem comes from here, because I don't use the codec in a
>> > standard configuration ?
>> > if it is the case, do you know how can i resolve it ?
>> > Do you also know which registers control the three capture gains of the
>> > alsamixerl (i thought it was the gains of the ADC0, ADC1 and ADC2 )?
>> >
>>
>> can you post the output of alsa-info.sh
>>
>> Six 192kHz 92dB ADCs
>> - simultaneous record of up to 3 stereo channels
>>
>> It does not imply you can record 4 channels with the existing hda driver
>> which create three subdevices
>>
>


when  recording with 4 channels using audacity with my ad1988a, audacity
hang after a few seconds or half minute

Does snd-hda-inel really suport SNDRV_PCM_INFO_SYNC_START ?


ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D0/1216/4864,
hwptr=3D1216/314944/316160/311296
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D1/1216/4864,
hwptr=3D1216/314945/316161/311296
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D1216/1216/4864,
hwptr=3D1207/316169/317376/316160
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D1217/1216/4864,
hwptr=3D1216/316161/317377/316160
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D2432/1216/4864,
hwptr=3D1216/317376/318592/316160
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D2433/1216/4864,
hwptr=3D1216/317377/318593/316160
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D3648/1216/4864,
hwptr=3D1199/318609/319808/316160
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D3649/1216/4864,
hwptr=3D1216/318593/319809/316160
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D0/1216/4864,
hwptr=3D1216/319808/321024/316160
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D1/1216/4864,
hwptr=3D1216/319809/321025/316160
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D1216/1216/4864,
hwptr=3D1207/321033/322240/321024
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D1217/1216/4864,
hwptr=3D1216/321025/322241/321024
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D2432/1216/4864,
hwptr=3D1216/322240/323456/321024
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D2433/1216/4864,
hwptr=3D1216/322241/323457/321024
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D3648/1216/4864,
hwptr=3D1199/323473/324672/321024
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D3649/1216/4864,
hwptr=3D1216/323457/324673/321024
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D0/1216/4864,
hwptr=3D1216/324672/325888/321024
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D1/1216/4864,
hwptr=3D1216/324673/325889/321024
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D1216/1216/4864,
hwptr=3D1184/325920/327104/325888
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D1217/1216/4864,
hwptr=3D1216/325889/327105/325888
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D2432/1216/4864,
hwptr=3D1216/327104/328320/325888
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D2433/1216/4864,
hwptr=3D1216/327105/328321/325888
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D3648/1216/4864,
hwptr=3D1215/328321/329536/325888
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D3649/1216/4864,
hwptr=3D1216/328321/329537/325888
ALSA pcm_lib.c:374: period_update: pcmC0D0c:0: pos=3D0/1216/4864,
hwptr=3D1216/329536/330752/325888
ALSA pcm_lib.c:374: period_update: pcmC0D0c:1: pos=3D1/1216/4864,
hwptr=3D1216/329537/330753/325888


ALSA pcm_lib.c:172: XRUN: pcmC0D0c:1

 [<f895f201>] xrun+0x97/0x9e [snd_pcm]
 [<f895f859>] snd_pcm_update_state+0x74/0xc1 [snd_pcm]
 [<f895fe03>] snd_pcm_update_hw_ptr0+0x55d/0x569 [snd_pcm]
 [<c042823f>] ? default_wake_function+0xb/0xd
 [<c0421fd3>] ? __wake_up+0x31/0x3b
 [<f895fe89>] snd_pcm_period_elapsed+0x7a/0xe9 [snd_pcm]
 [<f8a41744>] azx_interrupt+0x99/0x120 [snd_hda_intel]
 [<c046548f>] handle_IRQ_event+0x2f/0x64
 [<c04664f8>] handle_fasteoi_irq+0x85/0xc0
 [<c0466473>] ? handle_fasteoi_irq+0x0/0xc0
 [<c0406e6e>] do_IRQ+0xc7/0xfe
 [<c0405668>] common_interrupt+0x28/0x30
 [<c040a112>] ? mwait_idle+0x38/0x4b
 [<c0403c61>] cpu_idle+0x101/0x134
 [<c06a7db4>] start_secondary+0x197/0x19f

 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ALSA hda_intel.c:1679: azx_pcm_prepare: bufsize=3D0x4c00, format=3D0x11
ALSA hda_codec.c:1228: hda_codec_setup_stream: NID=3D0x8, stream=3D0x1,
channel=3D0, format=3D0x11
ALSA hda_intel.c:1679: azx_pcm_prepare: bufsize=3D0x4c00, format=3D0x11
ALSA hda_codec.c:1228: hda_codec_setup_stream: NID=3D0x9, stream=3D0x2,
channel=3D0, format=3D0x11
ALSA hda_intel.c:1679: azx_pcm_prepare: bufsize=3D0x4c00, format=3D0x11
ALSA hda_codec.c:1228: hda_codec_setup_stream: NID=3D0x8, stream=3D0x1,
channel=3D0, format=3D0x11
ALSA hda_intel.c:1679: azx_pcm_prepare: bufsize=3D0x4c00, format=3D0x11
ALSA hda_codec.c:1228: hda_codec_setup_stream: NID=3D0x9, stream=3D0x2,
channel=3D0, format=3D0x11
ALSA hda_codec.c:1291: hda_codec_cleanup_stream: NID=3D0x8
ALSA hda_codec.c:1291: hda_codec_cleanup_stream: NID=3D0x9
ALSA hda_codec.c:1291: hda_codec_cleanup_stream: NID=3D0x8
ALSA hda_codec.c:1291: hda_codec_cleanup_stream: NID=3D0x9
