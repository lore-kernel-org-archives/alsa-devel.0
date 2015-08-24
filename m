From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
Date: Mon, 24 Aug 2015 17:07:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508241656280.3873@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <55DB1CD2.5030300@arm.com>
 <55DB29B5.3010202@imgtec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55DB29B5.3010202@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Aug 2015, Qais Yousef wrote:
> On 08/24/2015 02:32 PM, Marc Zyngier wrote:
> > I'd rather see something more "architected" than this blind export, or
> > at least some level of filtering (the idea random drivers can access
> > such a low-level function doesn't make me feel very good).
> 
> I don't know how to architect this better or how to perform  the filtering,
> but I'm happy to hear suggestions and try them out.
> Keep in mind that detecting GIC and writing your own gic_send_ipi() is very
> simple. I have done this when the driver was out of tree. So restricting it by
> not exporting it will not prevent someone from really accessing the
> functionality, it's just they have to do it their own way.

Keep in mind that we are not talking about out of tree hackery. We
talk about a kernel code submission and I doubt, that you will get
away with a GIC detection/fiddling burried in your driver code.

Keep in mind that just slapping an export to some random function is
not much better than doing a GIC hack in the driver.

Marcs concerns about blindly exposing IPI functionality to drivers is
well justified and that kind of coprocessor stuff is not unique to
your particular SoC. We're going to see such things more frequently in
the not so distant future, so we better think now about proper
solutions to that problem.

There are a couple of issues to solve:

1) How is the IPI which is received by the coprocessor reserved in the
   system?

2) How is it associated to a particular driver?

3) How do we ensure that a driver cannot issue random IPIs and can
   only send the associated ones?

None of these issues are handled by your export.

So we need a core infrastructure which allows us to do that. The
requirements are pretty clear from the above and Marc might have some
further restrictions in mind.

Thanks,

	tglx
