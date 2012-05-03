From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: M-Audio FastTrack C400
Date: Thu, 3 May 2012 16:58:24 +0200
Message-ID: <CAFz=ag624FsOhyRSKY=cO5+fZtLhCKMsox4_HhFooor_B5OQ8g@mail.gmail.com>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
	<CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
	<4F9CB0D7.5060401@rauros.net>
	<CAFz=ag6tVjD6hANk2e6sH8hcrbJi6SdqYJNy2U-nkArBV5DVfQ@mail.gmail.com>
	<4F9D4291.6060803@rauros.net>
	<CAFz=ag5HWp-BW4ZyymR7F60ahtzttyoBk6ZwdSRVKBXepHyn1w@mail.gmail.com>
	<4FA19CAC.7070704@rauros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gh0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C74B9104475
	for <alsa-devel@alsa-project.org>;
	Thu,  3 May 2012 16:58:25 +0200 (CEST)
Received: by ghbg19 with SMTP id g19so1983229ghb.38
	for <alsa-devel@alsa-project.org>; Thu, 03 May 2012 07:58:24 -0700 (PDT)
In-Reply-To: <4FA19CAC.7070704@rauros.net>
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
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

2012/5/2 Chris Cavey <chris-alsa@rauros.net>:
> I got it to compile just fine - missing paren in the MAX_CHANNEL if,
> duplicate definition of control.

sorry for the errors.


>
> alsamixer shows mixers but the values are all zero and cannot be adjusted.

Hmm, please do the following:

(0. Switch the device off.)
1. Start usbmon capturing
2. Switch the device on
3. Start alsamixer and select the C400 device

Again, search for Co lines. Is there anything even close to the
control messages you saw on Windows?

>
> usbmon captures for effect and any remaining control panel widgets I could
> find

Thank you. From a quick glimpse they seem almost identical to the FTU,
just using a different interface/unitid. I will try to send another
patch in a couple of days.

BTW, is the clock source switch still there after applying my patch?

Regards,
Felix
