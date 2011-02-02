From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] EDB93xx: Add support for CS4271 CODEC
	on	EDB93xx boards
Date: Wed, 2 Feb 2011 10:51:47 +0000
Message-ID: <20110202105146.GA9810@sirena.org.uk>
References: <1296603653.1504.9.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 847BC1039B4
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 11:51:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1296603653.1504.9.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander Sverdlin <subaparts@yandex.ru>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, H Hartley Sweeten <hsweeten@visionengravers.com>, linux-arm-kernel@lists.infradead.org, Lennert Buytenhek <buytenh@wantstofly.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 02, 2011 at 02:40:53AM +0300, Alexander Sverdlin wrote:

> +	err = gpio_request(gpio_nreset, spi->modalias);
> +	if (err)
> +		return err;
> +	err = gpio_request(EP93XX_GPIO_LINE_EGPIO6, spi->modalias);
> +	if (err)
> +		return err;
> +
> +	gpio_direction_output(EP93XX_GPIO_LINE_EGPIO6, 1);

Why is this stuff in the arch/arm code?  I'd expect driver to deal with
all this sequencing.
