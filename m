From: Chris Cavey <chris-alsa@rauros.net>
Subject: Re: M-Audio FastTrack C400
Date: Sun, 29 Apr 2012 09:30:57 -0400
Message-ID: <4F9D4291.6060803@rauros.net>
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
Reply-To: chris-alsa@rauros.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vms173013pub.verizon.net (vms173013pub.verizon.net
	[206.46.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id E8B46103B5C
	for <alsa-devel@alsa-project.org>;
	Sun, 29 Apr 2012 15:31:20 +0200 (CEST)
Received: from rauros.net ([unknown] [74.107.69.179])
	by vms173013.mailsrvcs.net
	(Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16
	2009)) with ESMTPA id <0M3800322TJM3RE0@vms173013.mailsrvcs.net> for
	alsa-devel@alsa-project.org; Sun, 29 Apr 2012 08:31:03 -0500 (CDT)
In-reply-to: <CAFz=ag6tVjD6hANk2e6sH8hcrbJi6SdqYJNy2U-nkArBV5DVfQ@mail.gmail.com>
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

Performing these operations on other channels results in the same values 
just different wValues per channel as a I listed in the previous message

toggling mute on software return 1 (centered), analog out 1/2

ffff8804046af840 3934536050 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 0080
ffff8804046af840 3934536518 C Co:2:003:0 0 2 >
ffff8804046af840 3934538968 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 0080
ffff8804046af840 3934539372 C Co:2:003:0 0 2 >
ffff8804046af840 3935031971 S Co:2:003:0 s 21 01 0100 4001 0002 2 = fefc
ffff8804046af840 3935032367 C Co:2:003:0 0 2 >
ffff8804046af840 3935034996 S Co:2:003:0 s 21 01 0101 4001 0002 2 = fefc
ffff8804046af840 3935035368 C Co:2:003:0 0 2 >

toggling mute on software return 1 (hard left pan), analog out 1/2

ffff88034f6af240 4014847999 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 0080
ffff88034f6af240 4014848445 C Co:2:003:0 0 2 >
ffff8803e08b8840 4015764061 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 0000
ffff8803e08b8840 4015764455 C Co:2:003:0 0 2 >

toggling mute on software return 1 (hard right pan), analog out 1/2

ffff8803e0948300 4039205995 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 0080
ffff8803e0948300 4039206407 C Co:2:003:0 0 2 >
ffff8804047eb540 4039862082 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 0000
ffff8804047eb540 4039862528 C Co:2:003:0 0 2 >

volume slider starting at max(0db) sliding down on software return 1 
(centered), analog out 1/2
ffff880348410600 4093231001 S Co:2:003:0 s 21 01 0100 4001 0002 2 = cffc
ffff880348410600 4093231440 C Co:2:003:0 0 2 >
ffff880348410600 4093234037 S Co:2:003:0 s 21 01 0101 4001 0002 2 = cffc
ffff880348410600 4093234440 C Co:2:003:0 0 2 >
ffff880348412540 4093274051 S Co:2:003:0 s 21 01 0100 4001 0002 2 = a1fc
ffff880348412540 4093274567 C Co:2:003:0 0 2 >
ffff8803485e2240 4093276987 S Co:2:003:0 s 21 01 0101 4001 0002 2 = a1fc
ffff8803485e2240 4093277440 C Co:2:003:0 0 2 >
ffff8803485e1e40 4094062031 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 71fc
ffff8803485e1e40 4094062409 C Co:2:003:0 0 2 >
ffff8803485e1e40 4094065065 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 71fc
ffff8803485e1e40 4094065533 C Co:2:003:0 0 2 >
ffff8803485e2b40 4094116974 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 42fc
ffff8803485e2b40 4094117408 C Co:2:003:0 0 2 >
ffff8803485e2b40 4094120025 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 42fc
ffff8803485e2b40 4094120408 C Co:2:003:0 0 2 >
ffff880348412cc0 4095241073 S Co:2:003:0 s 21 01 0100 4001 0002 2 = e1fb
ffff880348412cc0 4095241552 C Co:2:003:0 0 2 >
ffff880348412cc0 4095243963 S Co:2:003:0 s 21 01 0101 4001 0002 2 = e1fb
ffff880348412cc0 4095244427 C Co:2:003:0 0 2 >

volume slider starting at max(0db) sliding down on software return 1 
(hard left pan), analog out 1/2
ffff8803484109c0 58930083 S Co:2:003:0 s 21 01 0100 4001 0002 2 = d2ff
ffff8803484109c0 58930493 C Co:2:003:0 0 2 >
ffff8803484109c0 59022034 S Co:2:003:0 s 21 01 0100 4001 0002 2 = a3ff
ffff8803484109c0 59022492 C Co:2:003:0 0 2 >
ffff8803484103c0 59660057 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 74ff
ffff8803484103c0 59660515 C Co:2:003:0 0 2 >
ffff8803484103c0 59668011 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 44ff
ffff8803484103c0 59668502 C Co:2:003:0 0 2 >
ffff8803484103c0 59698056 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 14ff
ffff8803484103c0 59698514 C Co:2:003:0 0 2 >
ffff880404f83840 59762997 S Co:2:003:0 s 21 01 0100 4001 0002 2 = e4fe
ffff880404f83840 59763488 C Co:2:003:0 0 2 >
ffff8803e4dc3600 59859000 S Co:2:003:0 s 21 01 0100 4001 0002 2 = b3fe
ffff8803e4dc3600 59859486 C Co:2:003:0 0 2 >

volume slider starting at max(0db) sliding down on software return 1 
(hard right pan), analog out 1/2
ffff8803e09e1000 92304977 S Co:2:003:0 s 21 01 0101 4001 0002 2 = d2ff
ffff8803e09e1000 92305391 C Co:2:003:0 0 2 >
ffff8803e09e1000 92349071 S Co:2:003:0 s 21 01 0101 4001 0002 2 = a3ff
ffff8803e09e1000 92349516 C Co:2:003:0 0 2 >
ffff8803e45d1240 92386949 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 74ff
ffff8803e45d1240 92387390 C Co:2:003:0 0 2 >
ffff8803e0999d80 92720056 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 44ff
ffff8803e0999d80 92720540 C Co:2:003:0 0 2 >
ffff88040069a540 92806078 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 14ff
ffff88040069a540 92806512 C Co:2:003:0 0 2 >
ffff8803e47e16c0 92970046 S Co:2:003:0 s 21 01 0101 4001 0002 2 = e4fe
ffff8803e47e16c0 92970538 C Co:2:003:0 0 2 >
ffff8803f1b47900 93019042 S Co:2:003:0 s 21 01 0101 4001 0002 2 = b3fe
ffff8803f1b47900 93019528 C Co:2:003:0 0 2 >
ffff8803e0999cc0 93057231 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 82fe
ffff8803e0999cc0 93057646 C Co:2:003:0 0 2 >
ffff8803f1b47480 93149025 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 50fe
ffff8803f1b47480 93149509 C Co:2:003:0 0 2 >

adjusting pan starting at center and volume max(0db) going left on 
software return 1 (hard right pan), analog out 1/2
ffff8803f1adda80 168635963 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 0bfd
ffff8803f1adda80 168636396 C Co:2:003:0 0 2 >
ffff8803f1adda80 168638996 S Co:2:003:0 s 21 01 0101 4001 0002 2 = f0fc
ffff8803f1adda80 168639395 C Co:2:003:0 0 2 >
ffff8803f1adda80 168646993 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 26fd
ffff8803f1adda80 168647380 C Co:2:003:0 0 2 >
ffff8803485e1d80 168649992 S Co:2:003:0 s 21 01 0101 4001 0002 2 = d4fc
ffff8803485e1d80 168650382 C Co:2:003:0 0 2 >
ffff88034843d480 168664021 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 40fd
ffff88034843d480 168664494 C Co:2:003:0 0 2 >
ffff88034843d480 168667043 S Co:2:003:0 s 21 01 0101 4001 0002 2 = b8fc
ffff88034843d480 168667493 C Co:2:003:0 0 2 >
ffff8803485e1780 168699997 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 71fd
ffff8803485e1780 168700367 C Co:2:003:0 0 2 >
ffff8803485e1780 168703030 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 7dfc
ffff8803485e1780 168703490 C Co:2:003:0 0 2 >

adjusting pan starting at center and volume max(0db) going right on 
software return 1 (hard right pan), analog out 1/2
ffff8804004789c0 199900005 S Co:2:003:0 s 21 01 0100 4001 0002 2 = d4fc
ffff8804004789c0 199900407 C Co:2:003:0 0 2 >
ffff8804004789c0 199903042 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 26fd
ffff8804004789c0 199903406 C Co:2:003:0 0 2 >
ffff8804004789c0 199947000 S Co:2:003:0 s 21 01 0100 4001 0002 2 = b8fc
ffff8804004789c0 199947406 C Co:2:003:0 0 2 >
ffff8804004789c0 199950033 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 40fd
ffff8804004789c0 199950406 C Co:2:003:0 0 2 >
ffff8804004789c0 200613069 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 9bfc
ffff8804004789c0 200613527 C Co:2:003:0 0 2 >
ffff8804004789c0 200615964 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 59fd
ffff8804004789c0 200616413 C Co:2:003:0 0 2 >
ffff8804004789c0 200638078 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 7dfc
ffff8804004789c0 200638526 C Co:2:003:0 0 2 >
ffff8804004789c0 200640977 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 71fd
ffff8804004789c0 200641400 C Co:2:003:0 0 2 >
ffff8804004789c0 200700977 S Co:2:003:0 s 21 01 0100 4001 0002 2 = 5efc
ffff8804004789c0 200701401 C Co:2:003:0 0 2 >
ffff8804004789c0 200704023 S Co:2:003:0 s 21 01 0101 4001 0002 2 = 89fd
ffff8804004789c0 200704400 C Co:2:003:0 0 2 >


On 04/29/2012 02:51 AM, Felix Homann wrote:
> Hi Chris,
>
> 2012/4/29 Chris Cavey<chris-alsa@rauros.net>:
>> I did some more digging on the mixer setup of the C400 using
>> usbmon+tcpdump+wireshark. I'm happy to provide binary captures if it helps.
> thanks.
>
>
>> In 2,0x012a,0x12b,0x012c,0x012d,0x012e,0x012f
>> In 3,0x0130,0x0131,,,,0x0135
>> In 4,0x0136,0x0137,,,,0x013b
> Ok, it seems the controls are organized differently ("flat") than on
> the FTUs ("matrix").
>
>
>> Also captured some sample rate adjustment values
>>
>> wValue = 0x0100 (always)
>> wIndex = 33025
>>
>> values in the data for the sample rates
>> 0x00770100 =>  96000
>> 0x44ac0000 =>  44100
>> 0x80bb0000 =>  48000
>> 0x88580100 =>  88200
> This seems pretty standard.
>
> Could you please post some usbmon output since I need to know the unit
> id and the value range of the controls as well. You can even shorten
> those logs by just sending the output of 'grep Co some.log'. It should
> look something like this:
>
> ffff88007d9d70c0 3382435826 S Co:1:003:0 s 21 01 0201 0500 0002 2 = 92f3
> ffff88007d9d70c0 3382436191 C Co:1:003:0 0 2>
> ffff88007d9d70c0 3382441208 S Co:1:003:0 s 21 01 0101 0500 0002 2 = 92f3
> ffff88007d9d70c0 3382441565 C Co:1:003:0 0 2>
> ffff88007d9d70c0 3383137494 S Co:1:003:0 s 21 01 0201 0500 0002 2 = fefc
> ffff88007d9d70c0 3383137823 C Co:1:003:0 0 2>
> ffff88007d9d70c0 3383141778 S Co:1:003:0 s 21 01 0101 0500 0002 2 = fefc
> ffff88007d9d70c0 3383142070 C Co:1:003:0 0 2>
>
> (This is changing the volume for Monitor1/2, Input 1 on the FTU).
>
> I don't need a log for every control just the first and last of a kind
> would suffice.
>
> Regards,
>
> Felix
