From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/6] ASoC: atmel: Use
	devm_snd_dmaengine_pcm_register()
Date: Mon, 25 Nov 2013 12:18:33 +0100
Message-ID: <52933209.2050301@metafoo.de>
References: <1385299262-24304-1-git-send-email-lars@metafoo.de>
 <1385299262-24304-2-git-send-email-lars@metafoo.de>
 <5293282B.7080609@atmel.com> <52932946.30208@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-025.synserver.de (smtp-out-045.synserver.de
 [212.40.185.45])
 by alsa0.perex.cz (Postfix) with ESMTP id ECBA226500D
 for <alsa-devel@alsa-project.org>; Mon, 25 Nov 2013 12:18:01 +0100 (CET)
In-Reply-To: <52932946.30208@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Ryan Mallon <rmallon@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, H Hartley Sweeten <hsweeten@visionengravers.com>, Mark Brown <broonie@kernel.org>, Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 11/25/2013 11:41 AM, Lars-Peter Clausen wrote:
> On 11/25/2013 11:36 AM, Bo Shen wrote:
>> Hi Lars-Perter,
>>
>> On 11/24/2013 09:20 PM, Lars-Peter Clausen wrote:
>>> Makes the code shorter.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>>   sound/soc/atmel/atmel-pcm-dma.c | 8 +-------
>>>   sound/soc/atmel/atmel-pcm.h     | 4 ----
>>>   sound/soc/atmel/atmel_ssc_dai.c | 4 +---
>>>   3 files changed, 2 insertions(+), 14 deletions(-)
>>
>> Tested on at91sam9n12ek board, it will cause oops at the second time load
>> the driver module (insmod --> rmmod --> insmod: oops).
> 
> Does it work without the patch?
> 

Ok, I see atmel is special. asoc_ssc_init() and asoc_ssc_exit() are not
called from the drivers probe or remove function, so we can't use the
resource managed version here. Thanks for testing.

- Lars

