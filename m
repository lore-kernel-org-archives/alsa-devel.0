From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: M-Audio FastTrack C400
Date: Sun, 29 Apr 2012 08:51:12 +0200
Message-ID: <CAFz=ag6tVjD6hANk2e6sH8hcrbJi6SdqYJNy2U-nkArBV5DVfQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 22B8C24352
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Apr 2012 08:51:12 +0200 (CEST)
Received: by yenl1 with SMTP id l1so1046146yen.38
	for <alsa-devel@alsa-project.org>; Sat, 28 Apr 2012 23:51:12 -0700 (PDT)
In-Reply-To: <4F9CB0D7.5060401@rauros.net>
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

Hi Chris,

2012/4/29 Chris Cavey <chris-alsa@rauros.net>:
> I did some more digging on the mixer setup of the C400 using
> usbmon+tcpdump+wireshark. I'm happy to provide binary captures if it helps.

thanks.


> In 2,0x012a,0x12b,0x012c,0x012d,0x012e,0x012f
> In 3,0x0130,0x0131,,,,0x0135
> In 4,0x0136,0x0137,,,,0x013b

Ok, it seems the controls are organized differently ("flat") than on
the FTUs ("matrix").


> Also captured some sample rate adjustment values
>
> wValue = 0x0100 (always)
> wIndex = 33025
>
> values in the data for the sample rates
> 0x00770100 => 96000
> 0x44ac0000 => 44100
> 0x80bb0000 => 48000
> 0x88580100 => 88200

This seems pretty standard.

Could you please post some usbmon output since I need to know the unit
id and the value range of the controls as well. You can even shorten
those logs by just sending the output of 'grep Co some.log'. It should
look something like this:

ffff88007d9d70c0 3382435826 S Co:1:003:0 s 21 01 0201 0500 0002 2 = 92f3
ffff88007d9d70c0 3382436191 C Co:1:003:0 0 2 >
ffff88007d9d70c0 3382441208 S Co:1:003:0 s 21 01 0101 0500 0002 2 = 92f3
ffff88007d9d70c0 3382441565 C Co:1:003:0 0 2 >
ffff88007d9d70c0 3383137494 S Co:1:003:0 s 21 01 0201 0500 0002 2 = fefc
ffff88007d9d70c0 3383137823 C Co:1:003:0 0 2 >
ffff88007d9d70c0 3383141778 S Co:1:003:0 s 21 01 0101 0500 0002 2 = fefc
ffff88007d9d70c0 3383142070 C Co:1:003:0 0 2 >

(This is changing the volume for Monitor1/2, Input 1 on the FTU).

I don't need a log for every control just the first and last of a kind
would suffice.

Regards,

Felix
