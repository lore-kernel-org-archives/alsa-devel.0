From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] tlv320aic3x: headset/button press support
Date: Thu, 27 Nov 2008 11:50:21 +0000
Message-ID: <20081127114951.GA3933@sirena.org.uk>
References: <20081126220742.GA24648@buzzloop.caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3599624540
	for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2008 13:32:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081126220742.GA24648@buzzloop.caiaq.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@caiaq.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 26, 2008 at 11:07:42PM +0100, Daniel Mack wrote:

> Hi,

As previously mentioned it'd be really helpful if you could submit
patches in the standard format in Documentation/SubmittingPatches.
Even if you need to use an attachment for the code pleasee don't submit
two separate changelogs as you currently do.

> +void aic3x_set_headset_detection(struct snd_soc_codec *codec, int val)
> +{
> +	u8 reg_a = val & 0xff;
> +	if (reg_a & (3 << 5))
> +		reg_a |= 0x80;

This is a little obscure...  Why are you munging the set value like
this?  Replacing (3 << 5) with the constants from the header may help.
Looking at the defines below I can't help but think that it'd be clearer
to pass in three parameters - what to detect and the two debounce times.

>  int aic3x_headset_detected(struct snd_soc_codec *codec)
>  {
>  	u8 val;
> -	aic3x_read(codec, AIC3X_RT_IRQ_FLAGS_REG, &val);
> -	return (val >> 2) & 1;
> +	aic3x_read(codec, AIC3X_HEADSET_DETECT_CTRL_B, &val);
> +	return (val >> 4) & 1;
>  }
>  EXPORT_SYMBOL_GPL(aic3x_headset_detected);

How is the interrupt deasserted?  Are you sure that the interrupt will
be cleared if you don't read the interrupt flags register?  May be worth
splitting out, it's not directly part of the rest of the patch.

> +
> +/* headset detection / button API, logically OR the values
> + * on calls to aic3x_set_headset_detection(). */

This could go in kerneldoc for the function as well.

> +#define AIC3X_HEADSET_DETECT_OFF	(0 << 5)
> +#define AIC3X_HEADSET_DETECT_STEREO	(1 << 5)
> +#define AIC3X_HEADSET_DETECT_CELLULAR	(2 << 5)
> +#define AIC3X_HEADSET_DETECT_BOTH	(3 << 5)

What exactly is CELLULAR?  A headset?
