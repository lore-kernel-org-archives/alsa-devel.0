From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export
	gic_send_ipi
Date: Mon, 24 Aug 2015 14:02:35 +0100
Message-ID: <55DB15EB.3090109@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E1EB32606FC
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 15:02:36 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.11.1508241447100.3873@nanos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-mips@linux-mips.org, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 08/24/2015 01:49 PM, Thomas Gleixner wrote:
> On Mon, 24 Aug 2015, Qais Yousef wrote:
>
>> Some drivers might require to send ipi to other cores. So export it.
> Which IPIs do you need to send from a driver which are not exposed by
> the SMP functions already?

It's not an SMP IPI. We use GIC to exchange interrupts between AXD and 
the host system since AXD is another MIPS core in the cluster.

>> This will be used later by AXD driver.
> That smells fishy and it wants a proper explanation WHY and not just a
> sloppy statement that it will be used later. I can figure that out
> myself as exporting a function without using it does not make any sense.

Sorry for the terse explanation. As pointed above AXD uses GIC to send 
and receive interrupts to the host core. Without this change I can't 
compile the driver as a driver module because the symbol is not exported.

Does this make things clearer?

Thanks,
Qais

>
> Thanks,
>
> 	tglx
