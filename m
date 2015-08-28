From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
Date: Fri, 28 Aug 2015 16:22:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508281619311.15006@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com> <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com> <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com> <alpine.DEB.2.11.1508261701430.15006@nanos>
 <55DDDE3C.8030609@imgtec.com> <alpine.DEB.2.11.1508262101450.15006@nanos> <55E03A2B.3070805@imgtec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55E03A2B.3070805@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Mark Rutland <Mark.Rutland@arm.com>, Jiang Liu <jiang.liu@linux.intel.com>, Mark Brown <broonie@kernel.org>, Lisa Parratt <Lisa.Parratt@imgtec.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 28 Aug 2015, Qais Yousef wrote:
> Thanks a lot for the detailed explanation. I wasn't looking for a quick and
> dirty solution but my view of the problem is much simpler than yours so my
> idea of a solution would look quick and dirty. I have a better appreciation of
> the problem now and a way to approach it :-)
> 
> From DT point of view are we OK with this form then
> 
>     coprocessor {
>             interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
>             interrupt-sink = <&intc INT_SPEC CPU_HWAFFINITY>;
>     }
> 
> and if the root controller sends normal IPI as it sends normal device
> interrupts then interrupt-sink can be a standard interrupts property (like in
> my case)
> 
>     coprocessor {
>             interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
>             interrupts = <INT_SPEC>;
>     }
> 
> Does this look right to you? Is there something else that needs to be covered
> still?

I'm not an DT wizard. I leave that to the DT experts.
 
> One more thing I can think of now is that the coprocessor will need the raw
> irq numbers that are picked by linux so that it can use them to trigger the
> IPI. Are we ok to add a function that returns this raw irq number (as opposed
> to linux irq number) directly from DT? The way this is communicated to the
> coprocessor will be platform specific.

Why do you want that to be hacked into DT? 

> >     To configure your coprocessor proper, we need a translation
> >     mechanism from the linux interrupt number to the magic value which
> >     needs to be written into the trigger register when the coprocessor
> >     wants to send an interrupt or an IPI.
> > 
> >     int irq_get_irq_hwcfg(unsigned int irq, struct irq_hwcfg *cfg);
> > 
> >     struct irq_hwcfg needs to be defined, but it might look like this:
> > 
> >       {
> > 	/* Generic fields */
> > 	x;
> > 	...
> > 	union {
> > 	      mips_gic;
> > 	      ...
> > 	};
> >       };

That function provides you the information which you have to hand over
to your coprocessor firmware.

Thanks,

	tglx
