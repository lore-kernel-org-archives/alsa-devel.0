From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: M-Audio FastTrack C400
Date: Sat, 21 Apr 2012 10:10:36 +0200
Message-ID: <CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 157A9248BD
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2012 10:10:37 +0200 (CEST)
Received: by ghbg19 with SMTP id g19so5925054ghb.38
	for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2012 01:10:37 -0700 (PDT)
In-Reply-To: <4F920D73.7070309@rauros.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chris-alsa@rauros.net
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/4/21 Chris Cavey <chris-alsa@rauros.net>:
> The C400 appears to be UAC2 device.

How do you come to this conclusion?


> I copied the FIXED_ENDPOINT quirk descriptor from the FTU and trying to
> slam in workable values

That's a good idea given that the C400 is said to use the same chip as the =
FTU.

>(channels =3D 2, ifnum =3D 2).

Why do you use channels=3D2. As fas as I can tell the device has 6
channels. Try that.


> Except I can't get it to play anything (figure it would all be too good
> to be true)
>
> $ speaker-test -Dfront:C400
> speaker-test 1.0.25
>
> Playback device is front:C400
> Stream parameters are 48000Hz, S16_LE, 1 channels
> Using 16 octaves of pink noise
> Sample format not available for playback: Invalid argument
> Setting of hwparams failed: Invalid argument
>

The device probably supports only S24_3LE audio. At least that's what
you tell Alsa with the FTU quirk. Try to play something through the
corresponding hw device or use Jack or convert some audio file to
S24_3LE and play through aplay etc...

> $ amixer contents
> numid=3D1,iface=3DMIXER,name=3D'PCM Clock Source'
> =A0 ; type=3DENUMERATED,access=3Drw------,values=3D1,items=3D2
> =A0 ; Item #0 'Unit 129'
> =A0 ; Item #1 'Unit 130'
> =A0 : values=3D0
>

That's good. Probably we won't need to implement a custom clock source
switch for this device.

Nevertheless, I'll try to come up with a quirk that might get the
mixer working. Might take a couple of days.

Regards,

Felix
