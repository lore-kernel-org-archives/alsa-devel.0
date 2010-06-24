From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: DMA Physical Address through
	"snd_pcm_lib_malloc_pages"
Date: Thu, 24 Jun 2010 12:38:35 +0530
Message-ID: <AANLkTimTVqxnYmtTd1gObMd0L98Mf7nGFqjmM37w1d_3@mail.gmail.com>
References: <AANLkTik4I2g_DCdJFgNpKrp4vp08UbpKQUtz9YLAVM8K@mail.gmail.com>
	<s5h7hlpdjhs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 387BC2450A
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 09:08:36 +0200 (CEST)
Received: by vws20 with SMTP id 20so2006290vws.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 00:08:35 -0700 (PDT)
In-Reply-To: <s5h7hlpdjhs.wl%tiwai@suse.de>
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

I am developing a DMA Controller driver to service the PCM out data to
the Audio controller on the arm-based ATLASIII procesor. In case you
need any more information on the architecture I can pass.

Since the DMA isn't on PCI bus I am pre-allocation continuous memero
using the "snd_pcm_lib_preallocate_pages_for_all" passing
SNDDRV_DMA_TYPE_DEV and "snd_dma_continuous_data" as appropriate
parameters.

Would I still have to set the dma_addr value in my driver?

Regards;
Aadish
On Thu, Jun 24, 2010 at 12:07 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 24 Jun 2010 03:50:17 +0530,
> Adish Kuvelker wrote:
>>
>> Hello,
>>
>> I am trying to allocate memory for DMA buffer through
>> "snd_pcm_lib_malloc_pages" in hw_params callout function, with prior
>> use of "snd_pcm_lib_preallocate_pages_for_all". The chapter on PCM
>> Interface in "writing an ALSA driver" states that if the standard
>> function "snd_pcm_lib_malloc_pages" is use for allocating the DMA
>> buffers then the DMA fields of dma_addr, dma_area, dma_bytes are set
>> by the ALSA middle layer.
>>
>> However my code walk through didn't point me to the area where this
>> physical memory setting is done. My DMA channel is not serving a PCI
>> device. I would be very grateful if any of you guys can point me to
>> the code where this settings get done by calling
>> "snd_pcm_lib_malloc_pages".
>
> snd_pcm_lib_*_pages() works only with the preallocated buffers, and
> the pre-allocation can be done with the generic struct device, as long
> as the device (bus) supports dma_alloc_coherent() properly.
>
> But this can be pretty arch-specific, so better to clarify more your
> hardware if you need detailed answers...
>
>
> Takashi
>
