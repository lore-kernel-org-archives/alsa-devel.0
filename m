From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: need support for insatllation of pci sound card.
Date: Mon, 16 Nov 2009 10:10:16 +0800
Message-ID: <4f3252890911151810n775226o61fbf3f9abe61d6e@mail.gmail.com>
References: <daf8bdba0911121306j3bb7b3ffo3efcf7c14793196f@mail.gmail.com>
	<daf8bdba0911121311j1f7be714w73b8aab1496c3788@mail.gmail.com>
	<4f3252890911141617n3e7418c6y9de2e5c5d7b2d1b4@mail.gmail.com>
	<daf8bdba0911142111nb2dff9o1491fabf950f789b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f179.google.com (mail-px0-f179.google.com
	[209.85.216.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EDEB2446F
	for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2009 03:10:17 +0100 (CET)
Received: by pxi9 with SMTP id 9so2222301pxi.16
	for <alsa-devel@alsa-project.org>; Sun, 15 Nov 2009 18:10:16 -0800 (PST)
In-Reply-To: <daf8bdba0911142111nb2dff9o1491fabf950f789b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/11/15 Kunal Narkhede <kunal.narkhede@gmail.com>

> Hi Raymond,
>
> With my sound card i got a cd of drivers which has some drivers for linux=
 i
> guess but the installaltion steps given in readme file are very tough for=
 me
> to follow as the  paths given in that file seems to be diffrent in my ubu=
ntu
> linux. eg /usr/src/driver/sound this path is not exixting in ubuntu also
> after as stated in readme file the option which i should get after execut=
ing
> the "make config" command for sound card are diffrent and even if i enter
> the option given in readme file the forth coming options are diffrent and
> take defult value and final result is failure of installation of drivers =
as
> the module that is requires to be installed is not created.
>
> I am attaching the readme file and the drivers for your kind
> reference.Kindly please help me solve this issue..Its been 3 4 months that
> this issue is bugging me please.
>
>
>
> On Sun, Nov 15, 2009 at 5:47 AM, Raymond Yau <superquad.vortex2@gmail.com=
>wrote:
>
>> 2009/11/13 Kunal Narkhede <kunal.narkhede@gmail.com>
>>
>> > hi,
>> >
>> > Please help me install my sound card drivers.As told in forum i updated
>> my
>> > alsa drivers with the provided one.My card seems to getting recognize
>> but
>> > no
>> > sound is heard here is
>> > *output of "aplay -l" command
>> > *
>> > **** List of PLAYBACK Hardware Devices ****
>> > card 0: AudioPCI [Ensoniq AudioPCI], device 0: ES1371/1 [ES1371
>> DAC2/ADC]
>> > Subdevices: 1/1
>> > Subdevice #0: subdevice #0
>> > card 0: AudioPCI [Ensoniq AudioPCI], device 1: ES1371/2 [ES1371 DAC1]
>> > Subdevices: 1/1
>> > Subdevice #0: subdevice #0
>> >
>> >
>> > I have also *attached the logfile obtained from alsainfo.sh* provided =
on
>> > the
>> > thread of alsa upgrade script.
>> >
>> > Please help me install my sound card have been searching for drivers
>> since
>> > 7
>> > months and its getting frustating now.
>> >
>> > Mine is PCI sound card on-board sound card has been disabled from bios=
..
>> >
>> > I am usung* ubuntu 9.04 with 2.6.28-16-generic kerne*l installed throu=
gh
>> > updates using update manager.
>> >
>> > --
>> > With Regards
>> > Kunal
>> > 9860384968
>> >
>> >
>> This is known bug of EV1938 , it seem that EV1938 no longer  read ac97
>> codec
>> registers correctly  at the time of  alsa-driver  1.0.8
>>
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1389
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3D1023
>>
>> Symptoms are
>>
>> 1) Unable to identify Sigmatec AC97 codec  9705
>>
>> 0-0/0: 0x76058384 F=D5S
>>
>> 0:7c =3D 0000
>> 0:7e =3D 8384
>>
>>
>> 2) The value of reset register are wrong
>>
>> 0:00 =3D 0000
>>
>> Flags: 0
>> Capabilities     : -dedicated MIC PCM IN channel- -bass & treble-
>> DAC resolution   : 16-bit
>> ADC resolution   : 20-bit
>> 3D enhancement   : Reserved 29
>>
>>
>> 3) The value of other registers and mixer controls are wrong
>>
>>
>> 0:02 =3D 0140
>> 0:04 =3D 8e0e
>> 0:06 =3D 8000
>> 0:08 =3D 800e
>> 0:0a =3D 0000
>> 0:0c =3D 1f0f
>> 0:0e =3D 801f
>> 0:10 =3D 801f
>> 0:12 =3D 9f1f
>> 0:14 =3D 8808
>> 0:16 =3D 9f1f
>> 0:18 =3D 8808
>> 0:1a =3D 8808
>> 0:1c =3D 8808
>> 0:1e =3D 0808
>> 0:20 =3D 0000
>> 0:22 =3D 0000
>> 0:24 =3D 0000
>> 0:26 =3D 0000
>>
>
> With Regards
> Kunal
> 9860384968
>

What is the model of your motherboard ?

The driver on your CD is OSS cmpci driver for Kernel 2.2 or 2.4

But the PCI info only has EV1938


04:01.0 Multimedia audio controller: Creative Labs Ectiva EV1938


04:01.0 0401: 1102:8938
	Subsystem: 1102:5938



!!Linux Distribution
!!------------------

Ubuntu 9.04 \n \l DISTRIB_ID=3DUbuntu DISTRIB_DESCRIPTION=3D"Ubuntu 9.04"

!!DMI Information
!!---------------

Manufacturer:
Product Name:

!!Kernel Information
!!------------------

Kernel release:    2.6.28-16-generic
Operating System:  GNU/Linux
Architecture:      i686
Processor:         unknown
SMP Enabled:       Yes


!!Soundcards recognised by ALSA
!!-----------------------------

 0 [AudioPCI       ]: ENS1371 - Ensoniq AudioPCI
                      Ensoniq AudioPCI ENS1371 at 0xd000, irq 16

!!PCI Soundcards installed in the system
!!--------------------------------------

04:01.0 Multimedia audio controller: Creative Labs Ectiva EV1938

!!Advanced information - PCI Vendor/Device/Susbsystem ID's
!!--------------------------------------------------------

04:01.0 0401: 1102:8938
	Subsystem: 1102:5938

!!Modprobe options (Sound related)
!!--------------------------------

snd-atiixp-modem: index=3D-2
snd-intel8x0m: index=3D-2
snd-via82xx-modem: index=3D-2
snd-usb-audio: index=3D-2
snd-usb-us122l: index=3D-2
snd-usb-usx2y: index=3D-2
snd-usb-caiaq: index=3D-2
snd-cmipci: mpu_port=3D0x330 fm_port=3D0x388
snd-pcsp: index=3D-2
