From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] iio: adc: STM32_DFSDM_ADC should depend on HAS_DMA
Date: Tue, 30 Jan 2018 16:31:24 +0100
Message-ID: <CAMuHMdWhADAPSnj_34R04Oh_H_puyc0vzx--tpihAaUM4NDMQg@mail.gmail.com>
References: <1517318506-14664-1-git-send-email-geert@linux-m68k.org> <20180130150337.GC10525@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180130150337.GC10525-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ALSA Development Mailing List <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Tue, Jan 30, 2018 at 4:03 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jan 30, 2018 at 02:21:46PM +0100, Geert Uytterhoeven wrote:
>> If NO_DMA=y:
>>
>>     ERROR: "bad_dma_ops" [drivers/iio/adc/stm32-dfsdm-adc.ko] undefined!
>>
>> Add a dependency on HAS_DMA to fix this.
>
> Once again I have to ask why we're doing this per driver and not having
> the few architectures that have this issue set something up.

Because doing so would lead us to

    depends on COMPILE_TEST || HAS_DMA

in many places. Is that any better?

I agree we could indeed use DMA dummies in cases where a driver uses:

   depends on ARCH_FOO || ARCH_BAR || COMPILE_TEST
   depends on HAS_DMA

But we also have generic options like:

    config ATA_BMDMA
            bool "ATA BMDMA support"
            depends on HAS_DMA

And even architecture-specific drivers for SoCs that may or not have DMA:

config HASH_DEV_STM32
        tristate "Support for STM32 hash accelerators"
        depends on ARCH_STM32
        depends on HAS_DMA

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
