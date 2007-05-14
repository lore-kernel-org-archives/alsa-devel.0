From: ramkromberg@mail.com
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Mon, 14 May 2007 15:21:04 +0200
Message-ID: <20070514132105.06DF81BF281@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id D6B0824454
	for <alsa-devel@alsa-project.org>;
	Mon, 14 May 2007 15:22:05 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	861F91800D58
	for <alsa-devel@alsa-project.org>; Mon, 14 May 2007 13:22:03 +0000 (GMT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: alsa-devel@alsa-project.org, Rene Herman <rene.herman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Since the only successful modprobe is done with the jumper on SOFTWARE
instead of EPPROM, I'll only tested the following:

Jumper: Software:

sudo modprobe snd-sb8 port=0x220 irq=5 dma8=1
without an error,
dmesg - gives no hint, verbose, mention...

cat /proc/asound/cards:
 0 [Pro            ]: SB Pro - Sound Blaster Pro
Sound Blaster Pro at 0x220, irq 5, dma 1

So I did the following:
cd /proc/asound/
cat *

cat: Pro: Is a directory
cat: card0: Is a directory
 0 [Pro            ]: SB Pro - Sound Blaster Pro
Sound Blaster Pro at 0x220, irq 5, dma 1
2:        : timer
3:        : sequencer
4: [ 0- 0]: raw midi
5: [ 0- 0]: hardware dependent
6: [ 0- 0]: digital audio playback
7: [ 0- 0]: digital audio capture
8: [ 0]   : control
00-00: OPL3 FM
 0 snd_sb8
cat: oss: Is a directory
00-00: SB8 DSP : DSP v3.1 : playback 1 : capture 1
cat: seq: Is a directory
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
Advanced Linux Sound Architecture Driver Version 1.0.14rc1 (Tue Jan 09
09:56:17 2007 UTC).

Thanks for your help,
Ram Kromberg,
ramkromberg@mail.com
