From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: TWL6040: Correct widget handling
	for drivers
Date: Thu, 20 May 2010 16:18:33 -0700
Message-ID: <1274397513.2698.2052.camel@finisterre.wolfsonmicro.main>
References: <1274395988-19801-1-git-send-email-jorge.candelaria@ti.com>
	<1274395988-19801-2-git-send-email-jorge.candelaria@ti.com>
	<1274395988-19801-3-git-send-email-jorge.candelaria@ti.com>
	(sfid-20100521_000534_769304_E6263784)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8FE3C103815
	for <alsa-devel@alsa-project.org>;
	Fri, 21 May 2010 01:18:24 +0200 (CEST)
In-Reply-To: <1274395988-19801-3-git-send-email-jorge.candelaria@ti.com>
	(sfid-20100521_000534_769304_E6263784)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Cc: Margarita Olaya Cabrera <magi.olaya@ti.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-05-20 at 17:53 -0500, Jorge Eduardo Candelaria wrote:

> Also, add a pop_time of 1 ms to leave time for DACs to settle before
> continuing power up/down sequence.

...

> @@ -1105,6 +1092,7 @@ static int __devinit twl6040_codec_probe(struct platform_device *pdev)
>  	priv->naudint = naudint;
>  
>  	codec = &priv->codec;
> +	codec->pop_time = 1;
>  	codec->dev = &pdev->dev;
>  	twl6040_dai.dev = &pdev->dev;

That's not something you should be doing in your CODEC driver. pop_time
is a debugging tool which can be enabled by users but should not be used
in production. Besides, it'll also apply to all power changes in the
CODEC, not just the ones that need it, and so make the general operation
of the device much slower than it needs to be.

If you need to insert a delay after power up of the DAC widgets use the
_E variant of the DAC widget and have a POST_PMU event handler which
does the sleep.
