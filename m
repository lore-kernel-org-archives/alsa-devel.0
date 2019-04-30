From: Liwei Song <liwei.song@windriver.com>
Subject: Re: [PATCH] ALSA: hda: check RIRB to avoid use NULL
	pointer
Date: Tue, 30 Apr 2019 17:29:19 +0800
Message-ID: <5CC8156F.1030403@windriver.com>
References: <1556604653-47363-1-git-send-email-liwei.song@windriver.com>	<s5himuwhru3.wl-tiwai@suse.de>	<5CC8082F.4090903@windriver.com>
 <s5h4l6fj2m6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CEAB6F80759
 for <alsa-devel@alsa-project.org>; Tue, 30 Apr 2019 11:30:36 +0200 (CEST)
In-Reply-To: <s5h4l6fj2m6.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Yu Zhao <yuzhao@google.com>, Keyon Jie <yang.jie@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 04/30/2019 04:53 PM, Takashi Iwai wrote:
> On Tue, 30 Apr 2019 10:32:47 +0200,
> Liwei Song wrote:
>>
>>
>>
>> On 04/30/2019 03:31 PM, Takashi Iwai wrote:
>>> On Tue, 30 Apr 2019 08:10:53 +0200,
>>> Song liwei wrote:
>>>>
>>>> From: Liwei Song <liwei.song@windriver.com>
>>>>
>>>> Fix the following BUG:
>>>>
>>>> BUG: unable to handle kernel NULL pointer dereference at 000000000000000c
>>>> Workqueue: events azx_probe_work [snd_hda_intel]
>>>> RIP: 0010:snd_hdac_bus_update_rirb+0x80/0x160 [snd_hda_core]
>>>> Call Trace:
>>>>  <IRQ>
>>>>  azx_interrupt+0x78/0x140 [snd_hda_codec]
>>>>  __handle_irq_event_percpu+0x49/0x300
>>>>  handle_irq_event_percpu+0x23/0x60
>>>>  handle_irq_event+0x3c/0x60
>>>>  handle_edge_irq+0xdb/0x180
>>>>  handle_irq+0x23/0x30
>>>>  do_IRQ+0x6a/0x140
>>>>  common_interrupt+0xf/0xf
>>>>
>>>> The Call Trace happened when run kdump on a NFS rootfs system.
>>>> Exist the following calling sequence when boot the second kernel:
>>>>
>>>> azx_first_init()
>>>>    --> azx_acquire_irq()
>>>>                       <-- interrupt come in, azx_interrupt() was called
>>>>    --> hda_intel_init_chip()
>>>>       --> azx_init_chip()
>>>>          --> snd_hdac_bus_init_chip()
>>>>               --> snd_hdac_bus_init_cmd_io();
>>>>                     --> init rirb.buf and corb.buf
>>>>
>>>> Interrupt happened after azx_acquire_irq() while RIRB still didn't got
>>>> initialized, then NULL pointer will be used when process the interrupt.
>>>>
>>>> Check the value of RIRB to ensure it is not NULL, to aviod some special
>>>> case may hang the system.
>>>>
>>>> Fixes: 14752412721c ("ALSA: hda - Add the controller helper codes to hda-core module")
>>>> Signed-off-by: Liwei Song <liwei.song@windriver.com>
>>>
>>> Oh, that's indeed a race there.
>>>
>>> But I guess the check introduced by the patch is still error-prone.
>>> Basically the interrupt handling should be moved after the chip
>>> initialization.  I suppose that your platform uses the shared
>>> interrupt, not the MSI?
>>
>> This is the information from /proc/interrupt
>> 134:          0        102          0          0  IR-PCI-MSI 514048-edge      snd_hda_intel:card0
> 
> Hm, then it's interesting...
> 
> 
>>> In anyway, alternative (and likely more certain) fix would be to move
>>> the azx_acquir_irq() call like the patch below (note: totally
>>> untested).  Could you check whether it works?
>>
>> Yes, It works.
>>
>> Considering a previous patch like the one you provide will import some issue, 
>> so I choose check the invalid value to low the risk, but just as you mentioned,
>> It is not a good solution.
>>
>> commit 542cedec53c9e8b73f3f05bf8468823598c50489
>> Author: Yu Zhao <yuzhao@google.com>
>> Date:   Tue Sep 11 15:12:46 2018 -0600
>>
>>     Revert "ASoC: Intel: Skylake: Acquire irq after RIRB allocation"
>>     
>>     This reverts commit 12eeeb4f4733bbc4481d01df35933fc15beb8b19.
>>     
>>     The patch doesn't fix accessing memory with null pointer in
>>     skl_interrupt().
>>     
>>     There are two problems: 1) skl_init_chip() is called twice, before
>>     and after dma buffer is allocate. The first call sets bus->chip_init
>>     which prevents the second from initializing bus->corb.buf and
>>     rirb.buf from bus->rb.area. 2) snd_hdac_bus_init_chip() enables
>>     interrupt before snd_hdac_bus_init_cmd_io() initializing dma buffers.
>>     There is a small window which skl_interrupt() can be called if irq
>>     has been acquired. If so, it crashes when using null dma buffer
>>     pointers.
> 
> Actually this followed by another fix b61749a89f82,
>     sound: enable interrupt after dma buffer initialization
>     
> and this moved the IRQ enablement after snd_hdac_bus_init_cmd_io().
> 
> So I wonder how the irq gets triggered in your case.
> If it were a shared irq, it's understandable.  But for MSI, it should
> have been the isolated source.

I'm still working on how the irq was triggered,
it is a little complex to reproduce it, first it must run with NFS rootfs,
without NFS rootfs it can not reproduced.
Then with kdump enabled, after "echo c > /proc/sysrq-trigger" crash the kernel,
the kernel specified by kdump will boot, then interrupt will trigger
soon after azx interrupt was register.


> 
> In anyway, for the latest tree, the change I suggested would cover
> better although it's more radical as you pointed.

Got it, Thanks.

Liwei.


> 
> 
> thanks,
> 
> Takashi
> 
> 
