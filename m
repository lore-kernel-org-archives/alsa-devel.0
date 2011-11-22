From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Fix wrong define for
	AD1836_ADC_WORD_OFFSET
Date: Tue, 22 Nov 2011 13:39:04 +0100
Message-ID: <4ECB97E8.9040705@metafoo.de>
References: <1321926411.4764.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-153.synserver.de (smtp-out-157.synserver.de
	[212.40.185.157]) by alsa0.perex.cz (Postfix) with SMTP id A437924157
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 13:38:19 +0100 (CET)
In-Reply-To: <1321926411.4764.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 11/22/2011 02:46 AM, Axel Lin wrote:
> According to the datasheet:
> The BIT[5:4] of ADC Control Register 2 is to control the word width.
>         00 = 25 Bits
>         01 = 20 Bits
>         10 = 16 Bits
>         11 = Invalid
> 
> Thus, the AD1836_ADC_WORD_OFFSET should be defined as 4.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

> ---
>  sound/soc/codecs/ad1836.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad1836.h b/sound/soc/codecs/ad1836.h
> index 444747f..dd7be0d 100644
> --- a/sound/soc/codecs/ad1836.h
> +++ b/sound/soc/codecs/ad1836.h
> @@ -34,7 +34,7 @@
>  
>  #define AD1836_ADC_CTRL2               13
>  #define AD1836_ADC_WORD_LEN_MASK       0x30
> -#define AD1836_ADC_WORD_OFFSET         5
> +#define AD1836_ADC_WORD_OFFSET         4
>  #define AD1836_ADC_SERFMT_MASK         (7 << 6)
>  #define AD1836_ADC_SERFMT_PCK256       (0x4 << 6)
>  #define AD1836_ADC_SERFMT_PCK128       (0x5 << 6)
