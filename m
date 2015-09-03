From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC PATCH (alsa-lib)] pcm: Modify check
	condition	in snd_pcm_sw_params_set_avail_min
Date: Thu, 3 Sep 2015 10:14:03 +0200
Message-ID: <55E8014B.8030800@ladisch.de>
References: <1441250454-38271-1-git-send-email-koro.chen@mediatek.com>
 <s5hfv2wvv35.wl-tiwai@suse.de> <1441266346.32609.18.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 12B27260618
 for <alsa-devel@alsa-project.org>; Thu,  3 Sep 2015 10:14:08 +0200 (CEST)
In-Reply-To: <1441266346.32609.18.camel@mtksdaap41>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Koro Chen <koro.chen@mediatek.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, linux-mediatek@lists.infradead.org, lgirdwood@gmail.com, srv_heupstream@mediatek.com
List-Id: alsa-devel@alsa-project.org

Koro Chen wrote:
> On Thu, 2015-09-03 at 09:08 +0200, Takashi Iwai wrote:
>> On Thu, 03 Sep 2015 05:20:54 +0200,
>> Koro Chen wrote:
>>> When we use a ping-ping buffer in capture, and if hw_ptr reported
>>> at IRQ is a little smaller than period_size:
>>>
>>> |xxxxxxxxxxxxxxxxxxxxxxxxxxxx--|-----------------------------|
>>>                             hw_ptr < period_size
>>
>> How this happens?  The period size is the size where irq (or wakeup)
>> wakes up for read/write.  Why the driver wakes up even if there is no
>> enough data?
>
> Yes it is odd to what we would normally expect. Due to our HW design,
> when irq comes, audio HW actually has collected a full period of data,
> but there is a buffer between the audio HW and memory, so at that moment
> some samples are still in the buffer, not on the memory.

Please note that ALSA (both the kernel and the userspace API) requires
that after a period interrupt, the _complete_ period has been read from/
written to the memory buffer.  This is needed because the interrupt is
the mechanism that synchronizes software and the DMA controller.
(Except when using the NO_PERIOD_WAKUP flag, but you cannot rely on the
software using it.)


Typically, any buffering is done inside the DMA controller, which also
issues interrupts, so this problem should not happen with correctly
working hardware.

(On PCI systems, writes to system memory can be buffered, but if the
interrupt handler does a read from a device register, the PCI memory
ordering rules ensure that all DMA accesses started before the interrupt
are finished before the read.)


How does your hardware work?  I guess that whatever component does the
buffering is independent of the component that generates interrupts, and
it does not enforce any memory ordering either?  And there isn't
a mechanism to flush the buffer?


Regards,
Clemens
