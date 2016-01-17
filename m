From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Sat, 16 Jan 2016 18:10:53 -0600
Message-ID: <569ADC0D.2000807@tabi.org>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <5693B4C1.4060400@maciej.szmigiero.name>
 <CAOMZO5DVKrnufV_PLD_+7FgA=ePhn1DSpzYDQPy5FZvHyGOJ-g@mail.gmail.com>
 <569AD8A7.7080803@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <569AD8A7.7080803@maciej.szmigiero.name>
Sender: linux-kernel-owner@vger.kernel.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Maciej S. Szmigiero wrote:
> +static const struct regmap_config fsl_ssi_regconfig_imx21 = {
> +	.max_register = CCSR_SSI_SRMSK,
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> +	.num_reg_defaults_raw = CCSR_SSI_SRMSK / 4 + 1,
> +	.readable_reg = fsl_ssi_readable_reg,
> +	.volatile_reg = fsl_ssi_volatile_reg,
> +	.precious_reg = fsl_ssi_precious_reg,
> +	.writeable_reg = fsl_ssi_writeable_reg,
> +	.cache_type = REGCACHE_RBTREE,
> +};
> +
>   static const struct regmap_config fsl_ssi_regconfig = {
>   	.max_register = CCSR_SSI_SACCDIS,
>   	.reg_bits = 32,
>   	.val_bits = 32,
>   	.reg_stride = 4,
>   	.val_format_endian = REGMAP_ENDIAN_NATIVE,
> -	.reg_defaults = fsl_ssi_reg_defaults,
> -	.num_reg_defaults = ARRAY_SIZE(fsl_ssi_reg_defaults),
> +	.num_reg_defaults_raw = CCSR_SSI_SACCDIS / 4 + 1,
>   	.readable_reg = fsl_ssi_readable_reg,
>   	.volatile_reg = fsl_ssi_volatile_reg,
>   	.precious_reg = fsl_ssi_precious_reg,

Is this really necessary?  Why do we need separate register configs for 
one specific SOC?  There are already too many "if 
(some_stupid_imx_variant)" blocks in this driver.
