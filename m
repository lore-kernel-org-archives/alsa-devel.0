From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export
	gic_send_ipi
Date: Mon, 24 Aug 2015 15:27:01 +0100
Message-ID: <55DB29B5.3010202@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
 <55DB1CD2.5030300@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BF7F2608ED
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2015 16:27:03 +0200 (CEST)
In-Reply-To: <55DB1CD2.5030300@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marc Zyngier <marc.zyngier@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08/24/2015 02:32 PM, Marc Zyngier wrote:
> On 24/08/15 14:02, Qais Yousef wrote:
>> On 08/24/2015 01:49 PM, Thomas Gleixner wrote:
>>> On Mon, 24 Aug 2015, Qais Yousef wrote:
>>>
>>>> Some drivers might require to send ipi to other cores. So export it.
>>> Which IPIs do you need to send from a driver which are not exposed by
>>> the SMP functions already?
>> It's not an SMP IPI. We use GIC to exchange interrupts between AXD and
>> the host system since AXD is another MIPS core in the cluster.
> So is this the case of another CPU in the system that is not under
> control of Linux, but that you need to signal anyway? How do you agree
> on the IPI number between the two systems?

When Linux loads AXD firmware into memory it places the GIC numbers to 
use at a specific offset there as part of the startup protocol. When AXD 
starts running it will see these values and use them to send and receive 
interrupts.

>
>>>> This will be used later by AXD driver.
>>> That smells fishy and it wants a proper explanation WHY and not just a
>>> sloppy statement that it will be used later. I can figure that out
>>> myself as exporting a function without using it does not make any sense.
>> Sorry for the terse explanation. As pointed above AXD uses GIC to send
>> and receive interrupts to the host core. Without this change I can't
>> compile the driver as a driver module because the symbol is not exported.
>>
>> Does this make things clearer?
> To me, it feels like this is yet another case of routing interrupts to
> another agent in the system, which is not a CPU under the kernel's
> control. There is at least two other platforms doing similar craziness
> (a Freescale platform, and at least one Nvidia).
>
> I'd rather see something more "architected" than this blind export, or
> at least some level of filtering (the idea random drivers can access
> such a low-level function doesn't make me feel very good).

I don't know how to architect this better or how to perform  the 
filtering, but I'm happy to hear suggestions and try them out.
Keep in mind that detecting GIC and writing your own gic_send_ipi() is 
very simple. I have done this when the driver was out of tree. So 
restricting it by not exporting it will not prevent someone from really 
accessing the functionality, it's just they have to do it their own way.

Thanks,
Qais

>
> Thanks,
>
> 	M.
