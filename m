From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Wed, 02 May 2012 16:44:28 -0400
Message-ID: <4FA19CAC.7070704@rauros.net>
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
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173013pub.verizon.net (vms173013pub.verizon.net
	[206.46.173.13]) by alsa0.perex.cz (Postfix) with ESMTP id 18CEA243AC
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2012 22:44:52 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173013.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M3E007N3XM5IWK0@vms173013.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Wed, 02 May 2012 15:44:34 -0500 (CDT)
In-reply-to: <CAFz=ag5HWp-BW4ZyymR7F60ahtzttyoBk6ZwdSRVKBXepHyn1w@mail.gmail.com>
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
Cc: Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I got it to compile just fine - missing paren in the MAX_CHANNEL if, 
duplicate definition of control.

alsamixer shows mixers but the values are all zero and cannot be adjusted.

usbmon captures for effect and any remaining control panel widgets I 
could find

usbmon for adjusting the effects send volume (doesn't matter if which 
output is selected)

ffff8803e1a5b3c0 2382776826 S Co:2:003:0 s 21 01 0100 4201 0002 2 = 03b4
ffff8803e1a5b3c0 2382777292 C Co:2:003:0 0 2 >
ffff8803e1a5b3c0 2385038760 S Co:2:003:0 s 21 01 0101 4201 0002 2 = 0080
ffff8803e1a5b3c0 2385039277 C Co:2:003:0 0 2 >
ffff8803dcb32540 2387392782 S Co:2:003:0 s 21 01 0102 4201 0002 2 = 03b4
ffff8803dcb32540 2387393233 C Co:2:003:0 0 2 >
ffff8803e1bf9f00 2388700780 S Co:2:003:0 s 21 01 0103 4201 0002 2 = e5b7
ffff8803e1bf9f00 2388701259 C Co:2:003:0 0 2 >
ffff8803e1bf9f00 2389689845 S Co:2:003:0 s 21 01 0104 4201 0002 2 = 03b4
ffff8803e1bf9f00 2389690228 C Co:2:003:0 0 2 >
ffff8803e1bf9f00 2390616736 S Co:2:003:0 s 21 01 0105 4201 0002 2 = 03b4
ffff8803e1bf9f00 2390617223 C Co:2:003:0 0 2 >
ffff8803e1bf9f00 2393137750 S Co:2:003:0 s 21 01 0106 4201 0002 2 = 03b4
ffff8803e1bf9f00 2393138194 C Co:2:003:0 0 2 >
ffff8803e1bf9f00 2394557798 S Co:2:003:0 s 21 01 0107 4201 0002 2 = fbb5
ffff8803e1bf9f00 2394558184 C Co:2:003:0 0 2 >
ffff8803e1bf9f00 2395823861 S Co:2:003:0 s 21 01 0108 4201 0002 2 = fbb5
ffff8803e1bf9f00 2395824329 C Co:2:003:0 0 2 >
ffff8803e1bf9f00 2397001750 S Co:2:003:0 s 21 01 0109 4201 0002 2 = 92bb
ffff8803e1bf9f00 2397002168 C Co:2:003:0 0 2 >

changing the effect type:

ffff8803f0c5a000 2643006814 S Co:2:003:0 s 21 01 0200 4301 0001 1 = 00 
(00-08, Room 1 through Echo)
ffff8803f0c5a000 2643007241 C Co:2:003:0 0 1 >

effect duration:

ffff8803e1af5cc0 2695371771 S Co:2:003:0 s 21 01 0400 4301 0002 2 = c81b
ffff8803e1af5cc0 2695372257 C Co:2:003:0 0 2 >

effect feedback:

ffff8803dcb32a80 2711915828 S Co:2:003:0 s 21 01 0500 4301 0001 1 = 23
ffff8803dcb32a80 2711916269 C Co:2:003:0 0 1 >

effect volume:

ffff880400ee8e40 2731234853 S Co:2:003:0 s 21 01 0300 4301 0001 1 = 37
ffff880400ee8e40 2731235264 C Co:2:003:0 0 1 >

overall effect return volume:
ffff8803e1bf9480 2765908779 S Co:2:003:0 s 21 01 013c 4001 0002 2 = d4ff
ffff8803e1bf9480 2765909151 C Co:2:003:0 0 2 >
ffff8803e1bf9480 2765911816 S Co:2:003:0 s 21 01 0143 4001 0002 2 = d4ff
ffff8803e1bf9480 2765912275 C Co:2:003:0 0 2 >

