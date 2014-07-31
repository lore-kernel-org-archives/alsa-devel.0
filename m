From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Thu, 31 Jul 2014 21:38:24 +0800
Message-ID: <CAN8cciZ_KT9HG3K3xW-X-PFvWya1zW46JXccq-jd5v6uaeTjOA@mail.gmail.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com>
 <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com>
 <53D1DC0B.1000905@gmail.com>
 <63638.86.107.254.57.1406266836.squirrel@boosthardware.com>
 <CAN8cciboNrRRFBQjX66qud7KoTCqsDHxvFAws9-ywasjemtYbQ@mail.gmail.com>
 <59187.86.107.254.57.1406362728.squirrel@boosthardware.com>
 <CAN8cciax7RreogV0otMdLt0y-dOTrZD3D_ih0doAC9F_XkJ1ew@mail.gmail.com>
 <57315.86.107.254.57.1406609183.squirrel@boosthardware.com>
 <CAN8ccia3mi9G2oyaYyvJx14xu6F8dLhNZ6r0dpraO1F8qeLjBg@mail.gmail.com>
 <55293.86.107.254.57.1406791952.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f54.google.com (mail-qg0-f54.google.com
 [209.85.192.54])
 by alsa0.perex.cz (Postfix) with ESMTP id A02E32607B6
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 15:38:25 +0200 (CEST)
Received: by mail-qg0-f54.google.com with SMTP id z60so3989995qgd.27
 for <alsa-devel@alsa-project.org>; Thu, 31 Jul 2014 06:38:24 -0700 (PDT)
In-Reply-To: <55293.86.107.254.57.1406791952.squirrel@boosthardware.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

http://git.alsa-project.org/?p=alsa.git;a=commitdiff;h=48ed9474fc6724dc1486d30e9a274ab27ec001da;hp=56c640a98975b03a6a78a44b2c01e49dfd7b5263

Have you try the fix ?
>
> >
> > You can use hda-verb GET_PIN_SENSE to test all the pin complex nodes
which
> > pincap support DETECT
> >
>
> I have tried a few attempts but it's pretty confusing.
>
> These ones don't do anything:
>
> # hda-verb /dev/snd/hwC1D0  GET_PIN_SENSE
> # hda-verb /dev/snd/hwC1D0  0x0 GET_PIN_SENSE
>
>
> I don't know what to make of this output:

Bit 31 is PD

VALUE should return 0 when  Jack is UNplugged and 0x80000000 when Jack is
plugged for those pin which support DETECT

>
> # hda-verb /dev/snd/hwC1D0  0x0 GET_PIN_SENSE PIN_CAP
> nid = 0x0, verb = 0xf09, param = 0xc
> value = 0x0
> # hda-verb /dev/snd/hwC0D0  0x0 GET_PIN_SENSE PIN_CAP
> nid = 0x0, verb = 0xf09, param = 0xc
> value = 0x0
> # hda-verb /dev/snd/hwC0D0  0x16 GET_PIN_SENSE PIN_CAP
> nid = 0x16, verb = 0xf09, param = 0xc
> value = 0xffffffff
> # hda-verb /dev/snd/hwC0D0  0x19 GET_PIN_SENSE PIN_CAP
> nid = 0x19, verb = 0xf09, param = 0xc
> value = 0xffffffff
> # hda-verb /dev/snd/hwC0D0  0x1a GET_PIN_SENSE PIN_CAP
> nid = 0x1a, verb = 0xf09, param = 0xc
> value = 0xffffffff
> # hda-verb /dev/snd/hwC0D0  0x1b GET_PIN_SENSE PIN_CAP
> nid = 0x1b, verb = 0xf09, param = 0xc
> value = 0xffffffff
>

But your alc668 is on card 1 , the second hda controller

