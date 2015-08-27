From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export
	gic_send_ipi
Date: Thu, 27 Aug 2015 10:22:49 +0800
Message-ID: <55DE7479.1010109@linux.intel.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
 <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com>
 <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com>
 <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com>
 <alpine.DEB.2.11.1508261701430.15006@nanos> <55DDDE3C.8030609@imgtec.com>
 <alpine.DEB.2.11.1508262101450.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 828AB26593A
 for <alsa-devel@alsa-project.org>; Thu, 27 Aug 2015 04:22:53 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.11.1508262101450.15006@nanos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Gleixner <tglx@linutronix.de>, Qais Yousef <qais.yousef@imgtec.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 2015/8/27 5:40, Thomas Gleixner wrote:
> But back to the IPIs. We need infrastructure and DT support to:
> 
> 1) reserve an IPI
> 
> 2) send an IPI
> 
> 3) request/free an IPI
> 
> #1 We have no infrastructure for that, but we definitely need one.
> 
>    We can look at the IPI as a single linux irq number which is
>    replicated on all cpu cores. The replication can happen in hardware
>    or by software, but that depends on the underlying root irq
>    controller. How that is implemented does not matter for the
>    reservation.
> 
>    The most flexible and platform independent solution would be to
>    describe the IPI space as a seperate irq domain. In most cases this
>    would be a hierarchical domain stacked on the root irq domain:
> 
>    [IPI-domain] --> [GIC-MIPS-domain]
> 
>    on x86 this would be:
> 
>    [IPI-domain] --> [vector-domain]
> 
>    That needs some change how the IPIs which are used by the kernel
>    (rescheduling, function call ..) are set up, but we get a proper
>    management and collision avoidance that way. Depending on the
>    platform we could actually remove the whole IPI compile time
>    reservation and hand out IPIs at boot time on demand and
>    dynamically.
Hi Thomas,
	Good point:) That will make the code more clear.
Thanks!
Gerry
