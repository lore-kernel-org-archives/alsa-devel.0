From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: adau1977: Fix truncation warning on
	64 bit architectures
Date: Mon, 04 Aug 2014 09:15:30 +0200
Message-ID: <53DF3312.8010304@metafoo.de>
References: <1406909979-12990-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-032.synserver.de (smtp-out-033.synserver.de
 [212.40.185.33])
 by alsa0.perex.cz (Postfix) with ESMTP id 22EB326158C
 for <alsa-devel@alsa-project.org>; Mon,  4 Aug 2014 09:15:34 +0200 (CEST)
In-Reply-To: <1406909979-12990-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 08/01/2014 06:19 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Negating ADAU1977_BLOCK_POWER_SAI_LDO_EN creates an unsigned long constant
> with all bits set which on 64 bit architectures needs to be truncated to
> an unsigned int, generating a warning. Add an explicit cast since we know
> this is OK.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.


> ---
>   sound/soc/codecs/adau1977.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
> index fd55da7..70ab357 100644
> --- a/sound/soc/codecs/adau1977.c
> +++ b/sound/soc/codecs/adau1977.c
> @@ -968,7 +968,7 @@ int adau1977_probe(struct device *dev, struct regmap *regmap,
>   	if (adau1977->dvdd_reg)
>   		power_off_mask = ~0;
>   	else
> -		power_off_mask = ~ADAU1977_BLOCK_POWER_SAI_LDO_EN;
> +		power_off_mask = (unsigned int)~ADAU1977_BLOCK_POWER_SAI_LDO_EN;
>
>   	ret = regmap_update_bits(adau1977->regmap, ADAU1977_REG_BLOCK_POWER_SAI,
>   				power_off_mask, 0x00);
>
