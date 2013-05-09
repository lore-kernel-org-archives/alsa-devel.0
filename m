From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v3] ASoC: sgtl5000: Fix driver probe after
	reset
Date: Thu, 09 May 2013 19:42:12 +0200
Message-ID: <518BDFF4.2070403@metafoo.de>
References: <1368120063-20655-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-139.synserver.de (smtp-out-141.synserver.de
 [212.40.185.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D3AA26072A
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2013 19:42:39 +0200 (CEST)
In-Reply-To: <1368120063-20655-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: matt@genesi-usa.com, alsa-devel@alsa-project.org, broonie@kernel.org, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

On 05/09/2013 07:20 PM, Fabio Estevam wrote:
> sgtl5000 codec does not have a reset line, nor a reset command in software.
> 
> After a 'reboot' command in Linux or after pressing the system's reset button
> the sgtl5000 driver fails to probe:
> 
> sgtl5000 0-000a: Device with ID register ffff is not a sgtl5000
> sgtl5000 0-000a: ASoC: failed to probe CODEC -19
> imx-sgtl5000 sound.12: ASoC: failed to instantiate card -19
> imx-sgtl5000 sound.12: snd_soc_register_card failed (-19)
> 
> As the sgtl5000 codec did not go through a real reset, we cannot rely on the 
> sgtl5000_reg_defaults table, since these are only valid after a clean power-on 
> reset.
> 
> Fix this issue by explicitly reading all the sgtl5000 registers and filling
> sgtl5000_reg_defaults with such values.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

I don't see how this is different from v2, except that it is now opencoding
the register reading and is sharing a driver global variable between
multiple instances (which is kind of a no-go).

> ---
> Changes since v2:
> - Do not use reg_defaults_raw as it is not the correct purpose
> - Manually build sgtl5000_reg_default
> - Improve commitlog
> Changes since v1:
> - Remove sgtl5000_reg_defaults array
> - Do not use num_reg_defaults_raw
> 
>  sound/soc/codecs/sgtl5000.c |   58 ++++++++++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
> index 327b443..311dfb5 100644
> --- a/sound/soc/codecs/sgtl5000.c
> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -35,31 +35,7 @@
>  #define SGTL5000_MAX_REG_OFFSET	0x013A
>  
>  /* default value of sgtl5000 registers */
> -static const struct reg_default sgtl5000_reg_defaults[] = {
> -	{ SGTL5000_CHIP_CLK_CTRL,		0x0008 },
> -	{ SGTL5000_CHIP_I2S_CTRL,		0x0010 },
> -	{ SGTL5000_CHIP_SSS_CTRL,		0x0008 },
> -	{ SGTL5000_CHIP_DAC_VOL,		0x3c3c },
> -	{ SGTL5000_CHIP_PAD_STRENGTH,		0x015f },
> -	{ SGTL5000_CHIP_ANA_HP_CTRL,		0x1818 },
> -	{ SGTL5000_CHIP_ANA_CTRL,		0x0111 },
> -	{ SGTL5000_CHIP_LINE_OUT_VOL,		0x0404 },
> -	{ SGTL5000_CHIP_ANA_POWER,		0x7060 },
> -	{ SGTL5000_CHIP_PLL_CTRL,		0x5000 },
> -	{ SGTL5000_DAP_BASS_ENHANCE,		0x0040 },
> -	{ SGTL5000_DAP_BASS_ENHANCE_CTRL,	0x051f },
> -	{ SGTL5000_DAP_SURROUND,		0x0040 },
> -	{ SGTL5000_DAP_EQ_BASS_BAND0,		0x002f },
> -	{ SGTL5000_DAP_EQ_BASS_BAND1,		0x002f },
> -	{ SGTL5000_DAP_EQ_BASS_BAND2,		0x002f },
> -	{ SGTL5000_DAP_EQ_BASS_BAND3,		0x002f },
> -	{ SGTL5000_DAP_EQ_BASS_BAND4,		0x002f },
> -	{ SGTL5000_DAP_MAIN_CHAN,		0x8000 },
> -	{ SGTL5000_DAP_AVC_CTRL,		0x0510 },
> -	{ SGTL5000_DAP_AVC_THRESHOLD,		0x1473 },
> -	{ SGTL5000_DAP_AVC_ATTACK,		0x0028 },
> -	{ SGTL5000_DAP_AVC_DECAY,		0x0050 },
> -};
> +static struct reg_default sgtl5000_reg_defaults[SGTL5000_MAX_REG_OFFSET + 1];
>  
>  /* regulator supplies for sgtl5000, VDDD is an optional external supply */
>  enum sgtl5000_regulator_supplies {
> @@ -1355,6 +1331,33 @@ err_regulator_free:
>  
>  }
>  
> +/*
> + * Read all the sgtl5000 registers to fill the cache, as
> + * we cannot rely on a pre-defined table containing the
> + * power-on reset values of the registers as done in most
> + * of the other codec drivers.
> + *
> + * We follow this approach here because sgtl5000 does not have
> + * a reset line, nor a reset command in software, and this way
> + * we can guarantee that we always have sane register values
> + * stored in the reg_defaults table after a reset
> + */
> +static int sgtl5000_fill_cache(struct snd_soc_codec *codec)
> +{
> +	int i, reg, ret;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +
> +	for (i = 0; i < SGTL5000_MAX_REG_OFFSET; i += 2) {
> +		ret = regmap_read(sgtl5000->regmap, i, &reg);
> +		if (ret < 0)
> +			return ret;
> +		sgtl5000_reg_defaults[i].reg = i;
> +		sgtl5000_reg_defaults[i].def = reg;
> +	}
> +
> +	return 0;
> +}
> +
>  static int sgtl5000_probe(struct snd_soc_codec *codec)
>  {
>  	int ret;
> @@ -1377,6 +1380,11 @@ static int sgtl5000_probe(struct snd_soc_codec *codec)
>  	if (ret)
>  		goto err;
>  
> +	/* Build the reg_defaults manually by reading the registers */
> +	ret = sgtl5000_fill_cache(codec);
> +	if (ret)
> +		goto err;
> +
>  	/* enable small pop, introduce 400ms delay in turning off */
>  	snd_soc_update_bits(codec, SGTL5000_CHIP_REF_CTRL,
>  				SGTL5000_SMALL_POP,
