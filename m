From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Testing/Debugging alc668 with ASUS N750JK
Date: Fri, 1 Aug 2014 15:19:56 +0800
Message-ID: <CAN8cciYrj25NfmjD86ndzJd5r=D0bMNHE55JuEKichznAkAUHA@mail.gmail.com>
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
 <CAN8cciZ_KT9HG3K3xW-X-PFvWya1zW46JXccq-jd5v6uaeTjOA@mail.gmail.com>
 <59490.86.107.254.57.1406831144.squirrel@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f45.google.com (mail-qa0-f45.google.com
 [209.85.216.45])
 by alsa0.perex.cz (Postfix) with ESMTP id E96DF2607B6
 for <alsa-devel@alsa-project.org>; Fri,  1 Aug 2014 09:19:59 +0200 (CEST)
Received: by mail-qa0-f45.google.com with SMTP id cm18so3485300qab.18
 for <alsa-devel@alsa-project.org>; Fri, 01 Aug 2014 00:19:57 -0700 (PDT)
In-Reply-To: <59490.86.107.254.57.1406831144.squirrel@boosthardware.com>
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

> >
http://git.alsa-project.org/?p=alsa.git;a=commitdiff;h=48ed9474fc6724dc1486d30e9a274ab27ec001da;hp=56c640a98975b03a6a78a44b2c01e49dfd7b5263
> >
> > Have you try the fix ?
> >>
>
> I did not see that update.
>
> run.py works now without any modifications on this machine.
>
> I have generated a graph.
>
> http://boosthardware.com/hda_graph-1.png
>

>
> >> >
> >> > You can use hda-verb GET_PIN_SENSE to test all the pin complex nodes
> > which
> >> > pincap support DETECT
> >> >
> >>
> >> I have tried a few attempts but it's pretty confusing.
> >>
> >> These ones don't do anything:
> >>
> >> # hda-verb /dev/snd/hwC1D0  GET_PIN_SENSE
> >> # hda-verb /dev/snd/hwC1D0  0x0 GET_PIN_SENSE
> >>
> >>
> >> I don't know what to make of this output:
> >
> > Bit 31 is PD
> >
> > VALUE should return 0 when  Jack is UNplugged and 0x80000000 when Jack
is
> > plugged for those pin which support DETECT
> >
> >
> > But your alc668 is on card 1 , the second hda controller
> >
>
> Sorry. Missed that one.
>
> # hda-verb /dev/snd/hwC1D0  0x16 GET_PIN_SENSE PIN_CAP
> nid = 0x16, verb = 0xf09, param = 0xc
> value = 0x0
> # hda-verb /dev/snd/hwC1D0  0x19 GET_PIN_SENSE PIN_CAP
> nid = 0x19, verb = 0xf09, param = 0xc
> value = 0x0
> # hda-verb /dev/snd/hwC1D0  0x11a GET_PIN_SENSE PIN_CAP
> invalid nid 0x11a
> # hda-verb /dev/snd/hwC1D0  0x1a GET_PIN_SENSE PIN_CAP
> nid = 0x1a, verb = 0xf09, param = 0xc
> value = 0x0
> # hda-verb /dev/snd/hwC1D0  0x1b GET_PIN_SENSE PIN_CAP
> nid = 0x1b, verb = 0xf09, param = 0xc
> value = 0x0
>
>

Do you mean the plugging of subwoofer cannot be detected

hda-jack-sense-test -c 1 -a

> >> I see the following new controls
> >>
> >> Speaker CFLE (mute only)
> >> Speaker Front (mute + vol)
> >> Speaker Side (mute only)
> >> Speaker Surround (mute + vol)
> >
> > hda-jack-retask won't check whether your codec have enough audio output
if
> > you changed all the nodes to speaker
> >
> > But the driver expect multiout support up to 8 channels when parsing the
> > pin
> >
> > As alc668 only support 6 channels,  hda_generic.c just assign audio
output
> > and create volume control but Jack detection controls and mute switch
are
> > created according to the number of parsed pins which support Jack detect
> > and mute switch
> >
> > Do the headphone still work with pulseaudio since there is no headphone
> > playback volume and headphone is share SPEAKER FRONT PLAYBAACK VOLUME
> > control with front speaker ?
> >
>
> With speaker-test I can hear audio on the right channel
>
> speaker-test -c2 -t wav -D hw:1,0
>
> audio comes out of front left/right
>
> speaker-test -c4 -t wav -D hw:1,0
>
> front left/right has no audio
> rear left/right audio comes out of front left/right speakers
>
> # speaker-test -c6 -t wav -D hw:1,0
>
> speaker-test 1.0.28
>
> Playback device is hw:1,0
> Stream parameters are 48000Hz, S16_LE, 6 channels
> WAV file(s)
> Channels count (6) not available for playbacks: Invalid argument
> Setting of hwparams failed: Invalid argument
>

The graph don't contain enough into for debugg

Post output of alsa-info.sh after retasked

Seem headphone is more important than multichannel speaker when evaluating
the badness of config

You may need to configure alsa driver --with-debug=verbose to produce more
information in system log about how it evaluate the badness
