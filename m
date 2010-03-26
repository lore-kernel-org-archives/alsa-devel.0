From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] WM8750: Convert to new API
Date: Fri, 26 Mar 2010 10:39:37 +0000
Message-ID: <20100326103936.GA18685@rakim.wolfsonmicro.main>
References: <1269570193-8151-1-git-send-email-marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8202B24158
	for <alsa-devel@alsa-project.org>; Fri, 26 Mar 2010 11:39:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1269570193-8151-1-git-send-email-marek.vasut@gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 26, 2010 at 03:23:13AM +0100, Marek Vasut wrote:

> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.

Looks good - a few smallish points below, but basically it's OK.  Thanks
for sorting out git send-email, it really is much easier to work with.

It'd be best to also do the register cache thing like Liam said.  Some
other stuff...

> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
> ---
>  sound/soc/codecs/wm8750.c |  411 +++++++++++++++++++++++++--------------------

You also need to push out registration of the WM8750 out into the
machine drivers using it (spitz and jive).  Look at how the transition
was done for wm8731 for an example.

> -#define WM8750_VERSION "0.12"

This is already done in for-2.6.35 - in general you should always try to
make sure your patches apply against -next (which for ASoC has the
current for-2.6.xx branch in it).

> @@ -688,6 +734,11 @@ static int wm8750_resume(struct platform_device *pdev)
>  	for (i = 0; i < ARRAY_SIZE(wm8750_reg); i++) {
>  		if (i == WM8750_RESET)
>  			continue;
> +
> +		/* No point in writing hardware default values back */
> +		if (cache[i] == wm8750_reg[i])
> +			continue;
> +
>  		data[0] = (i << 1) | ((cache[i] >> 8) & 0x0001);
>  		data[1] = cache[i] & 0x00ff;
>  		codec->hw_write(codec->control_data, data, 2);

This should be done separately since while it's useful it's not really
related to the rest of your change.  This is something that frequently
comes up with your patches.  The general idea here is that each patch
should do exactly one thing which is fully described in the changelog.
This makes each individual patch simpler, making review easier (since
it's much clearer what each individual line in the diff is supposed to
do) and makes trawling the source with things like git bisect or git
annotate more useful for similar reasons.

> +/*
> + * This function forces any delayed work to be queued and run.
> + */
> +static int run_delayed_work(struct delayed_work *dwork)
> +{
> +	int ret;

This is also gone in current for-2.6.35, it shouldn't be so important
any more with current ASoC.
