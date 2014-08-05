From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: Add support for CS35L32 Boosted Amplifier
Date: Tue, 5 Aug 2014 09:31:13 -0500
Message-ID: <alpine.DEB.2.02.1408050928220.7394@heelrod>
References: <1407183077-23807-1-git-send-email-brian.austin@cirrus.com>
 <53E05458.6080605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53E05458.6080605-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org


On Mon, 4 Aug 2014, Varka Bhadram wrote:

> On 08/05/2014 01:41 AM, Brian Austin wrote:
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/version.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/delay.h>
> > +#include <linux/i2c.h>
> > +#include <linux/gpio.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/of_device.h>
> > +#include <linux/slab.h>
> > +#include <sound/core.h>
> > +#include <sound/pcm.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/soc.h>
> > +#include <sound/soc-dapm.h>
> > +#include <sound/initval.h>
> > +#include <sound/tlv.h>
> > +#include <dt-bindings/sound/cs35l32.h>
> > +
> > +#include "cs35l32.h"
> > +
> 
> includes in alphabetical order...

I don't think that applies to included files outside of standard include 
directories does it?
> 
> > +{
> > +	struct snd_soc_codec *codec = dai->codec;
> > +
> > +	return snd_soc_update_bits(codec, CS35L32_PWRCTL2,
> > +					CS35L32_SDOUT_3ST, tristate << 3);
> 
> return snd_soc_update_bits(codec, CS35L32_PWRCTL2,
> 			   CS35L32_SDOUT_3ST, tristate << 3);
> 
If that is a style issue for submission checkpatch should warn on this 
correct?

> 
> should match open parenthesis's...
> 
>  devm_kzalloc(&i2c_client->dev,
> 	      sizeof(struct cs35l32_platform_data),
> 	      GFP_KERNEL);
> 
checkpatch?

> -- 
> Regards,
> Varka Bhadram.
> 
> 
Thanks,
Brian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
