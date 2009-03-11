From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH 2/3][RFC] ASoC: Add Magician machine
 support.
Date: Wed, 11 Mar 2009 22:38:12 +0000
Message-ID: <1236811092.6781.199.camel@vega.slimlogic.co.uk>
References: <1236795420-12175-1-git-send-email-philipp.zabel@gmail.com>
	<1236795420-12175-2-git-send-email-philipp.zabel@gmail.com>
	<20090311222501.GA7536@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AA0C1038BC
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 23:38:22 +0100 (CET)
In-Reply-To: <20090311222501.GA7536@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-03-11 at 22:25 +0000, Mark Brown wrote:
> On Wed, Mar 11, 2009 at 07:16:59PM +0100, Philipp Zabel wrote:
> 
> This is all good except you're missing updates for a few new APIs:
> 
> > +	/* NC codec pins */
> > +	snd_soc_dapm_disable_pin(codec, "VOUTLHP");
> > +	snd_soc_dapm_disable_pin(codec, "VOUTRHP");
> 
> snd_soc_dapm_nc_pin() (currently a synonym but hopefully in the future
> it will gain support for things like masking out controls for that path
> from the UI.
> 
> > +	/* Add magician specific controls */
> > +	for (i = 0; i < ARRAY_SIZE(uda1380_magician_controls); i++) {
> > +		err = snd_ctl_add(codec->card,
> > +				  snd_soc_cnew(&uda1380_magician_controls[i],
> > +						codec, NULL));
> > +		if (err < 0)
> > +			return err;
> > +	}
> 
> snd_soc_add_controls()

I'm thinking we should probably make snd_soc_cnew() static now. It's far
more convenient to use snd_soc_add_controls().

> 
> > +	ret = gpio_request(EGPIO_MAGICIAN_CODEC_RESET, "CODEC_RESET");
> > +	if (ret)
> > +		goto err_request_reset;
> 
> Someone needs to write a bulk GPIO request API...  not an issue for
> merging this patch, though.

My thoughts exactly :)

Liam
