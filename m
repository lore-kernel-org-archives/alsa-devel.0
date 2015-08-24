From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export
	gic_send_ipi
Date: Mon, 24 Aug 2015 16:55:33 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508241653200.3873@nanos>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from Galois.linutronix.de (www.linutronix.de [62.245.132.108])
 by alsa0.perex.cz (Postfix) with ESMTP id 34BBF2608ED
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 16:56:02 +0200 (CEST)
In-Reply-To: <55DB15EB.3090109@imgtec.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Qais Yousef <qais.yousef@imgtec.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 24 Aug 2015, Qais Yousef wrote:
> On 08/24/2015 01:49 PM, Thomas Gleixner wrote:
> > On Mon, 24 Aug 2015, Qais Yousef wrote:
> > 
> > > Some drivers might require to send ipi to other cores. So export it.
> > Which IPIs do you need to send from a driver which are not exposed by
> > the SMP functions already?
> 
> It's not an SMP IPI. We use GIC to exchange interrupts between AXD and the
> host system since AXD is another MIPS core in the cluster.

So that should have been in the changelog to begin with.
 
> > > This will be used later by AXD driver.
> > That smells fishy and it wants a proper explanation WHY and not just a
> > sloppy statement that it will be used later. I can figure that out
> > myself as exporting a function without using it does not make any sense.
> 
> Sorry for the terse explanation. As pointed above AXD uses GIC to send and
> receive interrupts to the host core. Without this change I can't compile the
> driver as a driver module because the symbol is not exported.

Really? Exporting it solves that problem then. That's interesting news
for me.

Thanks,

	tglx
