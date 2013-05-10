From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH v5 2/2] ASoC: sgtl5000: Fix driver probe
	after reset
Date: Thu, 09 May 2013 18:17:02 -0700
Message-ID: <518C4A8E.6020501@boundarydevices.com>
References: <1368144947-23775-1-git-send-email-festevam@gmail.com>
 <1368144947-23775-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f169.google.com (mail-pd0-f169.google.com
 [209.85.192.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D0522608A2
 for <alsa-devel@alsa-project.org>; Fri, 10 May 2013 03:17:05 +0200 (CEST)
Received: by mail-pd0-f169.google.com with SMTP id bv13so2384530pdb.14
 for <alsa-devel@alsa-project.org>; Thu, 09 May 2013 18:17:04 -0700 (PDT)
In-Reply-To: <1368144947-23775-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On 5/9/2013 5:15 PM, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> After a 'reboot' command in Linux or after pressing the system's reset button
> the sgtl5000 driver fails to probe:
>
> sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
> sgtl5000 0-000a: ASoC: failed to probe CODEC -19
> imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
> imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)
>
> sgtl5000 codec does not have a reset line, nor a reset command in software, so
> after a system reset the codec does not contain the default register values
> from sgtl5000_reg_defaults[] anymore, as these are only valid after a
> power-on-reset cycle.
>
> Fix this issue by explicitly reading all the reset register values from
> sgtl5000_reg_defaults[] and writing them back into sgtl5000 to ensure a sane
> state.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v4:
> - Only call sgtl5000_fill_defaults if we know we have a sgtl5000
> Changes since v3:
> - Read sgtl5000_reg_defaults and write these values into sgtl5000
> Changes since v2:
> - Do not use reg_defaults_raw as it is not the correct purpose
> - Manually build sgtl5000_reg_default
> - Improve commitlog
> Changes since v1:
> - Remove sgtl5000_reg_defaults array
> - Do not use num_reg_defaults_raw
>   sound/soc/codecs/sgtl5000.c |   30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
>
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index af0c8aa..ec97636 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -1468,6 +1468,31 @@ static const struct regmap_config sgtl5000_regmap = {
>   	.num_reg_defaults = ARRAY_SIZE(sgtl5000_reg_defaults),
>   };
>   
> +/*
> + * Write all the default values from sgtl5000_reg_defaults[] array into the
> + * sgtl5000 registers, to make sure we always start with the sane registers
> + * values as stated in the datasheet.
> + *
> + * Since sgtl5000 does not have a reset line, nor a reset command in software,
> + * we follow this approach to guarantee we always start from the default values
> + * and avoid problems like, not being able to probe after an audio playback
> + * followed by a system reset or a 'reboot' command in Linux
> + */
> +static int sgtl5000_fill_defaults(struct sgtl5000_priv *sgtl5000)
> +{
> +	int i, ret, val, index;
> +
> +	for (i = 0; i < ARRAY_SIZE(sgtl5000_reg_defaults); i++) {
> +		val = sgtl5000_reg_defaults[i].def;
> +		index = sgtl5000_reg_defaults[i].reg;
> +		ret = regmap_write(sgtl5000->regmap, index, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int sgtl5000_i2c_probe(struct i2c_client *client,
>   			      const struct i2c_device_id *id)
>   {
> @@ -1503,6 +1528,11 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
>   
>   	i2c_set_clientdata(client, sgtl5000);
>   
> +	/* Ensure sgtl5000 will start with sane register values */
> +	ret = sgtl5000_fill_defaults(sgtl5000);
> +	if (ret)
> +		return ret;
> +
>   	ret = snd_soc_register_codec(&client->dev,
>   			&sgtl5000_driver, &sgtl5000_dai, 1);
>   	return ret;

Did you test a reset/reboot ?  Since the fill_defaults now happens after 
the read of the device id,
how does this fix the mentioned problem ?

Troy
