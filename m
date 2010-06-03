From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC][PATCH 26/26] alsa: ASoC: JZ4740: Add qi_lb60
	board driver
Date: Thu, 3 Jun 2010 18:57:15 +0100
Message-ID: <20100603175714.GJ2762@rakim.wolfsonmicro.main>
References: <1275505397-16758-1-git-send-email-lars@metafoo.de>
	<1275506132-17519-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 399B0103B0C
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Jun 2010 19:57:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1275506132-17519-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-mips@linux-mips.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 02, 2010 at 09:15:32PM +0200, Lars-Peter Clausen wrote:

> +	ret = gpio_request(QI_LB60_SND_GPIO, "SND");
> +	if (ret) {
> +		pr_err("qi_lb60 snd: Failed to request SND GPIO(%d): %d\n",
> +				QI_LB60_SND_GPIO, ret);
> +		goto err_device_put;
> +	}
> +
> +	ret = gpio_request(QI_LB60_AMP_GPIO, "AMP");
> +	if (ret) {
> +		pr_err("qi_lb60 snd: Failed to request AMP GPIO(%d): %d\n",
> +				QI_LB60_AMP_GPIO, ret);
> +		goto err_gpio_free_snd;
> +	}
> +
> +	gpio_direction_output(JZ_GPIO_PORTB(29), 0);
> +	gpio_direction_output(JZ_GPIO_PORTD(4), 0);

You're referring to the GPIOs by multiple different names - it'd be more
robust to pick one way of naming them and use it consistently (probably
the #define).
