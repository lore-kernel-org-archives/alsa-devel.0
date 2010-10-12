From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 2/3] kirkwood: Add audio support to hp
 t5325 thin clients
Date: Tue, 12 Oct 2010 18:17:52 +0100
Message-ID: <20101012171752.GH30933@rakim.wolfsonmicro.main>
References: <20101012094453.660938870@rtp-net.org>
	<20101012100038.056291910@rtp-net.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 467B324487
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 19:17:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20101012100038.056291910@rtp-net.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: alsa-devel@alsa-project.org, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2010 at 11:44:55AM +0200, Arnaud Patard wrote:

> +config SND_KIRKWOOD_SOC_T5325
> +	tristate "SoC Audio support for HP t5325"
> +	#depends on SND_KIRKWOOD_SOC && MACH_T5325

Hrm?

> +	switch (params_rate(params)) {
> +	default:
> +	case 44100:
> +		freq = 11289600;
> +		break;
> +	case 48000:
> +		freq = 12288000;
> +		break;
> +	case 96000:
> +		freq = 24576000;
> +		break;
> +	}

This should have a default: or (better) just be rewritten to use
params_rate(params) * 256 as the sysclk.

> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:soc-audio");

No, you're registering the device here not the driver.
