From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Convert bitfields in ASOC into full int
	width
Date: Wed, 23 Jul 2008 11:30:27 +0100
Message-ID: <20080723103024.GA8377@sirena.org.uk>
References: <20080723030135.21577.69012.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id D971A2473E
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jul 2008 12:30:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723030135.21577.69012.stgit@terra>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 11:01:35PM -0400, Jon Smirl wrote:

> Convert bitfields in ASOC into full int width. This needs testing, I don't have sample controls for all of the different configurations. This is a simple mechanical conversion, behavior should not be changed. I did find two places in the DAPM code where max was being used as a mask. I fixed them to convert max to a mask, was this right?

Might want to look at your line wrapping here :) .

The patch looks like a good approach and should work - the issues below
a look fixable.

When I tried testing this patch I found that SOC_ENUM no longer builds -
the first error is 'error: extra brace group at end of initializer'.
Looks like that needs adjusting as well.  There's also rather a lot of
checkpatch warnings, mostly lines over 80 columns and whitespace errors.

> +/* mixer control */
> +struct mixer_control {
> +	int min, max;
> + 	uint reg, rreg, shift, rshift, invert;
> +};

This should be namespaced - soc_mixer_control, snd_soc_mixer_control or
simlar.

> @@ -104,10 +104,12 @@ static void dapm_set_path_status(struct snd_soc_dapm_widget *w,
>  	case snd_soc_dapm_switch:
>  	case snd_soc_dapm_mixer: {
>  		int val;
> -		int reg = w->kcontrols[i].private_value & 0xff;
> -		int shift = (w->kcontrols[i].private_value >> 8) & 0x0f;
> -		int mask = (w->kcontrols[i].private_value >> 16) & 0xff;
> -		int invert = (w->kcontrols[i].private_value >> 24) & 0x01;
> +		struct mixer_control *mc = (struct mixer_control *)w->kcontrols[i].private_value; 
> +		uint reg = mc->reg;
> +		uint shift = mc->shift;
> +		int max = mc->max;
> +		uint mask = (1 << fls(max)) - 1;
> +		uint invert = mc->invert;

What the original code is doing here is checking to see if the control
is on at all.
