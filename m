From: Padma Venkat <padma.kvr@gmail.com>
Subject: Re: [PATCH] ASoC: samsung: Fix non-DT use of I2S
	controller
Date: Mon, 8 Dec 2014 10:21:52 +0530
Message-ID: <CAAgF-Bfv5OaDYu2Ti=9CCoZ9k-1ZhOG-KRfgXJYanKpLWp9ffQ@mail.gmail.com>
References: <1417809427-5126-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f45.google.com (mail-yh0-f45.google.com
 [209.85.213.45])
 by alsa0.perex.cz (Postfix) with ESMTP id B369D260417
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 05:51:53 +0100 (CET)
Received: by mail-yh0-f45.google.com with SMTP id f10so1993823yha.32
 for <alsa-devel@alsa-project.org>; Sun, 07 Dec 2014 20:51:52 -0800 (PST)
In-Reply-To: <1417809427-5126-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Padmavathi Venna <padma.v@samsung.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 12/6/14, Mark Brown <broonie@kernel.org> wrote:
> The changes in commit a5a56871f804e (ASoC: samsung: add support for exynos7
> I2S controller) introduce a new variant_regs structure in the driver data
> which is now mandatory for accessing registers. Unfortunately this is only
> hooked up for DT platforms so non-DT platforms like my primary development
> platform for audio are broken by this change and crash on boot.
>
> Since the only non-DT user of these device is s3c64xx fix this by making
> the standard samsung-i2s device be of type I2Sv3 and add a new I2Sv4 name
> to the platform data section, currently using the I2Sv5 information which
> should be about right.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/samsung/i2s.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
> index e1ace5270a8b..25919e090983 100644
> --- a/sound/soc/samsung/i2s.c
> +++ b/sound/soc/samsung/i2s.c
> @@ -1418,10 +1418,13 @@ static const struct samsung_i2s_dai_data
> samsung_dai_type_sec = {
>  static struct platform_device_id samsung_i2s_driver_ids[] = {
>  	{
>  		.name           = "samsung-i2s",
> -		.driver_data    = (kernel_ulong_t)&samsung_dai_type_pri,
> +		.driver_data	= (kernel_ulong_t)&i2sv3_dai_type,
>  	}, {
>  		.name           = "samsung-i2s-sec",
>  		.driver_data    = (kernel_ulong_t)&samsung_dai_type_sec,
> +	}, {
> +		.name		= "samsung-i2sv4",
> +		.driver_data	= (kernel_ulong_t)&i2sv5_dai_type_i2s1,

I think here you need to use i2sv5_dai_type because
i2sv5_dai_type_i2s1 is introduced for exynos7 on which the i2s1 is of
type v5 but with slightly modified bit offsets.

Thanks
Padma

>  	},
>  	{},
>  };
> --
> 2.1.3
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
