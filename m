From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 1/5] ASoC: da7213: add ACPI support
Date: Mon, 13 Mar 2017 16:10:54 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370142A9AD76@SW-EX-MBX01.diasemi.com>
References: <1489105142-25878-1-git-send-email-pierre-louis.bossart@linux.intel.com>
 <1489105142-25878-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.148])
 by alsa0.perex.cz (Postfix) with ESMTP id D166D266B13
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 17:10:57 +0100 (CET)
In-Reply-To: <1489105142-25878-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "vinod.koul@intel.com" <vinod.koul@intel.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 10 March 2017 00:19, Pierre-Louis Bossart wrote:

> Add DLGS7212 and DLGS7213 HID
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/codecs/da7213.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> index 12da558..6dd7578 100644
> --- a/sound/soc/codecs/da7213.c
> +++ b/sound/soc/codecs/da7213.c
> @@ -12,6 +12,7 @@
>   * option) any later version.
>   */
> 
> +#include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/i2c.h>
> @@ -1528,12 +1529,23 @@ static int da7213_set_bias_level(struct snd_soc_codec
> *codec,
>  	return 0;
>  }
> 
> +#if defined(CONFIG_OF)
>  /* DT */
>  static const struct of_device_id da7213_of_match[] = {
>  	{ .compatible = "dlg,da7213", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, da7213_of_match);
> +#endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id da7213_acpi_match[] = {
> +	{ "DLGS7212", 0},
> +	{ "DLGS7213", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, da7213_acpi_match);
> +#endif

The #ifdefs aren't strictly necessary here so might be cleaner to remove them.

> 
>  static enum da7213_micbias_voltage
>  	da7213_of_micbias_lvl(struct snd_soc_codec *codec, u32 val)
> @@ -1844,6 +1856,7 @@ static struct i2c_driver da7213_i2c_driver = {
>  	.driver = {
>  		.name = "da7213",
>  		.of_match_table = of_match_ptr(da7213_of_match),
> +		.acpi_match_table = ACPI_PTR(da7213_acpi_match),
>  	},
>  	.probe		= da7213_i2c_probe,
>  	.remove		= da7213_remove,
> --
> 2.7.4

As a general comment, it would be nice if the current of_property_read_* calls
could be converted to device_property_read_* calls instead, so both ACPI and DT
initialisation of bindings is supported.
