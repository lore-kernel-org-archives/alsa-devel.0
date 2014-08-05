From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: place codec into
	reset state initially
Date: Tue, 5 Aug 2014 10:34:33 +0300
Message-ID: <53E08909.3000708@ti.com>
References: <1407190401-3712-1-git-send-email-housel@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D69A261ADA
 for <alsa-devel@alsa-project.org>; Tue,  5 Aug 2014 09:34:39 +0200 (CEST)
In-Reply-To: <1407190401-3712-1-git-send-email-housel@acm.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Peter S. Housel" <housel@acm.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/05/2014 01:13 AM, Peter S. Housel wrote:
> Previously the driver would only place the TLV320AIC31XX into reset
> using the gpio reset line when at least one of the power supply
> regulators was disabled, so that if these supplies were always enabled
> no reset would ever occur. This change resets the codec state at probe
> time so that the initial register cache values are correct.
>
> Signed-off-by: Peter S. Housel <housel@acm.org>
> ---
>   sound/soc/codecs/tlv320aic31xx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
> index 0f64c78..89a4daf 100644
> --- a/sound/soc/codecs/tlv320aic31xx.c
> +++ b/sound/soc/codecs/tlv320aic31xx.c
> @@ -1194,7 +1194,7 @@ static int aic31xx_device_init(struct aic31xx_priv *aic31xx)
>   	if (aic31xx->pdata.gpio_reset) {
>   		ret = devm_gpio_request_one(aic31xx->dev,
>   					    aic31xx->pdata.gpio_reset,
> -					    GPIOF_OUT_INIT_HIGH,
> +					    GPIOF_OUT_INIT_LOW,
>   					    "aic31xx-reset-pin");
>   		if (ret < 0) {
>   			dev_err(aic31xx->dev, "not able to acquire gpio\n");
>

Oops, aic3111 and friends indeed have an active low reset line. The line 
was not behind a gpio on my board.

Acked-by: Jyri Sarha <jsarha@ti.com>
