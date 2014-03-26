From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/3] ASoC: ak4104: add regulator consumer
 support
Date: Wed, 26 Mar 2014 16:06:49 +0100
Message-ID: <5332ED09.3090209@gmail.com>
References: <1395829378-13055-1-git-send-email-zonque@gmail.com>
 <1395829378-13055-2-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 869CD264FEE
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 16:07:09 +0100 (CET)
Received: by mail-bk0-f41.google.com with SMTP id d7so595966bkh.0
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 08:07:09 -0700 (PDT)
In-Reply-To: <1395829378-13055-2-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 03/26/2014 11:22 AM, Daniel Mack wrote:
> The AK4104 has only one power supply, called VDD. Make sure it is
> enabled during the life-time of the module.

Sorry, I just noticed there was an update for this driver in the ASoC
for-next branch that causes a trivial conflict for this particular
patch. If desired, I can resend a rebased version. The other two patches
are unaffected.


> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  sound/soc/codecs/ak4104.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/ak4104.c b/sound/soc/codecs/ak4104.c
> index b4819dc..c7a541d 100644
> --- a/sound/soc/codecs/ak4104.c
> +++ b/sound/soc/codecs/ak4104.c
> @@ -11,13 +11,14 @@
>  
>  #include <linux/module.h>
>  #include <linux/slab.h>
> -#include <sound/core.h>
> -#include <sound/soc.h>
> -#include <sound/initval.h>
>  #include <linux/spi/spi.h>
>  #include <linux/of_device.h>
>  #include <linux/of_gpio.h>
> +#include <linux/regulator/consumer.h>
>  #include <sound/asoundef.h>
> +#include <sound/core.h>
> +#include <sound/soc.h>
> +#include <sound/initval.h>
>  
>  /* AK4104 registers addresses */
>  #define AK4104_REG_CONTROL1		0x00
> @@ -47,6 +48,7 @@
>  
>  struct ak4104_private {
>  	struct regmap *regmap;
> +	struct regulator *regulator;
>  };
>  
>  static const struct snd_soc_dapm_widget ak4104_dapm_widgets[] = {
> @@ -176,20 +178,30 @@ static int ak4104_probe(struct snd_soc_codec *codec)
>  
>  	codec->control_data = ak4104->regmap;
>  
> +	ret = regulator_enable(ak4104->regulator);
> +	if (ret < 0) {
> +		dev_err(codec->dev, "Unable to enable regulator: %d\n", ret);
> +		return ret;
> +	}
> +
>  	/* set power-up and non-reset bits */
>  	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
>  				 AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN,
>  				 AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN);
>  	if (ret < 0)
> -		return ret;
> +		goto exit_disable_regulator;
>  
>  	/* enable transmitter */
>  	ret = regmap_update_bits(ak4104->regmap, AK4104_REG_TX,
>  				 AK4104_TX_TXE, AK4104_TX_TXE);
>  	if (ret < 0)
> -		return ret;
> +		goto exit_disable_regulator;
>  
>  	return 0;
> +
> +exit_disable_regulator:
> +	regulator_disable(ak4104->regulator);
> +	return ret;
>  }
>  
>  static int ak4104_remove(struct snd_soc_codec *codec)
> @@ -198,6 +210,7 @@ static int ak4104_remove(struct snd_soc_codec *codec)
>  
>  	regmap_update_bits(ak4104->regmap, AK4104_REG_CONTROL1,
>  			   AK4104_CONTROL1_PW | AK4104_CONTROL1_RSTN, 0);
> +	regulator_disable(ak4104->regulator);
>  
>  	return 0;
>  }
> @@ -241,6 +254,13 @@ static int ak4104_spi_probe(struct spi_device *spi)
>  	if (ak4104 == NULL)
>  		return -ENOMEM;
>  
> +	ak4104->regulator = devm_regulator_get(&spi->dev, "vdd");
> +	if (IS_ERR(ak4104->regulator)) {
> +		ret = PTR_ERR(ak4104->regulator);
> +		dev_err(&spi->dev, "Unable to get Vdd regulator: %d\n", ret);
> +		return ret;
> +	}
> +
>  	ak4104->regmap = devm_regmap_init_spi(spi, &ak4104_regmap);
>  	if (IS_ERR(ak4104->regmap)) {
>  		ret = PTR_ERR(ak4104->regmap);
> 
