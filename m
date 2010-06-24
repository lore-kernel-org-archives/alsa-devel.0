From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: DMA Physical Address through
	"snd_pcm_lib_malloc_pages"
Date: Thu, 24 Jun 2010 12:52:47 +0530
Message-ID: <AANLkTim-Cx9N9M64-15let2tNpOqFU9x8EaYl_HHvqb0@mail.gmail.com>
References: <AANLkTik4I2g_DCdJFgNpKrp4vp08UbpKQUtz9YLAVM8K@mail.gmail.com>
	<s5h7hlpdjhs.wl%tiwai@suse.de>
	<AANLkTimTVqxnYmtTd1gObMd0L98Mf7nGFqjmM37w1d_3@mail.gmail.com>
	<s5hzkykdhpr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id BBA0124141
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jun 2010 09:23:09 +0200 (CEST)
Received: by vws20 with SMTP id 20so2020153vws.38
	for <alsa-devel@alsa-project.org>; Thu, 24 Jun 2010 00:23:09 -0700 (PDT)
In-Reply-To: <s5hzkykdhpr.wl%tiwai@suse.de>
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

Hello,

If I use "SNDRV_DMA_TYPE_CONTINUOUS" as a parameter to pre-allocate
function to get contiguous locations of memory and use the function
snd_dma_continuous_data() would that be correct setting for my case?
Where are the parameters of dma_addr and dma_area written to the
runtime structure?

Regards;
Aadish

On Thu, Jun 24, 2010 at 12:45 PM, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 24 Jun 2010 12:38:35 +0530,
> Adish Kuvelker wrote:
>>
>> Hello Takashi,
>>
>> I am developing a DMA Controller driver to service the PCM out data to
>> the Audio controller on the arm-based ATLASIII procesor. In case you
>> need any more information on the architecture I can pass.
>>
>> Since the DMA isn't on PCI bus I am pre-allocation continuous memero
>> using the "snd_pcm_lib_preallocate_pages_for_all" passing
>> SNDDRV_DMA_TYPE_DEV and "snd_dma_continuous_data" as appropriate
>> parameters.
>
> snd_dma_continuous_data() is only for SNDRV_DMA_TYPE_CONTINUOUS.
> In this case, the pages aren't for DMA.
>
> For SNDRV_DMA_TYPE_DEV, simply pass the device pointer you use.
>
>
> Takashi
>
