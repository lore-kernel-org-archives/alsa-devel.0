From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: DMA Physical Address through
	"snd_pcm_lib_malloc_pages"
Date: Thu, 24 Jun 2010 18:04:11 +0530
Message-ID: <AANLkTiky7_h8EWmM8h4bdCUw9aMWALk-bAeT7e22JJAw@mail.gmail.com>
References: <AANLkTik4I2g_DCdJFgNpKrp4vp08UbpKQUtz9YLAVM8K@mail.gmail.com>
	<s5h7hlpdjhs.wl%tiwai@suse.de>
	<AANLkTimTVqxnYmtTd1gObMd0L98Mf7nGFqjmM37w1d_3@mail.gmail.com>
	<s5hzkykdhpr.wl%tiwai@suse.de>
	<AANLkTim-Cx9N9M64-15let2tNpOqFU9x8EaYl_HHvqb0@mail.gmail.com>
	<s5hvd98dge6.wl%tiwai@suse.de>
	<AANLkTin2E2BSeAoHYoyd6mwukcLMxLjP6qg005DbAK8I@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5061B103811
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 14:34:16 +0200 (CEST)
Received: by pvc22 with SMTP id 22so1722722pvc.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 05:34:12 -0700 (PDT)
In-Reply-To: <AANLkTin2E2BSeAoHYoyd6mwukcLMxLjP6qg005DbAK8I@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

I called the function snd_pcm_lib_preallocate_pages_for_all passing
SNDRV_DMA_TYPE_DEV and  pointer to struct device as parameters. This
doesn't crash. However with SNDRV_DMA_TYPE_CONTINUOUS it did crash.

I have used the function "snd_pcm_lib_malloc_pages" in the hw_params
callout to allocate DMA memory. I hope this is the right way of doing
the DMA allocation.

With this above configuration can I stay assured that "dma_addr" will
give me the physical address of the buffer?

Regards;
Aadish


On Thu, Jun 24, 2010 at 1:57 PM, Adish Kuvelker <adkuvi@gmail.com> wrote:
> Hello Takashi,
>
> I'm sorry as this is getting bit confusing for me. Playing the PCM
> data I would want to pass the starting physical address of this
> location to the DMA start address. Now can I access "dma_addr"
> directly for this purpose?
> Do I still have to allocate DMA memory or will just passing of this
> dma_addr as source address suffice?
>
> I am new to ALSA framework and it's getting a bit confusing to me.
>
> Regards;
> Aadish
>
> On Thu, Jun 24, 2010 at 1:14 PM, Takashi Iwai <tiwai@suse.de> wrote:
>> At Thu, 24 Jun 2010 12:52:47 +0530,
>> Adish Kuvelker wrote:
>>>
>>> Hello,
>>>
>>> If I use "SNDRV_DMA_TYPE_CONTINUOUS" as a parameter to pre-allocate
>>> function to get contiguous locations of memory and use the function
>>> snd_dma_continuous_data() would that be correct setting for my case?
>>
>> I guess no. =A0As mentioned, it's no DMA memory, i.e. simple pages
>> allocated via __get_free_pages() and co.
>>
>>> Where are the parameters of dma_addr and dma_area written to the
>>> runtime structure?
>>
>> These are available only for pages properly allocated for DMA.
>>
>>
>> Takashi
>>
>>>
>>> Regards;
>>> Aadish
>>>
>>> On Thu, Jun 24, 2010 at 12:45 PM, Takashi Iwai <tiwai@suse.de> wrote:
>>> > At Thu, 24 Jun 2010 12:38:35 +0530,
>>> > Adish Kuvelker wrote:
>>> >>
>>> >> Hello Takashi,
>>> >>
>>> >> I am developing a DMA Controller driver to service the PCM out data =
to
>>> >> the Audio controller on the arm-based ATLASIII procesor. In case you
>>> >> need any more information on the architecture I can pass.
>>> >>
>>> >> Since the DMA isn't on PCI bus I am pre-allocation continuous memero
>>> >> using the "snd_pcm_lib_preallocate_pages_for_all" passing
>>> >> SNDDRV_DMA_TYPE_DEV and "snd_dma_continuous_data" as appropriate
>>> >> parameters.
>>> >
>>> > snd_dma_continuous_data() is only for SNDRV_DMA_TYPE_CONTINUOUS.
>>> > In this case, the pages aren't for DMA.
>>> >
>>> > For SNDRV_DMA_TYPE_DEV, simply pass the device pointer you use.
>>> >
>>> >
>>> > Takashi
>>> >
>>>
>>
>
