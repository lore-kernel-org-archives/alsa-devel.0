From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 2/4] ASoc: rockchip: Add rockchip SPDIF transceiver
 driver
Date: Wed, 29 Jul 2015 10:51:48 +0200
Message-ID: <1438159908.5106.32.camel@tiscali.nl>
References: <1438085011-16577-1-git-send-email-sjoerd.simons@collabora.co.uk>
	 <1438085011-16577-3-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438085011-16577-3-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A nit and a question.

On di, 2015-07-28 at 14:03 +0200, Sjoerd Simons wrote:
> --- /dev/null
> +++ b/sound/soc/rockchip/rockchip_spdif.c

> +#define DRV_NAME "rockchip-spdif"

> +static const struct of_device_id rockchip_spdif_match[] = {
> +	{ .compatible = "rockchip,rk3066-spdif", },
> +	{},
> +};

I didn't spot
    MODULE_DEVICE_TABLE(of, rockchip_spdif_match);

at first. It turned out that that line can be found at the bottom of
this file. Please put it here.

> +static struct platform_driver rockchip_spdif_driver = {
> +	.probe = rockchip_spdif_probe,
> +	.remove = rockchip_spdif_remove,
> +	.driver = {
> +		.name = DRV_NAME,
> +		.of_match_table = of_match_ptr(rockchip_spdif_match),
> +		.pm = &rockchip_spdif_pm_ops,
> +	},
> +};
> +module_platform_driver(rockchip_spdif_driver);

> +MODULE_ALIAS("platform:" DRV_NAME);

(I seem to remember that Mark Brown is OK with this, at least for the
time being, but for future reference I'll ask the question anyway.) Is
there a corresponding struct platform_device with a "rockchip-spdif"
.name? Because if there's no such platform_device I think this line
doesn't really do anything for this driver.

> +MODULE_DEVICE_TABLE(of, rockchip_spdif_match);

Thanks,


Paul Bolle
