From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 4/5] pxa2xx-lib: support building for
	several pxa's
Date: Mon, 8 Sep 2008 11:17:24 +0100
Message-ID: <20080908101723.GD790@sirena.org.uk>
References: <20080908085339.GA31573@doriath.ww600.siemens.net>
	<1220864773-31745-1-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-2-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-3-git-send-email-dbaryshkov@gmail.com>
	<1220864773-31745-4-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9610F243B1
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 12:17:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220864773-31745-4-git-send-email-dbaryshkov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Russ Dill <russ.dill@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 08, 2008 at 01:06:12PM +0400, Dmitry Baryshkov wrote:

> Here's a version of the third patch in the series without all the
> cpu_is_pxa3xx())'s around the pxa_gpio_mode's? Also, there was a build
> error when just building the sound/arm pxa2xx-ac97.

If there's a build error introduced by the earlier patch it ought to be
fixed there rather than in a subsequent patch?

> -#ifdef CONFIG_PXA3xx
> -#define GCR_CLKBPB	(1 << 31)	/* Internal clock enable */
> -#endif
> +#define GCR_CLKBPB	(1 << 31)	/* Internal clock enable, PXA3XX only */

At least this hunk needs to at least get acked by rmk, and would
probably need to go via the ARM tree.

> +	if (!cpu_is_pxa3xx()) {
> +		pxa_gpio_mode(GPIO31_SYNC_AC97_MD);
> +		pxa_gpio_mode(GPIO30_SDATA_OUT_AC97_MD);
> +		pxa_gpio_mode(GPIO28_BITCLK_AC97_MD);
> +		pxa_gpio_mode(GPIO29_SDATA_IN_AC97_MD);
> +	}

I'd rather do this by explicitly identifying the PXA2xx CPUs (on the
basis that Marvell are producing new PXA variants but the set of PXA2xx
CPUs should be fixed now).

> --- a/sound/soc/pxa/pxa2xx-i2s.c
> +++ b/sound/soc/pxa/pxa2xx-i2s.c

This should be split into a separate patch - it's not directly related
to the other changes except in terms of the overall goal and covers a
different driver.  It's also not mentioned in the patch description.