>>
>> Some log information as following:
>> ---8>---
>> Unable to handle kernel paging request at virtual address bf000190
>> pgd = c77c0000
>> [bf000190] *pgd=27457811, *pte=00000000, *ppte=00000000
>> Internal error: Oops: 7 [#1] ARM
>> Modules linked in: snd_atmel_soc_wm8904(+) snd_soc_wm8904
>> snd_soc_atmel_ssc_dai snd_soc_atmel_pcm_dma [last unloaded:
>> snd_soc_atmel_pcm_dma]
>> CPU: 0 PID: 574 Comm: insmod Not tainted 3.13.0-rc1+ #65
>> task: c774d800 ti: c754e000 task.ti: c754e000
>> PC is at dmaengine_pcm_new+0x28/0x1a0
>> LR is at soc_new_pcm+0x2ec/0x394
>> pc : [<c02b5dcc>]    lr : [<c02b4cb4>]    psr: a0000013
>> sp : c754fc88  ip : 00000000  fp : c77682ec
>> r10: c7768220  r9 : c77682e0  r8 : 00000000
>> r7 : c77682ec  r6 : 00000001  r5 : 00000001  r4 : c7685810
>> r3 : bf000180  r2 : c7467010  r1 : c7777020  r0 : c7685810
>> Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>> Control: 0005317f  Table: 277c0000  DAC: 00000015
>> Process insmod (pid: 574, stack limit = 0xc754e1c0)
>> Stack: (0xc754fc88 to 0xc7550000)
>> ......
>> [<c02b5dcc>] (dmaengine_pcm_new+0x28/0x1a0) from [<c02b4cb4>]
>> (soc_new_pcm+0x2ec/0x394)
>> [<c02b4cb4>] (soc_new_pcm+0x2ec/0x394) from [<c02abfe8>]
>> (snd_soc_register_card+0xadc/0x1180)
>> [<c02abfe8>] (snd_soc_register_card+0xadc/0x1180) from [<bf02d24c>]
>> (atmel_asoc_wm8904_probe+0x18c/0x214 [snd_atmel_soc_wm8904])
>> [<bf02d24c>] (atmel_asoc_wm8904_probe+0x18c/0x214 [snd_atmel_soc_wm8904])
>> from [<c01dedcc>] (platform_drv_probe+0x18/0x48)
>> [<c01dedcc>] (platform_drv_probe+0x18/0x48) from [<c01dda6c>]
>> (driver_probe_device+0xac/0x1f4)
>> [<c01dda6c>] (driver_probe_device+0xac/0x1f4) from [<c01ddc1c>]
>> (__driver_attach+0x68/0x88)
>> [<c01ddc1c>] (__driver_attach+0x68/0x88) from [<c01dc4bc>]
>> (bus_for_each_dev+0x54/0x8c)
>> [<c01dc4bc>] (bus_for_each_dev+0x54/0x8c) from [<c01dd2d8>]
>> (bus_add_driver+0xc8/0x1c4)
>> [<c01dd2d8>] (bus_add_driver+0xc8/0x1c4) from [<c01de228>]
>> (driver_register+0x9c/0xe0)
>> [<c01de228>] (driver_register+0x9c/0xe0) from [<c0008910>]
>> (do_one_initcall+0xa8/0x15c)
>> [<c0008910>] (do_one_initcall+0xa8/0x15c) from [<c004d8fc>]
>> (load_module+0x1724/0x19d8)
>> [<c004d8fc>] (load_module+0x1724/0x19d8) from [<c004dc70>]
>> (SyS_init_module+0xc0/0xd8)
>> [<c004dc70>] (SyS_init_module+0xc0/0xd8) from [<c00094a0>]
>> (ret_fast_syscall+0x0/0x2c)
>> Code: e1a04000 e24b900c e58d200c 0a000004 (e5938010)
>> ---[ end trace 484369a6aa2ca38d ]---
>> Segmentation fault
>> ---<8---
>>
>>> diff --git a/sound/soc/atmel/atmel-pcm-dma.c
>>> b/sound/soc/atmel/atmel-pcm-dma.c
>>> index 06082e5..7dbc0e9 100644
>>> --- a/sound/soc/atmel/atmel-pcm-dma.c
>>> +++ b/sound/soc/atmel/atmel-pcm-dma.c
>>> @@ -129,17 +129,11 @@ static const struct snd_dmaengine_pcm_config
>>> atmel_dmaengine_pcm_config = {
>>>
>>>   int atmel_pcm_dma_platform_register(struct device *dev)
>>>   {
>>> -    return snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config,
>>> +    return devm_snd_dmaengine_pcm_register(dev, &atmel_dmaengine_pcm_config,
>>>               SND_DMAENGINE_PCM_FLAG_NO_RESIDUE);
>>>   }
>>>   EXPORT_SYMBOL(atmel_pcm_dma_platform_register);
>>>
>>> -void atmel_pcm_dma_platform_unregister(struct device *dev)
>>> -{
>>> -    snd_dmaengine_pcm_unregister(dev);
>>> -}
>>> -EXPORT_SYMBOL(atmel_pcm_dma_platform_unregister);
>>> -
>>>   MODULE_AUTHOR("Bo Shen <voice.shen@atmel.com>");
>>>   MODULE_DESCRIPTION("Atmel DMA based PCM module");
>>>   MODULE_LICENSE("GPL");
>>> diff --git a/sound/soc/atmel/atmel-pcm.h b/sound/soc/atmel/atmel-pcm.h
>>> index 12ae814..bb71069 100644
>>> --- a/sound/soc/atmel/atmel-pcm.h
>>> +++ b/sound/soc/atmel/atmel-pcm.h
>>> @@ -105,15 +105,11 @@ static inline void
>>> atmel_pcm_pdc_platform_unregister(struct device *dev)
>>>   #if defined(CONFIG_SND_ATMEL_SOC_DMA) || \
>>>       defined(CONFIG_SND_ATMEL_SOC_DMA_MODULE)
>>>   int atmel_pcm_dma_platform_register(struct device *dev);
>>> -void atmel_pcm_dma_platform_unregister(struct device *dev);
>>>   #else
>>>   static inline int atmel_pcm_dma_platform_register(struct device *dev)
>>>   {
>>>       return 0;
>>>   }
>>> -static inline void atmel_pcm_dma_platform_unregister(struct device *dev)
>>> -{
>>> -}
>>>   #endif
>>>
>>>   #endif /* _ATMEL_PCM_H */
>>> diff --git a/sound/soc/atmel/atmel_ssc_dai.c
>>> b/sound/soc/atmel/atmel_ssc_dai.c
>>> index 8697ced..13aaa7d 100644
>>> --- a/sound/soc/atmel/atmel_ssc_dai.c
>>> +++ b/sound/soc/atmel/atmel_ssc_dai.c
>>> @@ -792,9 +792,7 @@ static void asoc_ssc_exit(struct device *dev)
>>>       struct platform_device *pdev = to_platform_device(dev);
>>>       struct ssc_device *ssc = platform_get_drvdata(pdev);
>>>
>>> -    if (ssc->pdata->use_dma)
>>> -        atmel_pcm_dma_platform_unregister(dev);
>>> -    else
>>> +    if (!ssc->pdata->use_dma)
>>>           atmel_pcm_pdc_platform_unregister(dev);
>>>
>>>       snd_soc_unregister_component(dev);
>>>
>>
>> Best Regards,
>> Bo Shen
>>
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
