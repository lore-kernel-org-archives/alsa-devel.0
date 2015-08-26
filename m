From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export
	gic_send_ipi
Date: Wed, 26 Aug 2015 16:41:48 +0100
Message-ID: <55DDDE3C.8030609@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
 <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com>
 <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com>
 <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com>
 <alpine.DEB.2.11.1508261701430.15006@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 04EBB2604F8
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2015 17:41:50 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.11.1508261701430.15006@nanos>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 08/26/2015 04:08 PM, Thomas Gleixner wrote:
> On Wed, 26 Aug 2015, Qais Yousef wrote:
>> On 08/26/2015 02:19 PM, Thomas Gleixner wrote:
>>> Wrong. You cannot move an IPI around with set_affinity. It's possible
>>> to send an IPI to more than one target CPU, but that has nothing to do
>>> with affinities.
>>>
>>> Are you talking about IPIs or about general interrupts which have an
>>> affinity setting?
>> Maybe my view of the world is limited. I wrote this because the mechanism to
>> route an IPI and set affinities is the same.
> That might be the case on your particular platform, but that's not
> generally true.
>
>> So specifying which core or hardware thread should Linux CPU route this IPI to
>> is the same as setting the affinity, no? Linux will not move the IPI that is
>> routed to the coprocessor core. Just the IPI it will receive.
>>
>> Also the way I see it is that this is an external interrupt whether it was
>> asserted by real signal or through IPI mechanism and it should be treated as
>> such in terms of moving inside Linux SMP, no? Again maybe my view of the world
>> is limited but I can't see why migrating the interrupt would affect
>> correctness unless there's a hardware limitation like only core 0 can read
>> info from AXD (which is where my suggestion to using affinity hint above to
>> accommodate such limitations).
>>
>> When you say 'It is possible to send an IPI to more than one target CPU', is
>> it a case we need to cater for? The way I was seeing this problem is
>> communication between single Linux SMP and a single coprocessor unit. I didn't
>> think of it as single to many. Even if the coprocessor is a cluster I'd expect
>> it to act as a single unit like Linux SMP. And if it wanted to send 2
>> different interrupts it will need to use 2 different IPIs.
> You are confusing the terms.
>
> IPI = Inter Processor Interrupt
>
> As the name says that's an interrupt which goes from one cpu to
> another. So an IPI has a very clear target.

OK understood. My interpretation of the processor here was the 
difference. I was viewing the whole linux cpus as one unit with regard 
to its coprocessors.

>
> Whether the platform implements IPIs via general interrupts which are
> made affine to a particular cpu or some other specialized mechanism is
> completely irrelevant. An IPI is not subject to affinity settings,
> period.
>
> So if you want to use an IPI then you need a target cpu for that IPI.
>
> If you want something which can be affined to any cpu, then you need a
> general interrupt and not an IPI.

We are using IPIs to exchange interrupts. Affinity is not important to me.

Thanks,
Qais

>
> That's what I asked before and you still did not answer that question.
>
>>> Are you talking about IPIs or about general interrupts which have an
>>> affinity setting?
> Thanks,
>
> 	tglx
