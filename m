From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: WM8985: Register notifier for the
 regulator being disabled
Date: Wed, 29 Sep 2010 10:43:23 -0700
Message-ID: <20100929174322.GA31934@opensource.wolfsonmicro.com>
References: <1285756717-27149-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F54E1037EA
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Sep 2010 19:43:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1285756717-27149-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 29, 2010 at 11:38:37AM +0100, Dimitris Papastamos wrote:
> Make sure we get an event when the regulator is disabled so we know
> we have to sync the cache afterwards.

Note that the whole callback thing is more important for things with
idle_bias_off (which might get the regulators powered down at runtime)
than for other things which don't go down to _BIAS_OFF at runtime so
would only trigger the callback on suspend anyway.

Not a problem doing the work, it'll just be unlikely to get called at
runtime.

> Minor stylistic changes.

Always split different things out into separate patches unless they
overlap with each other a lot.

> +/*
> + * We can't use the same notifier block for more than one supply and
> + * there's no way I can see to get from a callback to the caller
> + * except container_of().
> + */

Jarkko's way of doing this was a bit nicer, but both aren't great :(

> @@ -782,7 +806,7 @@ static int wm8985_set_pll(struct snd_soc_dai *dai, int pll_id,
>  {
>  	int ret;
>  	struct snd_soc_codec *codec;
> -	struct pll_div pll_div;
> +	struct pll_div pll_div = { 0 };
>  
>  	codec = dai->codec;
>  	if (freq_in && freq_out) {

It's better to restructure the code so that the compiler is able to
follow the control flow and see that there's no uninitialised access -
this sort of change will just shut up legitimate warnings as well.  Some
of the other CODEC drivers (wm8400 is one) have had similar changes
which seem to do the trick.
