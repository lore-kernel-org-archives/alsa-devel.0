From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] PnP: Protocol for Media Vision Jazz16
 sound cards
Date: Fri, 20 Apr 2007 19:27:25 +0200
Message-ID: <4628F7FD.7000808@gmail.com>
References: <20070412195523.GC5324@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 060602466F
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2007 19:29:29 +0200 (CEST)
In-Reply-To: <20070412195523.GC5324@sygehus.dk>
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
Cc: Adam Belay <ambx1@neo.rr.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 04/12/2007 09:55 PM, Rask Ingemann Lambertsen wrote:

>  - Add code to detect and PnP protocol to manage Media Vision Jazz16 sound
>    cards.
> 
> Tested with a Jazz16 based sound card and Linux 2.6.20.6.

Just got around to giving this a spin again and unfortunately the preffered 
options code isn't working for me:

rene@5bt1:~$ cat /sys/bus/pnp/devices/02\:01/options
Dependent: 01 - Priority preferred
    port 0x220-0x220, align 0x0, size 0x10, 10-bit address decoding
    port 0x330-0x330, align 0x0, size 0x2, 10-bit address decoding
    port 0x388-0x388, align 0x0, size 0x4, 10-bit address decoding
    irq 5 High-Edge
    irq 2/9 High-Edge
    dma 1 8-bit compatible
Dependent: 02 - Priority acceptable
    port 0x210-0x260, align 0xf, size 0x10, 10-bit address decoding
    port 0x300-0x330, align 0xf, size 0x2, 10-bit address decoding
    port 0x388-0x388, align 0x0, size 0x4, 10-bit address decoding
    irq 3,5,7,2/9,10,15 High-Edge
    irq 3,5,7,2/9,10,15 High-Edge
    dma 1,3,5,7 8-bit&16-bit compatible
Dependent: 03 - Priority acceptable
    port 0x210-0x260, align 0xf, size 0x10, 10-bit address decoding
    port 0x300-0x330, align 0xf, size 0x2, 10-bit address decoding
    port 0x388-0x388, align 0x0, size 0x4, 10-bit address decoding
    irq 3,5,7,2/9,10,15 High-Edge
    dma 1,3,5,7 8-bit&16-bit compatible
rene@5bt1:~$ cat /sys/bus/pnp/devices/02\:01/resources
state = disabled
rene@5bt1:~$ su -c "modprobe snd-jazz16"
rene@5bt1:~$ cat /sys/bus/pnp/devices/02\:01/resources
state = active
io 0x210-0x21f
io 0x300-0x301
io 0x388-0x38b
irq 5
irq 7
dma 1

Ports 210 and 300 are first from the acceptables, not the preferreds and the 
irq 7 is also not preffered for MPU. Yes, ports 220, 330 and irq 9 are free.

Looking back through what I sent earlier, I see I sent you a wrong patch 
then so I'm not sure anymore what I tested and I don't have time to look at 
it now. Thought I'd let you know though.

Rene.
