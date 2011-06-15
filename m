From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ALSA: ASoC: add WM8782 ADC Codec Driver
Date: Wed, 15 Jun 2011 16:17:22 +0100
Message-ID: <20110615151721.GD2806@opensource.wolfsonmicro.com>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
	<1308079626-31239-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DD611248C4
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 17:17:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1308079626-31239-3-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 14, 2011 at 09:27:06PM +0200, Daniel Mack wrote:

> +		.rates = SNDRV_PCM_RATE_48000,

Datasheet says 8kHz to 192kHz are supported, there's a pin strap to
select 96kHz and 192kHz rates so those could be omitted with a comment
at a first pass.

> +               .formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,

20 bit is also supported.

> +	.driver = {
> +		.name = "wm8782-codec",

Drop the -codec - not only is it redundant but the device is an ADC
only.

> +		.owner = THIS_MODULE,
> +	},
> +	.probe = wm8782_probe,
> +	.remove = wm8782_remove,
> +};
> +
> +static int __init wm8782_init(void)
> +{
> +	return platform_driver_register(&wm8782_codec_driver);
> +}
> +module_init(wm8782_init);
> +
> +static void __exit wm8782_exit(void)
> +{
> +	platform_driver_unregister(&wm8782_codec_driver);
> +}
> +module_exit(wm8782_exit);
> +
> +MODULE_DESCRIPTION("ASoC WM8782 driver");
> +MODULE_AUTHOR("Johannes Stezenbach <js@sig21.net>");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.5.1
> 
