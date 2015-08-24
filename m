From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
Date: Mon, 24 Aug 2015 14:32:02 +0100
Message-ID: <55DB1CD2.5030300@arm.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55DB15EB.3090109@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Qais Yousef <qais.yousef@imgtec.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

On 24/08/15 14:02, Qais Yousef wrote:
> On 08/24/2015 01:49 PM, Thomas Gleixner wrote:
>> On Mon, 24 Aug 2015, Qais Yousef wrote:
>>
>>> Some drivers might require to send ipi to other cores. So export it.
>> Which IPIs do you need to send from a driver which are not exposed by
>> the SMP functions already?
> 
> It's not an SMP IPI. We use GIC to exchange interrupts between AXD and 
> the host system since AXD is another MIPS core in the cluster.

So is this the case of another CPU in the system that is not under
control of Linux, but that you need to signal anyway? How do you agree
on the IPI number between the two systems?

>>> This will be used later by AXD driver.
>> That smells fishy and it wants a proper explanation WHY and not just a
>> sloppy statement that it will be used later. I can figure that out
>> myself as exporting a function without using it does not make any sense.
> 
> Sorry for the terse explanation. As pointed above AXD uses GIC to send 
> and receive interrupts to the host core. Without this change I can't 
> compile the driver as a driver module because the symbol is not exported.
> 
> Does this make things clearer?

To me, it feels like this is yet another case of routing interrupts to
another agent in the system, which is not a CPU under the kernel's
control. There is at least two other platforms doing similar craziness
(a Freescale platform, and at least one Nvidia).

I'd rather see something more "architected" than this blind export, or
at least some level of filtering (the idea random drivers can access
such a low-level function doesn't make me feel very good).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
