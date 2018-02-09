From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] ASoC: rt5645: Introduce mapping for
	ACPI-defined GPIO
Date: Fri, 9 Feb 2018 16:50:22 +0200
Message-ID: <CAHp75VdrZVJ+mgx=9PkLuGbtTCru3S-0jVDNVcBft4a5Nr+pyw@mail.gmail.com>
References: <20180209142318.14451-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f193.google.com (mail-qk0-f193.google.com
 [209.85.220.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E4AC7266E55
 for <alsa-devel@alsa-project.org>; Fri,  9 Feb 2018 15:50:24 +0100 (CET)
Received: by mail-qk0-f193.google.com with SMTP id p23so10249486qke.8
 for <alsa-devel@alsa-project.org>; Fri, 09 Feb 2018 06:50:24 -0800 (PST)
In-Reply-To: <20180209142318.14451-1-carlo@caione.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@caione.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Carlo Caione <carlo@endlessm.com>, Bard Liao <bardliao@realtek.com>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Feb 9, 2018 at 4:23 PM, Carlo Caione <carlo@caione.org> wrote:
> From: Carlo Caione <carlo@endlessm.com>
>
> On at least one notebook (ECS EF20EA) the 'hp-detect' GPIO is defined in
> the DSDT table by the ACPI GpioIo resources in _CRS. Add this mapping to
> the rt5645 driver to enable the jack detection also on non-DT platforms.
>
> Method (_CRS, 0, NotSerialized)
> {
>   Name (SBUF, ResourceTemplate ()
>   {
>     I2cSerialBusV2 (0x001A, ControllerInitiated, 0x00061A80,
>         AddressingMode7Bit, "\\_SB.PCI0.I2C2",
>         0x00, ResourceConsumer, , Exclusive,
>         )
>     GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone, 0x0000,
>         "\\_SB.GPO3", 0x00, ResourceConsumer, ,
>         )
>         {   // Pin list
>             0x004F
>         }
>     GpioIo (Shared, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
>         "\\_SB.GPO3", 0x00, ResourceConsumer, ,
>         )
>         {   // Pin list
>             0x004F
>         }
>   })
>   Return (SBUF) /* \_SB_.PCI0.I2C2.RTK2._CRS.SBUF */
> }
>

Sorry everyone, hit reply only to Carlo, but everything he addressed
here is like I proposed.

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>
> Changelog:
>
> v2:
>   - s/ACPI_HANDLE/has_acpi_companion/
> ---
>  sound/soc/codecs/rt5645.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index 8f140c8b93ac..8e3d1e4ddb63 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3764,6 +3764,13 @@ static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device *dev)
>         return 0;
>  }
>
> +static const struct acpi_gpio_params hp_detect_gpios = { 1, 0, false };
> +
> +static const struct acpi_gpio_mapping cht_rt5645_gpios[] = {
> +       { "hp-detect-gpios", &hp_detect_gpios, 1 },
> +       {},
> +};
> +
>  static int rt5645_i2c_probe(struct i2c_client *i2c,
>                     const struct i2c_device_id *id)
>  {
> @@ -3779,6 +3786,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
>         if (rt5645 == NULL)
>                 return -ENOMEM;
>
> +       if (has_acpi_companion(&i2c->dev))
> +               if (devm_acpi_dev_add_driver_gpios(&i2c->dev, cht_rt5645_gpios))
> +                       dev_dbg(&i2c->dev, "Failed to add driver gpios\n");
> +
>         rt5645->i2c = i2c;
>         i2c_set_clientdata(i2c, rt5645);
>
> --
> 2.14.1
>



-- 
With Best Regards,
Andy Shevchenko
