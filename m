From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 1/1 linux-next] ASoC: samsung: include gpio consumer.h
Date: Thu, 8 Dec 2016 19:39:59 +0200
Message-ID: <20161208173959.GB8522@kozik-lap>
References: <1481096342-19104-1-git-send-email-fabf@skynet.be>
 <20161207175502.GA13187@kozik-lap>
 <948424390.581380.1481142662205.open-xchange@webmail.nmp.proximus.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <948424390.581380.1481142662205.open-xchange@webmail.nmp.proximus.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 07, 2016 at 09:31:02PM +0100, Fabian Frederick wrote:
> 
> 
> > On 07 December 2016 at 18:55 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> >
> > On Wed, Dec 07, 2016 at 08:39:02AM +0100, Fabian Frederick wrote:
> > > Fix the following build errors
> >
> > I couldn't reproduce it on default config. Can you mention the necessary
> > environment/defconfig/arch etc.?
> >
> > Patch itself looks needed. However shouldn't the driver depend also on
> > GPIOLIB?
> >
> > Best regards,
> > Krzysztof
> 
> Hi Krzysztof,
> 
>         It's based on a randconfig with compile_test without gpiolib.
> I reproduced it with make defconfig followed by selecting
> x86_32

So could you mention it? Something like:
"...build errors on x86_32 with !GPIOLIB."
would be sufficient IMHO.

> SPI
> SND_SOC_SAMSUNG
> MFD_ARIZONA_I2C
> MFD_ARIZONA
> SND_SOC
> COMPILE_TEST
> X86_INTEL_QUARK
> COMMON_CLK
> SND_SOC_SAMSUNG
> SND_SOC_SAMSUNG_TM2_WM5110
> 
> Here's another patch solving the same problem with complete explanation:
> 
> Commit 638f958baeaf
> ("extcon: Allow compile test of GPIO consumers if !GPIOLIB")
> 
> as you're suggesting, we could add depend on GPIOLIB.
> extcon has the following: depends on GPIOLIB || COMPILE_TEST
> 
> smartq_wm8987.c also has gpio_consumer.h for SND_SOC_SMARTQ
> which would give the following update on samsung/Kconfig besides initial patch:

Makes sense. The GPIOLIB is indeed runtime dependency for the driver.

Feel free to send a follow up patch for GPIOLIB (reported-by credits
would be appreciated ;) ).

Best regards,
Krzysztof

> 
> diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
> index 7c42315..f1f1d79 100644
> --- a/sound/soc/samsung/Kconfig
> +++ b/sound/soc/samsung/Kconfig
> @@ -111,6 +111,7 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
>  config SND_SOC_SMARTQ
>         tristate "SoC I2S Audio support for SmartQ board"
>         depends on MACH_SMARTQ || COMPILE_TEST
> +       depends on GPIOLIB || COMPILE_TEST
>         depends on I2C
>         select SND_SAMSUNG_I2S
>         select SND_SOC_WM8750
> @@ -193,6 +194,7 @@ config SND_SOC_ARNDALE_RT5631_ALC5631
>  config SND_SOC_SAMSUNG_TM2_WM5110
>         tristate "SoC I2S Audio support for WM5110 on TM2 board"
>         depends on SND_SOC_SAMSUNG && MFD_ARIZONA && I2C && SPI_MASTER
> +       depends on GPIOLIB || COMPILE_TEST
>         select SND_SOC_MAX98504
>         select SND_SOC_WM5110
>         select SND_SAMSUNG_I2S
> 
> 
> Regards,
> Fabian
> >
> > > sound/soc/samsung/tm2_wm5110.c:220:3: error: implicit declaration
> > > of function 'gpiod_set_value_cansleep'
> > > [-Werror=implicit-function-declaration]
> > > sound/soc/samsung/tm2_wm5110.c:438:24: error: implicit declaration
> > > of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
> > >
> > > Signed-off-by: Fabian Frederick <fabf@skynet.be>
> > > ---
> > >  sound/soc/samsung/tm2_wm5110.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/sound/soc/samsung/tm2_wm5110.c b/sound/soc/samsung/tm2_wm5110.c
> > > index 5cdf7d1..24cc9d6 100644
> > > --- a/sound/soc/samsung/tm2_wm5110.c
> > > +++ b/sound/soc/samsung/tm2_wm5110.c
> > > @@ -12,6 +12,7 @@
> > > 
> > >  #include <linux/clk.h>
> > >  #include <linux/gpio.h>
> > > +#include <linux/gpio/consumer.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <sound/pcm_params.h>
> > > --
> > > 2.7.4
> > >
