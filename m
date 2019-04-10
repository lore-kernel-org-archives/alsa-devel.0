From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] ASoC: wcd9335: Fix missing regmap requirement
Date: Wed, 10 Apr 2019 15:31:28 +0100
Message-ID: <da5f1653-c668-f587-8fcf-69965f082ea7@linaro.org>
References: <8c0b22e2-2c67-8d45-a57d-dfc54043fbc9@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8c0b22e2-2c67-8d45-a57d-dfc54043fbc9@free.fr>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Gonzalez <marc.w.gonzalez@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org



On 10/04/2019 15:23, Marc Gonzalez wrote:
> wcd9335.c: undefined reference to 'devm_regmap_add_irq_chip'
> 
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
> ---

Thanks for Fix,

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

>   sound/soc/codecs/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 419142111b6d..33778dc99108 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -1162,6 +1162,7 @@ config SND_SOC_WCD9335
>   	tristate "WCD9335 Codec"
>   	depends on SLIMBUS
>   	select REGMAP_SLIMBUS
> +	select REGMAP_IRQ
>   	help
>   	  The WCD9335 is a standalone Hi-Fi audio CODEC IC, supports
>   	  Qualcomm Technologies, Inc. (QTI) multimedia solutions,
> 