>
>
> >> > Do surround 2.1 works ?
> >> >
> >>
> >> It says it is working but I do not get sound out of the sub woofer.  I
> >> can
> >> hear static(whitenoise) through the front speakers (with pulseaudio
> >> test)
> >> if  I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
> >> (Center/LFE) or vice versa with hdajackretask.
> >>
> >
> >
http://git.alsa-project.org/?p=alsa-tools.git;a=blob;f=hdajackretask/README;hb=HEAD
> >
> > Did you use apply button(dyanmic reconfiguartion) or installment boot
> > override (early patching) ?
> >
>
> I have tried both options.
>
> After rebooting with the apply option set I don't hear any static or audio
> with the PA test app.
>
> >>
> >> I do not see any controls for the bass volume in alsamixer
> >>
> >>
> >
> >
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=f37bc7a88d374448a1f4bba9267d308606d78bf2
> >
>
> I have checked alsamixer again after the last round of tinkering with
> hdajackretask and" Speaker CLFE" is now showing up but it does not have
> volume control just mute on/off.
>
> I see the following new controls
>
> Speaker CFLE (mute only)
> Speaker Front (mute + vol)
> Speaker Side (mute only)
> Speaker Surround (mute + vol)

hda-jack-retask won't check whether your codec have enough audio output if
you changed all the nodes to speaker

But the driver expect multiout support up to 8 channels when parsing the pin

As alc668 only support 6 channels,  hda_generic.c just assign audio output
and create volume control but Jack detection controls and mute switch are
created according to the number of parsed pins which support Jack detect
and mute switch

Do the headphone still work with pulseaudio since there is no headphone
playback volume and headphone is share SPEAKER FRONT PLAYBAACK VOLUME
control with front speaker ?

>
>
> >> >>
> >> >> >> - I have found a couple of kernel bug reports  for other ASUS
> >> models
> >> >> >> with
> >> >> >> this chipset but they are both marked resolved. Should I open a
> >> new
> >> >> >> ticket
> >> >> >> ?
> >> >> >>
> >> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=65091
> >> >> >> https://bugzilla.kernel.org/show_bug.cgi?id=66271
> >> >> >>
> >> >> >> - I can hear static through the front speakers (with pulseaudio
> > test)
> >> >> >> if
> >> >> >> I set pins 0x19 and 0x1a to Line Out (Center/LFE) and Internal
> >> >> >> (Center/LFE) or vice versa with hdajackretask.
> >> >> >>
> >
> >> > For multi channel, the sequence number is ascending and the driver
> > expect
> >> > they have same type i.e, all speakers or all line out jacks
> >> >
> >
> > Pin Default 0x90170110: [Fixed] Speaker at Int N/A
> >     Conn = Analog, Color = Unknown
> >     DefAssociation = 0x1, Sequence = 0x0
> >     Misc = NO_PRESENCE
> >
> > The rear speaker need  same default association but  sequence number
> > higher than that of the front speaker
> >
> > The external subwoofer may use [jack] speaker with same default
> > association and higher sequence number if it can be detected
> >
> > The driver won't use all of them for multi channel if you retasked it as
> > line out
> >
>
> I have tried several combinations with hdajackretask
>
> I am not able to get audio out of the physical rear speakers or sonic
> master output.
>:
>
> So what do I need to do to write a script that will test all the
> combinations and play audio through them? Or am I missing something that
> someone else has already written for this purpose?
>
> Currently I am using this process:
>
> 1: hdajackretask - modify params
> 2: pulseaudio -k
> 3: hdajackretask : apply settings
> 4: pulseaudio -D
> 5: open PA audio config
> 6: select audio output option and press test speakers button
> 7: manually press every button
>

Use install boot option and reboot to test the driver with
hda-jack-retask.fw patch

Should not use pulseaudio when testing

speaker-test -c2 -t wav -D hw:1,0

speaker-test -c4 -t wav -D hw:1,0

Test 6 channel only after you find both rear speaker and subwoofer

speaker-test -c6 -t wav -D hw:1,0

if the connected retasked pin is not the correct pin
,you can use hda_analyzer to  change the pin ctls of the remaining
unconnected pin to OUT, unmute and coonect the pin to second/third dac
through audio mixers
