From: ramkromberg@mail.com
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Fri, 11 May 2007 18:44:09 +0200
Message-ID: <20070511164410.96BA11BF281@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id 77C5D24428
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 18:44:18 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	D02D618001A6
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 16:44:15 +0000 (GMT)
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
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

o, I thought the epprom settings are default until the
driver kicks in...

So I set the jumpers accordingly and still no luck:
IDESEL: 1-2 (Disabled - Its the CD IDE ON\OFF)
JMPCFG: 1-2 (EPPROM ON)
JMPB0: 1-2 (22XH)
IDEIRQ: 1 (IRQ 15 - shouldn't make a different)
JX1: 2-3 (Carbon MIC - again just letting you know though it shouldn't
make a different)

This should make sense with the picture I sent earlier...
I also removed another card I had connected - ISA Modem, Just making sure
their are no conflicts...

Here's the grim results:

sudo modprobe snd-sb8 port=0x220 irq=5 dma8=1
FATAL: Error inserting snd_sb8
(/lib/modules/2.6.20-15-generic/kernel/sound/isa/sb/snd-sb8.ko): No such
device

P.S: Also an interesting note is that I now installed Win98 on top of
that Dos and it worked too -
It did also mention to use IRQ 11 so I also reserved in the bios, but
again to no avail.

Maybe I'm missing something ?
Ram Kromberg
ramkromberg@mail.com
