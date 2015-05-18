From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [WM5102/ARIZONA] spi driver needs to support ACPI
Date: Mon, 18 May 2015 11:29:11 -0500
Message-ID: <555A1357.3090905@linux.intel.com>
References: <CAKor6TdtBEf9cN-EFw0BpRd4EbAKYXgfWh_PbSiG5=EhC1peew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id E75442606D3
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 18:29:21 +0200 (CEST)
In-Reply-To: <CAKor6TdtBEf9cN-EFw0BpRd4EbAKYXgfWh_PbSiG5=EhC1peew@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Hartmann <cornogle@googlemail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/15/15 4:16 AM, Christian Hartmann wrote:
> Hi list,
>
>
> I need ACPI support for the arizona-core / arizona-spi driver for the
> ACPI ID WM5102.
> This audio codec is build into the Lenovo Yoga 851F. This device is a
> 32Bit (UEFI) system
>
> http://support.lenovo.com/de/de/products/tablets/yoga-series/yoga-tablet-2-851
>
>
> I have tested with vanilla kernels from kernel.org 3.19.y ,4.0.y and
> master (from torvalds) currently its 4.1.0-rc3. As distribution I am
> working with Fedora / Fedlet was the initial install image.
>
> With all vanilla kernels I got at first an error message from spi32766:
>
> [    0.296297] pxa2xx-spi 80860F0E:00: cs1 >= max 1
> [    0.296311] spi_master spi32766: failed to add SPI device
> WM510205:00 from ACPI
>
> so I have at first patched as suggested by broonie the arizona-core
>
> commit 48203a0fede057d6a8c5f6872c53326395350f45
> Author: somebody anybody <somebody@foobar.com>
> Date:   Mon May 11 13:35:43 2015 +0200
>
>      spi-pxa2xx : raise chipselect
>
>      Signed-off-by: somebody anybody <somebody@foobar.com>
>
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index e3223ac..9c919ea 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1279,7 +1279,7 @@ pxa2xx_spi_acpi_get_pdata(struct platform_device *pdev)
>          if (adev->pnp.unique_id && !kstrtoint(adev->pnp.unique_id, 0, &devid))
>                  ssp->port_id = devid;
>
> -       pdata->num_chipselect = 1;
> +       pdata->num_chipselect = 20;
>          pdata->enable_dma = true;
>
>          return pdata;
>
> This leds the spi master do the further ACPI configuration and inital
> setup for the arizona-spi device, but adding the ACPI ID to it
> does not work yet as expected:
>
> The current last patchset on top of master is
>
>
> Author: somebody anybody <somebody@foobar.com>
> Date:   Wed May 13 11:36:25 2015 +0200
>
>      arizona : added ACPI id of wm5102 to SPI driver, too
>
>      Signed-off-by: somebody anybody <somebody@foobar.com>
>
> diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
> index 1e845f6..c19a4c1 100644
> --- a/drivers/mfd/arizona-spi.c
> +++ b/drivers/mfd/arizona-spi.c
> @@ -17,6 +17,7 @@
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   #include <linux/spi/spi.h>
> +#include <linux/acpi.h>
>   #include <linux/of.h>
>
>   #include <linux/mfd/arizona/core.h>
> @@ -82,6 +83,15 @@ static int arizona_spi_remove(struct spi_device *spi)
>          return 0;
>   }
>
> +#ifdef CONFIG_ACPI
> +static struct acpi_device_id wm5102_acpi_match[] = {
> +               { "WM5102", 0},
> +               { "WM510205", 0},
> +               { },
> +};
> +MODULE_DEVICE_TABLE(acpi, wm5102_acpi_match);
> +#endif
> +
>   static const struct spi_device_id arizona_spi_ids[] = {
>          { "wm5102", WM5102 },
>          { "wm5110", WM5110 },
> @@ -96,6 +106,9 @@ static struct spi_driver arizona_spi_driver = {
>                  .owner  = THIS_MODULE,
>                  .pm     = &arizona_pm_ops,
>                  .of_match_table = of_match_ptr(arizona_of_match),
> +#ifdef CONFIG_ACPI
> +               .acpi_match_table = ACPI_PTR(wm5102_acpi_match),
> +#endif
>          },
>          .probe          = arizona_spi_probe,
>          .remove         = arizona_spi_remove,
>
>
>
>
> commit 268e21d29c942205e40f749c6d71c77839dc67da
> Author: somebody anybody <somebody@foobar.com>
> Date:   Wed May 13 11:36:04 2015 +0200
>
>      arizona : added ACPI id of wm5102 to i2c driver
>
>      Signed-off-by: somebody anybody <somebody@foobar.com>
>
> diff --git a/drivers/mfd/arizona-i2c.c b/drivers/mfd/arizona-i2c.c
> index ff782a5..45ece1b 100644
> --- a/drivers/mfd/arizona-i2c.c
> +++ b/drivers/mfd/arizona-i2c.c
> @@ -18,6 +18,7 @@
>   #include <linux/regulator/consumer.h>
>   #include <linux/slab.h>
>   #include <linux/of.h>
> +#include <linux/acpi.h>
>
>   #include <linux/mfd/arizona/core.h>
>
> @@ -85,6 +86,15 @@ static int arizona_i2c_remove(struct i2c_client *i2c)
>          return 0;
>   }
>
> +#ifdef CONFIG_ACPI
> +static struct acpi_device_id wm5102_acpi_match[] = {
> +               { "WM5102", 0},
> +               { "WM510205", 0},
> +               { },

Those IDs don't really look like ACPI ones? Isn't there a rule that the 
_HID is represented by a 4-letter vendor ID followed by part ID? see 
http://www.uefi.org/PNP_ACPI_Registry


> +};
> +MODULE_DEVICE_TABLE(acpi, wm5102_acpi_match);
> +#endif
> +
>   static const struct i2c_device_id arizona_i2c_id[] = {
>          { "wm5102", WM5102 },
>          { "wm5110", WM5110 },
> @@ -100,6 +110,9 @@ static struct i2c_driver arizona_i2c_driver = {
>                  .owner  = THIS_MODULE,
>                  .pm     = &arizona_pm_ops,
>                  .of_match_table = of_match_ptr(arizona_of_match),
> +#ifdef CONFIG_ACPI
> +               .acpi_match_table = ACPI_PTR(wm5102_acpi_match),
> +#endif
>          },
>          .probe          = arizona_i2c_probe,
>          .remove         = arizona_i2c_remove,
>
>
>
> with these two patches the local master branch compiles fine, but at
> initialzing the arizona-spi driver gots a NULL pointer exception.
>
> I attach the whole dmesg of 4.1.0-rc3 (build 4.1.0.24-rc3).
>
> I need some assistance or hints to the right direction, I am looking
> myself and I also try what I can, but I think it would be easy peasy
> with some experts like here on this list :)
>
>
> PS: the message : spi_master spi32766: raised num_chipselect to 20 for
> WM510205:00
>
> is a dev_err() line added to the function static acpi_status
> acpi_spi_add_device(), there I had raised the num_chipselect first
> (that was wrong, the raise is now done as in the first patch above.
> this is only a debug message and will be removed soon)
>
>
> PPS: for me it seems that there is a missing 'link' from WM5102 to the
> sst-acpi 80860F28:00 device, which complaints NOW / the first time
> with the three patches applied on top on master.... will have a look
> into it.
>
> I hope I got this device working with some more help from you.
>
> cheers
> chris
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
