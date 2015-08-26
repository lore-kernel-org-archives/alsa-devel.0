From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
Date: Wed, 26 Aug 2015 15:19:44 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508261427280.15006@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com> <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55DDA1C4.4070301@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Mark Rutland <Mark.Rutland@arm.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Aug 2015, Qais Yousef wrote:
> Can we replace 'something' in interrupt-source and interrupt-sink definitions
> to 'host' or 'CPU' or do we really care about creating IPI between any 2
> 'things'?
> 
> Changing the definition will also make interrupt-sink a synonym/alias to
> interrupts property. So the description will become
> 
> axd: axd {
>         interrupt-source = <&gic GIC_SHARED 36 IRQ_TYPE_EDGE_RISING>; /*
> interrupt from CPU to AXD */
>         interrupt-sink = <&gic GIC_SHARED 37 IRQ_TYPE_EDGE_RISING>; /*
> interrupt from AXD to CPU */
> }
> 
> But this assume Linux won't take care of the routing. If we want Linux to take
> care of the routing, maybe something like this then?
> 
> axd: axd {
>         interrupt-source = <&gic GIC_SHARED 36 IRQ_TYPE_EDGE_RISING
> HWAFFINITY1>; /* interrupt from CPU to
> AXD@HWAFFINITY1*/
>         interrupt-sink = <&gic GIC_SHARED 37 IRQ_TYPE_EDGE_RISING
> HWAFFINITY2>; /* interrupt from AXD to CPU@HWAFFINITY2 */
> }
> 
> I don't think it's necessary to specify the HWAFFINITY2 for interrupt-sink as
> linux can use SMP affinity to move it around but we can make it optional in
> case there's a need to hardcode it to a specific Linux core. Or maybe the
> driver can use affinity hint..

Wrong. You cannot move an IPI around with set_affinity. It's possible
to send an IPI to more than one target CPU, but that has nothing to do
with affinities.

Are you talking about IPIs or about general interrupts which have an
affinity setting?

> Any pointers on the best way to tie gic_send_ipi() with the driver/core code?
> The way it's currently tied to the core code is through SMP IPI functions
> which I don't think we can use. I'm thinking adding a pointer function in
> struct irq_chip would be the easiest approach maybe?

That's the least of our worries. We need to get the high level
interfaces and the devicetree mechanism straight before we talk about
this kind of details.

Thanks,

	tglx
