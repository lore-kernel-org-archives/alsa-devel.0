From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
Date: Wed, 26 Aug 2015 17:08:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508261701430.15006@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com> <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com> <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55DDD3E3.7070009@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Mark Rutland <Mark.Rutland@arm.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 26 Aug 2015, Qais Yousef wrote:
> On 08/26/2015 02:19 PM, Thomas Gleixner wrote:
> > Wrong. You cannot move an IPI around with set_affinity. It's possible
> > to send an IPI to more than one target CPU, but that has nothing to do
> > with affinities.
> > 
> > Are you talking about IPIs or about general interrupts which have an
> > affinity setting?
> 
> Maybe my view of the world is limited. I wrote this because the mechanism to
> route an IPI and set affinities is the same.

That might be the case on your particular platform, but that's not
generally true.

> So specifying which core or hardware thread should Linux CPU route this IPI to
> is the same as setting the affinity, no? Linux will not move the IPI that is
> routed to the coprocessor core. Just the IPI it will receive.
> 
> Also the way I see it is that this is an external interrupt whether it was
> asserted by real signal or through IPI mechanism and it should be treated as
> such in terms of moving inside Linux SMP, no? Again maybe my view of the world
> is limited but I can't see why migrating the interrupt would affect
> correctness unless there's a hardware limitation like only core 0 can read
> info from AXD (which is where my suggestion to using affinity hint above to
> accommodate such limitations).
> 
> When you say 'It is possible to send an IPI to more than one target CPU', is
> it a case we need to cater for? The way I was seeing this problem is
> communication between single Linux SMP and a single coprocessor unit. I didn't
> think of it as single to many. Even if the coprocessor is a cluster I'd expect
> it to act as a single unit like Linux SMP. And if it wanted to send 2
> different interrupts it will need to use 2 different IPIs.

You are confusing the terms.

IPI = Inter Processor Interrupt

As the name says that's an interrupt which goes from one cpu to
another. So an IPI has a very clear target.

Whether the platform implements IPIs via general interrupts which are
made affine to a particular cpu or some other specialized mechanism is
completely irrelevant. An IPI is not subject to affinity settings,
period.

So if you want to use an IPI then you need a target cpu for that IPI.

If you want something which can be affined to any cpu, then you need a
general interrupt and not an IPI.

That's what I asked before and you still did not answer that question.

> > Are you talking about IPIs or about general interrupts which have an
> > affinity setting?

Thanks,

	tglx
