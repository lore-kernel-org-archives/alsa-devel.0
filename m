From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Clean up ASOC functions to support 32b
	values instead of 16b
Date: Thu, 24 Jul 2008 10:56:38 +0100
Message-ID: <20080724095637.GB3444@sirena.org.uk>
References: <20080723233635.6900.55269.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9ECD124937
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Jul 2008 11:56:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080723233635.6900.55269.stgit@terra>
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

On Wed, Jul 23, 2008 at 07:36:35PM -0400, Jon Smirl wrote:

> Clean up ASOC functions to support 32b values instead of 16b

As it stands there's also a mix of unsigned int and u32 in here which
you've already said you'll address.

Could you please provide a more detailed changelog when you resubmit
this?  Explaining the mechanics of the change you've made would make it
a bit easier to review - obviously, much of it is replacing unsigned
short in the register parameters but there's other changes in there like
switching from signed to unsigned types.  It may be that it could
usefully be split into multiple patches, each doing one mechanical
change but possibly not.

<petty>Also, it's spelt "ASoC".</petty>

> @@ -221,7 +221,7 @@ static int dapm_update_bits(struct snd_soc_dapm_widget *widget)
>  
>  	power = widget->power;
>  	if (widget->invert)
> -		power = (power ? 0:1);
> +		power = (power ? 0 : 1);
>  
>  	old = snd_soc_read(codec, widget->reg);
>  	new = (old & ~(0x1 << widget->shift)) | (power << widget->shift);

This change is reasonable enough but unrelated to the rest of the
patch...

> @@ -755,10 +755,10 @@ static int dapm_mixer_update_power(struct snd_soc_dapm_widget *widget,
>  		found = 1;
>  		if (val)
>  			/* new connection */
> -			path->connect = invert ? 0:1;
> +			path->connect = invert ? 0 : 1;
>  		else
>  			/* old connection must be powered down */
> -			path->connect = invert ? 1:0;
> +			path->connect = invert ? 1 : 0;
>  		break;
>  	}
>  

Ditto.
