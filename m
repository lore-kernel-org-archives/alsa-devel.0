From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] General fix for Palm27x aSoC driver
Date: Sun, 12 Apr 2009 18:06:26 +0100
Message-ID: <20090412170626.GD4295@sirena.org.uk>
References: <200904121858.42931.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F3A42103805
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Apr 2009 19:06:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200904121858.42931.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 12, 2009 at 06:58:42PM +0200, Marek Vasut wrote:

> +static struct platform_device palmld_pxa2xx_pcm = {
> +	.name = "pxa2xx-pcm",
> +	.id   = -1,
> +};

This should follow the pattern that everything else uses with the struct
platform_device in devices.c and board files triggering registration of
that.

> +static struct platform_device palmld_pxa2xx_ac97 = {
> +	.name = "pxa2xx-ac97",
> +	.id   = -1,
> +	.dev  = {
> +		.platform_data = &palmld_ac97_pdata,
> +	},
> +};

No, use pxa_set_ac97_info().

> +static struct platform_device palmld_wm9712_codec = {

No, the WM9712 is not a platform device.
