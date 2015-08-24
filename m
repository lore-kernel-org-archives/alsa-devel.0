From: Qais Yousef <qais.yousef@imgtec.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
Date: Mon, 24 Aug 2015 16:11:04 +0100
Message-ID: <55DB3408.7080502@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com> <1440419959-14315-2-git-send-email-qais.yousef@imgtec.com> <alpine.DEB.2.11.1508241447100.3873@nanos> <55DB15EB.3090109@imgtec.com> <alpine.DEB.2.11.1508241653200.3873@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1508241653200.3873@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On 08/24/2015 03:55 PM, Thomas Gleixner wrote:
> On Mon, 24 Aug 2015, Qais Yousef wrote:
>> On 08/24/2015 01:49 PM, Thomas Gleixner wrote:
>>> On Mon, 24 Aug 2015, Qais Yousef wrote:
>>>
>>>> Some drivers might require to send ipi to other cores. So export it.
>>> Which IPIs do you need to send from a driver which are not exposed by
>>> the SMP functions already?
>> It's not an SMP IPI. We use GIC to exchange interrupts between AXD and the
>> host system since AXD is another MIPS core in the cluster.
> So that should have been in the changelog to begin with.
>   

OK sorry for the confusion. I'll amend the changelog and be more careful 
in the future.

Thanks,
Qais

>>>> This will be used later by AXD driver.
>>> That smells fishy and it wants a proper explanation WHY and not just a
>>> sloppy statement that it will be used later. I can figure that out
>>> myself as exporting a function without using it does not make any sense.
>> Sorry for the terse explanation. As pointed above AXD uses GIC to send and
>> receive interrupts to the host core. Without this change I can't compile the
>> driver as a driver module because the symbol is not exported.
> Really? Exporting it solves that problem then. That's interesting news
> for me.
>
> Thanks,
>
> 	tglx
