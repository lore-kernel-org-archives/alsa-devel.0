From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export
	gic_send_ipi
Date: Wed, 2 Sep 2015 11:48:44 +0100
Message-ID: <55E6D40C.5060708@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
 <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com>
 <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com>
 <55DB1CD2.5030300@arm.com> <55DB29B5.3010202@imgtec.com>
 <alpine.DEB.2.11.1508241656280.3873@nanos> <55DB48C9.7010508@imgtec.com>
 <55DB519D.2090203@arm.com> <55DDA1C4.4070301@imgtec.com>
 <alpine.DEB.2.11.1508261427280.15006@nanos> <55DDD3E3.7070009@imgtec.com>
 <alpine.DEB.2.11.1508261701430.15006@nanos> <55DDDE3C.8030609@imgtec.com>
 <alpine.DEB.2.11.1508262101450.15006@nanos> <55E03A2B.3070805@imgtec.com>
 <alpine.DEB.2.11.1508281619311.15006@nanos> <55E6C250.50100@imgtec.com>
 <55E6C788.2000405@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id EC6902604DD
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2015 12:48:45 +0200 (CEST)
In-Reply-To: <55E6C788.2000405@arm.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <Mark.Rutland@arm.com>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Jason Cooper <jason@lakedaemon.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lisa Parratt <Lisa.Parratt@imgtec.com>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiang Liu <jiang.liu@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 09/02/2015 10:55 AM, Marc Zyngier wrote:
> On 02/09/15 10:33, Qais Yousef wrote:
>> On 08/28/2015 03:22 PM, Thomas Gleixner wrote:
>>> On Fri, 28 Aug 2015, Qais Yousef wrote:
>>>> Thanks a lot for the detailed explanation. I wasn't looking for a quick and
>>>> dirty solution but my view of the problem is much simpler than yours so my
>>>> idea of a solution would look quick and dirty. I have a better appreciation of
>>>> the problem now and a way to approach it :-)
>>>>
>>>>   From DT point of view are we OK with this form then
>>>>
>>>>       coprocessor {
>>>>               interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
>>>>               interrupt-sink = <&intc INT_SPEC CPU_HWAFFINITY>;
>>>>       }
>>>>
>>>> and if the root controller sends normal IPI as it sends normal device
>>>> interrupts then interrupt-sink can be a standard interrupts property (like in
>>>> my case)
>>>>
>>>>       coprocessor {
>>>>               interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
>>>>               interrupts = <INT_SPEC>;
>>>>       }
>>>>
>>>> Does this look right to you? Is there something else that needs to be covered
>>>> still?
>>> I'm not an DT wizard. I leave that to the DT experts.
>>>    
>> Hi Marc Zyngier, Mark Rutland,
>>
>> Any comments about the DT binding for the IPIs?
>>
>> To recap, the proposal which is based on Marc Zyngier's is to use
>> interrupt-source to represent an IPI from Linux CPU to a coprocessor and
>> interrupt-sink to receive an IPI from coprocessor to Linux CPU.
>> Hopefully the description above is self explanatory. Please let me know
>> if you need more info. Thomas covered the routing, synthesising, and
>> requesting parts in the core code. The remaining (high level) issue is
>> how to describe the IPIs in DT.
> I'm definitely *not* a DT expert! ;-) My initial binding proposal was
> only for wired interrupts, not for IPIs. There is definitely some common
> aspects, except for one part:
>
> Who decides on the IPI number? So far, we've avoided encoding IPI
> numbers in the DT just like we don't encode MSIs, because they are
> programmable things. My feeling is that we shouldn't put the IPI number
> in the DT because the rest of the kernel uses them as well and could
> decide to use this particular IPI number for its own use: *clash*.

I think this is covered in Thomas proposal to reserve IPIs. His thoughts 
is to use a separate irq-domain for IPIs and use irq_reserve_ipi() and 
irq_destroy_ipi() to get and release IPIs.

>
> The way I see it would be to have a pool of IPI numbers that the kernel
> requests for its own use first, leaving whatever remains to drivers.

That's what Thomas thinks too and he covered this by using 
irq_reserve_ipi() and irq_destroy_ipi().

     https://lkml.org/lkml/2015/8/26/713

It's worth noting in the light of this that INT_SPEC should be optional 
since for hardware similar to mine there's not much to tell the 
controller if it's all dynamic except where we want the IPI to be routed 
to - the INT_SPEC is implicitly defined by the notion it's an IPI.

Thanks,
Qais

>
> Mark (as *you* are the expert ;-), what do you think?
>
> 	M.
