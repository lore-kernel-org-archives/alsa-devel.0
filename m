From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] ASoC: OMAP4: Add HDMI Audio machine
 driver for OMAP4 boards
Date: Thu, 5 May 2011 09:25:17 +0100
Message-ID: <20110505082516.GG11744@opensource.wolfsonmicro.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
	<1304580113-24819-6-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A79DB10393D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 10:25:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1304580113-24819-6-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 02:21:52AM -0500, Ricardo Neri wrote:

> +static struct snd_soc_dai_link omap4_hdmi_dai = {
> +		.name = "HDMI",
> +		.stream_name = "HDMI",

Indentation.

> +static __devinit int omap4_hdmi_probe(struct platform_device *pdev)
> +{
> +	struct snd_soc_card *card = &snd_soc_omap4_hdmi;
> +	int ret;
> +
> +	if (!cpu_is_omap44xx()) {
> +		dev_err(&pdev->dev, "Not running on OMAP4!\n");
> +		return -ENODEV;
> +	}

Why check this?  If the system can't support the DAIs they won't
register so it's redundant and it means more work for OMAP5.

> +	card->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, card);

The set_drvdata() isn't needed.

> +	snd_soc_unregister_card(card);
> +	platform_set_drvdata(pdev, NULL);

You never need to reset driver data on unregister, nothing should
reference it except a driver.

> +MODULE_AUTHOR("Ricardo Neri <ricardo.neri@ti.com>");
> +MODULE_DESCRIPTION("OMAP4 HDMI machine ASoC driver");
> +MODULE_LICENSE("GPL");

MODULE_ALIAS().
