From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
	registration
Date: Mon, 14 Jul 2014 17:46:22 +0200
Message-ID: <4494372.fAWcxQ0qku@wuerfel>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <4755712.cJmZ5fnaQH@wuerfel> <53C3CFCA.9050800@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 54527261A95
 for <alsa-devel@alsa-project.org>; Mon, 14 Jul 2014 17:46:52 +0200 (CEST)
In-Reply-To: <53C3CFCA.9050800@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Kukjin Kim <kgene.kim@samsung.com>, t.figa@samsung.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, lgirdwood@gmail.com, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Monday 14 July 2014 14:40:42 Lars-Peter Clausen wrote:
> [...]
> > I've given it a try now. Can you confirm that this is a valid transformation?
> >
> > If it's ok, I'll fold it into the original patch and re-send.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> >   ./arch/arm/mach-s3c64xx/mach-smartq.c           |   15 ++++++++-------
> >   ./sound/soc/samsung/smartq_wm8987.c             |   19 +++++++------------
> >   ./include/linux/platform_data/asoc-s3c-smartq.h |   10 ----------
> >   3 files changed, 15 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/arm/mach-s3c64xx/mach-smartq.c b/arch/arm/mach-s3c64xx/mach-smartq.c
> > index 4c111f60dbf2..dce449c0e855 100644
> > --- a/arch/arm/mach-s3c64xx/mach-smartq.c
> > +++ b/arch/arm/mach-s3c64xx/mach-smartq.c
> > @@ -20,7 +20,6 @@
> >   #include <linux/spi/spi_gpio.h>
> >   #include <linux/usb/gpio_vbus.h>
> >   #include <linux/platform_data/s3c-hsotg.h>
> > -#include <linux/platform_data/asoc-s3c-smartq.h>
> 
> #include <linux/gpio/driver.h>

ok.

> >
> >   #include <asm/mach-types.h>
> >   #include <asm/mach/map.h>
> > @@ -380,9 +379,12 @@ void __init smartq_map_io(void)
> >   	smartq_lcd_mode_set();
> >   }
> >
> > -static const __initconst struct smartq_audio_pdata smartq_audio_pdata = {
> > -	.gpio_jack = S3C64XX_GPL(12),
> > -	.gpio_amp = S3C64XX_GPK(12),
> > +static struct gpiod_lookup_table smartq_audio_gpios = {
> > +	.dev_id = "smartq-audio",
> > +	.table = {
> > +		GPIO_LOOKUP("GPL", 12, "headphone detect", 0),
> > +		GPIO_LOOKUP("GPK", 12, "amplifiers shutdown", GPIO_ACTIVE_HIGH),
> 
> There is no such thing as GPIO_ACTIVE_HIGH, just 0 for flags.

The original driver does gpio_direction_output(..., 1); 

For some reason I earlier concluded that this was what the '1' would need
to get converted to. Are you sure '0' is correct then?

> This needs a { } terminating entry.

ok

> > +	},
> >   };
> >
> >   void __init smartq_machine_init(void)
> > @@ -404,7 +406,6 @@ void __init smartq_machine_init(void)
> >
> >   	platform_add_devices(smartq_devices, ARRAY_SIZE(smartq_devices));
> >
> > -	platform_device_register_data(NULL, "smartq-audio", -1,
> > -				      &smartq_audio_pdata,
> > -				      sizeof (smartq_audio_pdata));
> > +	platform_device_register_simple("smartq-audio", -1, NULL, 0);
> > +	gpiod_add_lookup_table(&smartq_audio_gpios);
> 
> To avoid a extra round of -EPROBE_DEFER the lookup table should be 
> registered before the device.

ok

> >   }
> [...]
> > diff --git a/sound/soc/samsung/smartq_wm8987.c b/sound/soc/samsung/smartq_wm8987.c
> > index 8c4a0a285ce7..8da7c67903c6 100644
> > --- a/sound/soc/samsung/smartq_wm8987.c
> > +++ b/sound/soc/samsung/smartq_wm8987.c
> > @@ -19,8 +19,6 @@
> >   #include <sound/soc.h>
> >   #include <sound/jack.h>
> 
> #include <linux/gpio/consumer.h>
> 
> >
> [..]
> > -
> > -	smartq_jack_gpios[0].gpio = pdata->gpio_jack;
> 
> smartq_jack_gpios[0].gpiod_dev = &pdev->dev;
> 
> > +	platform_set_drvdata(pdev, gpio);
> 
> This unfortunately wont work. snd_soc_register_card() will overwrite the 
> devices drvdata. Use snd_soc_card_set_drvdata(card, gpio) and in the speaker 
> event handler snd_soc_card_get_drvdata(w->dapm->card);

ok.

Thanks for the review!

	Arnd