master volume (moved one notch):
ffff8803e1a47e40 2836313798 S Co:2:003:0 s 21 01 0124 4001 0002 2 = d1fc
ffff8803e1a47e40 2836314199 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836316831 S Co:2:003:0 s 21 01 012a 4001 0002 2 = d1fc
ffff8803e1a47e40 2836317296 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836319865 S Co:2:003:0 s 21 01 0130 4001 0002 2 = d1fc
ffff8803e1a47e40 2836320309 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836322759 S Co:2:003:0 s 21 01 0136 4001 0002 2 = d1fc
ffff8803e1a47e40 2836323198 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836325793 S Co:2:003:0 s 21 01 0100 4001 0002 2 = d1fc
ffff8803e1a47e40 2836326172 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836328826 S Co:2:003:0 s 21 01 0106 4001 0002 2 = d1fc
ffff8803e1a47e40 2836329323 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836331783 S Co:2:003:0 s 21 01 010c 4001 0002 2 = d1fc
ffff8803e1a47e40 2836332185 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836334757 S Co:2:003:0 s 21 01 0112 4001 0002 2 = d1fc
ffff8803e1a47e40 2836335172 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836337793 S Co:2:003:0 s 21 01 0118 4001 0002 2 = d1fc
ffff8803e1a47e40 2836338171 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836340827 S Co:2:003:0 s 21 01 011e 4001 0002 2 = d1fc
ffff8803e1a47e40 2836341297 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836343864 S Co:2:003:0 s 21 01 013c 4001 0002 2 = d4ff
ffff8803e1a47e40 2836344296 C Co:2:003:0 0 2 >
ffff880401863300 2836346765 S Co:2:003:0 s 21 01 0125 4001 0002 2 = d1fc
ffff880401863300 2836347168 C Co:2:003:0 0 2 >
ffff880401863300 2836349869 S Co:2:003:0 s 21 01 012b 4001 0002 2 = d1fc
ffff880401863300 2836350293 C Co:2:003:0 0 2 >
ffff880401863300 2836352833 S Co:2:003:0 s 21 01 0131 4001 0002 2 = d1fc
ffff880401863300 2836353294 C Co:2:003:0 0 2 >
ffff880401863300 2836355759 S Co:2:003:0 s 21 01 0137 4001 0002 2 = d1fc
ffff880401863300 2836356167 C Co:2:003:0 0 2 >
ffff8803e1a3ff00 2836358806 S Co:2:003:0 s 21 01 0101 4001 0002 2 = d1fc
ffff8803e1a3ff00 2836359294 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836361795 S Co:2:003:0 s 21 01 0107 4001 0002 2 = d1fc
ffff8803e1a47e40 2836362174 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836364826 S Co:2:003:0 s 21 01 010d 4001 0002 2 = d1fc
ffff8803e1a47e40 2836365295 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836367862 S Co:2:003:0 s 21 01 0113 4001 0002 2 = d1fc
ffff8803e1a47e40 2836368293 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836370756 S Co:2:003:0 s 21 01 0119 4001 0002 2 = d1fc
ffff8803e1a47e40 2836371170 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836373791 S Co:2:003:0 s 21 01 011f 4001 0002 2 = d1fc
ffff8803e1a47e40 2836374169 C Co:2:003:0 0 2 >
ffff8803e1a47e40 2836376830 S Co:2:003:0 s 21 01 0143 4001 0002 2 = d4ff
ffff8803e1a47e40 2836377296 C Co:2:003:0 0 2 >

toggling clock source:

ffff88040087f3c0 2880985746 S Co:2:003:0 s 21 01 0100 8001 0001 1 = 01 
(01 = internal, 02 = external)
ffff88040087f3c0 2880987241 C Co:2:003:0 0 1 >

from mixer control panel "Master Volume Controls" check boxes for 
AnalogOut1/2 and AnalogOut3/4:

ffff8803dcb32e40 3038896784 S Co:2:003:0 s 21 03 0006 2001 0001 1 = 03 
(bit 0 = 1/2, bit 1 = 3/4)
ffff8803dcb32e40 3038897166 C Co:2:003:0 0 1 >

"disable host control" checkbox:

ffff8803e1bf9a80 3137226621 S Co:2:003:0 s 21 03 0000 2001 0001 1 = 02 
(same value regardless of checkbox state)
ffff8803e1bf9a80 3137226993 C Co:2:003:0 0 1 >


On 05/02/2012 06:05 AM, Felix Homann wrote:
> Hi,
>
> thanks for the usbmon logs.
>
> Here's small patch for mixer_quirks.c that might get you *some*
> controls (should be 16 controls). I could not even try to compile this
> at the moment so it might be completely broken ;-)
>
> If you don't hear any sound it would still be a success if you can
> actually control the controls. Please, also take a look at usbmon
> output (grep Co) and see if we really match the corresponding Windows
> messages.
>
> Due to the flat layout of the mixer we can't get more controls within
> the current quirk without a couple of deeper changes in mixer.c. I'm
> hesitating to do something like this without knowing if it's actually
> needed *and* sufficient.
>
> Hence, could you please send usbmon logs of the effect controls.
> Again, I'm only interested in the "Co" lines.
> (If the effect controls extend the flat layout we need to write our
> own get/set functions anyway and there was no need for dealing with
> mixer.c)
>
> Regards,
>
> Felix
