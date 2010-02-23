From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Tue, 23 Feb 2010 12:47:50 +0800
Message-ID: <4f3252891002222047g33ecdb74qce6a997ea5792c0@mail.gmail.com>
References: <20100216233825.GB23623@sirena.org.uk>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
	<4f3252891002201949k48e0208fw40590803ac1a8192@mail.gmail.com>
	<20100221193933.GA31800@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1CB052414B
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 05:47:51 +0100 (CET)
Received: by pwi9 with SMTP id 9so2986516pwi.38
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 20:47:51 -0800 (PST)
In-Reply-To: <20100221193933.GA31800@tango.0pointer.de>
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

2010/2/22 Lennart Poettering <mznyfn@0pointer.de>

> On Sun, 21.02.10 11:49, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
> > The most common onboard audio is HDA so this is not any exceptional cases
> >
> > Those HDA multi streaming  feature are most users wanted in desktop
> > enviornment, are pulseaudio really designed for deskop or just only for
> > notebook and mobile ?
> >
> > The front panel green/pink jack can be used by one application while the
> > rear panel audio jacks can be used to another application for surround or
> > mic for karaoke
>
> I am not entirely convinced that this is really a common case.
>

VT17xx codec already support independent HP mode

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=cdc1784d49258198df600fbc1d37c07d7eee5ed6

**** List of PLAYBACK Hardware Devices ****

card 0: SB [HDA ATI SB], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 1/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
card 0: SB [HDA ATI SB], device 1: VT1708S Digital [VT1708S Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


**** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1



AD1988B 10 channels codec  on my ASUS P5BV  already has 3 capture subdevices

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
  Subdevices: 3/3
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
card 0: Intel [HDA Intel], device 1: AD198x Digital [AD198x Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


http://www.analog.com/en/audiovideo-products/audio-codecs/ad1988b/products/product.html

The AD1988A and AD1988B have 10 DACs and 6 ADCs,
Analog mixer supports recording and playback of signals from multiple
sources

ALC88x

**** List of CAPTURE Hardware Devices ****
card 0: VT82xx [HDA VIA VT82xx], device 0: ALC888 Analog [ALC888 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VT82xx [HDA VIA VT82xx], device 2: ALC888 Analog [ALC888 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0



Do any PA developer has a desktop computer  with HDA audio ?



> But anyway, there is nothing in PA that would limit it to not use
> multiple parallel devices of a sound card at the same time, with the
> exception that ALSA currently has no enumeration API which could
> inform us which uses of the card are exclusive each other and which
> ones are not. PA currently tries to open the sound card in all
> combinations possible, assuming that EBUSY means it found an invalid
> combination. If one day ALSA gains an API that allows figuring out
> which combinations of streams are possible and which ones are not, I
> am happy to reinvestigate the whole issue.
>
> >  Send a game's sound through 5.1 speakers while the Internet chatting
> audio
> > is sent through your headset.
>
> More often than not you'd probably use two seperate cards for that.
>
> > Send a DVD movie with 5.1 audio to a surround sound system in the living
> > room, while you listen to digital music and surf the Web on the PC.
>
> I somehow doubt that this is the most common of use cases we need to
> care about.
>
> > THe point is that PA release/close the device (suspend on idle) , if
> another
> > application using the subdevice 0 before PA resume/reopen, PA will open
> > subdevice 1 and cannot find the correct capture volume control and user
> will
> > complain they cannot record
> >
> > Since PA did not check the subdevice number to find the correct mixer
> > control
>
> I'd certainly check the subdevice id if the smixer API would supply me
> with it.
>

if ( snd_pcm_info_get_subdevices_count(pcm_info) > 1 ) && (
snd_pcm_info_get_subdevices_count(pcm_info) < 8 ))

snd_mixer_selem_id_set_index(sid, snd_pcm_info_get_subdevice(pcm_info));



>
> Lennart
>
>
