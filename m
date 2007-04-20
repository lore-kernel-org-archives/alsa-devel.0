From: Rask Ingemann Lambertsen <rask@sygehus.dk>
Subject: Re: [PATCH] PnP: Protocol for Media Vision
	Jazz16	sound cards
Date: Fri, 20 Apr 2007 22:00:07 +0200
Message-ID: <20070420200007.GD3192@sygehus.dk>
References: <20070412195523.GC5324@sygehus.dk> <4628F7FD.7000808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by alsa0.perex.cz (Postfix) with ESMTP id 1995B2468C
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Apr 2007 22:00:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4628F7FD.7000808@gmail.com>
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
Cc: Adam Belay <ambx1@neo.rr.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 20, 2007 at 07:27:25PM +0200, Rene Herman wrote:
> 
> Just got around to giving this a spin again and unfortunately the preffered 
> options code isn't working for me:
> 
> rene@5bt1:~$ cat /sys/bus/pnp/devices/02\:01/options
> Dependent: 01 - Priority preferred
>    port 0x220-0x220, align 0x0, size 0x10, 10-bit address decoding
>    port 0x330-0x330, align 0x0, size 0x2, 10-bit address decoding
>    port 0x388-0x388, align 0x0, size 0x4, 10-bit address decoding
>    irq 5 High-Edge
>    irq 2/9 High-Edge
>    dma 1 8-bit compatible

   Do you have a PCI device like this one? /sbin/lspci -v:

00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 01)
        Flags: medium devsel, IRQ 9

   I don't know who to blame, but I know of no way of moving that device off
of IRQ 9. It may also just be a bug in the PCI code, because lspci -v -b
gives:

00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 01)
        Flags: medium devsel

   I.e. no IRQ as seen from the bus.

-- 
Rask Ingemann Lambertsen
