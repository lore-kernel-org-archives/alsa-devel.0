From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: M-Audio FastTrack C400
Date: Sat, 21 Apr 2012 19:19:00 +1000
Message-ID: <CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C8DD248DE
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2012 11:19:01 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so7517780wgb.20
	for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2012 02:19:00 -0700 (PDT)
In-Reply-To: <CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <linuxaudio@showlabor.de>
Cc: alsa-devel@alsa-project.org, chris-alsa@rauros.net
List-Id: alsa-devel@alsa-project.org

> >(channels = 2, ifnum = 2).
>
> Why do you use channels=2. As fas as I can tell the device has 6
> channels. Try that.
>
>
> > Except I can't get it to play anything (figure it would all be too good
> > to be true)
> >
> > $ speaker-test -Dfront:C400
> > speaker-test 1.0.25
> >
> > Playback device is front:C400
> > Stream parameters are 48000Hz, S16_LE, 1 channels
> > Using 16 octaves of pink noise
> > Sample format not available for playback: Invalid argument
> > Setting of hwparams failed: Invalid argument
> >
>
> The device probably supports only S24_3LE audio. At least that's what
> you tell Alsa with the FTU quirk. Try to play something through the
> corresponding hw device or use Jack or convert some audio file to
> S24_3LE and play through aplay etc...
>
>
that's a good point

try speaker-test -D plughw:C400
