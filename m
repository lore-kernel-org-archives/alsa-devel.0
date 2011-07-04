From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC] ASoC: Add machine driver for i.MX SGTL500
	based boards
Date: Mon, 4 Jul 2011 12:23:22 -0700
Message-ID: <20110704192322.GB32624@opensource.wolfsonmicro.com>
References: <1309804915-27544-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 26F0F103874
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jul 2011 21:23:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309804915-27544-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2011 at 03:41:55PM -0300, Fabio Estevam wrote:

> sgtl5000 1-000a: sgtl5000 revision 17                                           
> sgtl5000 1-000a: asoc: failed to probe CODEC sgtl5000.1-000a: -22               
> asoc: failed to instantiate card sgtl5000: -22                                  

Have you looked to see where the error is coming from?

> +	ret = snd_soc_dai_set_sysclk(codec_dai, SGTL5000_LRCLK,
> +						params_rate(params), 0);
> +
> +	if (ret) {
> +		pr_err("%s: failed setting codec sysclk\n", __func__);
> +		return ret;
> +	}

Fix this in the CODEC driver, copying this code into the machine drivers
is clearly not useful.

> +static int __init imx_sgtl5000_init(void)
> +{
> +	int ret;
> +
> +	imx_sgtl5000_snd_device = platform_device_alloc("soc-audio", -1);
> +	if (!imx_sgtl5000_snd_device)
> +		return -ENOMEM;

We're not accepting new drivers using soc-audio, you should use a
regular platform device and register the card with snd_soc_register_card().
