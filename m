From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Sat, 28 Apr 2012 23:09:11 -0400
Message-ID: <4F9CB0D7.5060401@rauros.net>
References: <4F8D63F4.1040208@rauros.net>
	<CACckToXF6yW+GzhzJ3zVBKi3e+thwrpDVnFmMCtjQOqePuixZg@mail.gmail.com>
	<4F8DF29B.9090907@rauros.net>
	<CACckToU47usDbT7Cj6DiBNcCQc_4AmxnDJgW07PMALzjv9a52Q@mail.gmail.com>
	<4F8E6CA2.8010005@ladisch.de> <4F8F7213.8070206@rauros.net>
	<4F8FD2A7.60700@ladisch.de> <4F911629.5090704@gmail.com>
	<4F920D73.7070309@rauros.net>
	<CAFz=ag4viHQ-K7qbpCk-G+H3Q8GKe=7-anfOeCy3jhUCYUJ5BQ@mail.gmail.com>
	<CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173011pub.verizon.net (vms173011pub.verizon.net
	[206.46.173.11]) by alsa0.perex.cz (Postfix) with ESMTP id 30585247E1
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Apr 2012 05:09:24 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173011.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M38006F40RC2F30@vms173011.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Sat, 28 Apr 2012 22:09:13 -0500 (CDT)
In-reply-to: <CACckToUVQu=p0ZSaGw-oRn2ASgfQ_Po2im1ha5-yUVeyt7JUaQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

I did some more digging on the mixer setup of the C400 using 
usbmon+tcpdump+wireshark. I'm happy to provide binary captures if it helps.

I adjusted volume on each channel under and arrived at the following. 
Best to consult the C400 manual for screenshots of the interface.

The values listed correspond to the wValue in the URB block. The wIndex 
for all is 16385. Looks like two bytes for values.

Treat this as CSV in any editor and you'll see my table. Omitted numbers 
are sequential based on the other numbers in the row. Out 1-6 are the 
software returns, In 1-4 being the hardware inputs. The top row are the 
6 outputs. For each output it would appears that the routed signal is 
always manipulated in (stereo) pairs - ex. Adjusting volume on software 
return 1 (Out 1) for Analog1/2 will adjust volume on 0x0100 AND 0x0101.

,A1-2 (1),A1-2 (2),A3-4 (3),A3-4 (4),SP (L),SP (R)
Out 1,0x0100,0x0101,,,,0x0105
Out 2,0x0106,0x0107,,,,0x010b
Out 3,0x010c,0x010d,,,,
Out 4,0x0112,0x0113,,,,0x0117
Out 5,0x0118,0x0119,,,,0x011d
Out 6,0x011e,0x011f,,,,0x0123
In 1,0x0124,0x0125,0x0126,0x0127,0x0128,0x0129
In 2,0x012a,0x12b,0x012c,0x012d,0x012e,0x012f
In 3,0x0130,0x0131,,,,0x0135
In 4,0x0136,0x0137,,,,0x013b

Also captured some sample rate adjustment values

wValue = 0x0100 (always)
wIndex = 33025

values in the data for the sample rates
0x00770100 => 96000
0x44ac0000 => 44100
0x80bb0000 => 48000
0x88580100 => 88200

On 4/21/2012 5:19 AM, Grant Diffey wrote:
>
>      >(channels = 2, ifnum = 2).
>
>     Why do you use channels=2. As fas as I can tell the device has 6
>     channels. Try that.
>
>
>      > Except I can't get it to play anything (figure it would all be
>     too good
>      > to be true)
>      >
>      > $ speaker-test -Dfront:C400
>      > speaker-test 1.0.25
>      >
>      > Playback device is front:C400
>      > Stream parameters are 48000Hz, S16_LE, 1 channels
>      > Using 16 octaves of pink noise
>      > Sample format not available for playback: Invalid argument
>      > Setting of hwparams failed: Invalid argument
>      >
>
>     The device probably supports only S24_3LE audio. At least that's what
>     you tell Alsa with the FTU quirk. Try to play something through the
>     corresponding hw device or use Jack or convert some audio file to
>     S24_3LE and play through aplay etc...
>
>
> that's a good point
>
> try speaker-test -D plughw:C400
>
>
