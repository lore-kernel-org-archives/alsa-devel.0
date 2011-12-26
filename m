From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: jz4740: Convert qi_lb60 to use
	snd_soc_register_card()
Date: Mon, 26 Dec 2011 11:33:00 +0100
Message-ID: <4EF84D5C.2010908@metafoo.de>
References: <1324873802.23831.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 35343103821
	for <alsa-devel@alsa-project.org>; Mon, 26 Dec 2011 11:33:48 +0100 (CET)
In-Reply-To: <1324873802.23831.1.camel@phoenix>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: alsa-devel@alsa-project.org

On 12/26/2011 05:30 AM, Axel Lin wrote:
> Use snd_soc_register_card() instead of creating a "soc-audio" platform device.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> v2: fix a typo in v1. 
> Only compile tested, I appreciate if someone can test it.

Hi,

Looks good on first sight. One minor comment inline though. I wont have access
to the hardware until new year, so I can't test the patch right now.

Thanks,
- Lars

> 
>  arch/mips/jz4740/board-qi_lb60.c |    6 ++++
>  sound/soc/jz4740/qi_lb60.c       |   56 +++++++++++++++++--------------------
>  2 files changed, 32 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/mips/jz4740/board-qi_lb60.c b/arch/mips/jz4740/board-qi_lb60.c
> index 639e3ce..9a91fe9 100644
> --- a/arch/mips/jz4740/board-qi_lb60.c
> +++ b/arch/mips/jz4740/board-qi_lb60.c
> @@ -418,6 +418,11 @@ static struct platform_device qi_lb60_charger_device = {
> [...]
>  
> -static void __exit qi_lb60_exit(void)
> +static int __devexit qi_lb60_remove(struct platform_device *pdev)
>  {
> -	platform_device_unregister(qi_lb60_snd_device);
> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
> +
>  	gpio_free_array(qi_lb60_gpios, ARRAY_SIZE(qi_lb60_gpios));
> +	snd_soc_unregister_card(card);

It's probably better to free the card before the GPIOs since the card uses the
GPIOs.

> +	return 0;
>  }
> -module_exit(qi_lb60_exit);
> +
> +static struct platform_driver qi_lb60_driver = {
> +	.driver		= {
> +		.name	= "qi-lb60-audio",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= qi_lb60_probe,
> +	.remove		= __devexit_p(qi_lb60_remove),
> +};
> +
> +module_platform_driver(qi_lb60_driver);
>  
>  MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
>  MODULE_DESCRIPTION("ALSA SoC QI LB60 Audio support");
>  MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:qi-lb60-audio");
