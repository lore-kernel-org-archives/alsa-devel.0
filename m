From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 3/3] ASoC: da7219: Add initial ACPI id for
 device
Date: Thu, 5 May 2016 08:49:01 -0500
Message-ID: <1c031817-6e7c-7e91-75e5-73a72ed0d3ed@linux.intel.com>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <7ddf6d5b47424ca3777d33a9f91d30ea7c7c439a.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id F13BB266C73
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 15:49:05 +0200 (CEST)
Received: from fhabib-mobl1.amr.corp.intel.com (unknown [10.254.120.40])
 by linux.intel.com (Postfix) with ESMTP id 9D09D6A4006
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2016 07:36:36 -0700 (PDT)
In-Reply-To: <7ddf6d5b47424ca3777d33a9f91d30ea7c7c439a.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 5/5/16 5:53 AM, Adam Thomson wrote:
> This adds "DLGS7219" ACPI id for the codec.

A valid ACPI ID, the first in a long time on this mailing list :-)

>
> Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
> ---
>  sound/soc/codecs/da7219.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
> index bc32322..da268b8 100644
> --- a/sound/soc/codecs/da7219.c
> +++ b/sound/soc/codecs/da7219.c
> @@ -1428,6 +1428,12 @@ static const struct of_device_id da7219_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, da7219_of_match);
>
> +static const struct acpi_device_id da7219_acpi_match[] = {
> +	{ .id = "DLGS7219", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, da7219_acpi_match);
> +
>  static enum da7219_micbias_voltage
>  	da7219_of_micbias_lvl(struct device *dev, u32 val)
>  {
> @@ -1957,6 +1963,7 @@ static struct i2c_driver da7219_i2c_driver = {
>  	.driver = {
>  		.name = "da7219",
>  		.of_match_table = of_match_ptr(da7219_of_match),
> +		.acpi_match_table = ACPI_PTR(da7219_acpi_match),
>  	},
>  	.probe		= da7219_i2c_probe,
>  	.remove		= da7219_i2c_remove,
> --
> 1.9.3
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
