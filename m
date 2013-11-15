From: Nicolin Chen <b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: fsl_ssi: Add monaural audio support for
 non-ac97 interface
Date: Fri, 15 Nov 2013 23:17:40 +0800
Message-ID: <20131115151739.GA2226@MrMyself>
References: <1384427230-979-1-git-send-email-b42378@freescale.com>
 <1384427230-979-3-git-send-email-b42378@freescale.com>
 <20131115122107.GK16735@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131115122107.GK16735-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: timur-N01EOCouUvQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 15, 2013 at 12:21:08PM +0000, Russell King - ARM Linux wrote:
> > @@ -517,10 +517,12 @@ static int fsl_ssi_hw_params(struct snd_pcm_substream *substream,
> >  {
> >  	struct fsl_ssi_private *ssi_private = snd_soc_dai_get_drvdata(cpu_dai);
> >  	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
> > +	unsigned int channels = params_channels(hw_params);
> >  	unsigned int sample_size =
> >  		snd_pcm_format_width(params_format(hw_params));
> >  	u32 wl = CCSR_SSI_SxCCR_WL(sample_size);
> >  	int enabled = read_ssi(&ssi->scr) & CCSR_SSI_SCR_SSIEN;
> > +	static u8 i2s_mode;
> 
> Throwing a static variable into the middle of a driver with none is a
> really horrid thing to do and is very bad programming practice.  What
> if some freescale device decides to have to of these interfaces?  Both
> will try to use this same static variable.
> 
> This is extremely bad programming practice.

Sir, I'm glad you're teaching me this lesson. I did hesitate before I
sent this patch, just couldn't tell the reason. And swear to god, I
hadn't used and will never use this practice again.
 

> > +	/* Save i2s mode configuration so that we can restore it later */
> > +	switch (read_ssi(&ssi->scr) & CCSR_SSI_SCR_I2S_MODE_MASK) {
> > +	case CCSR_SSI_SCR_I2S_MODE_SLAVE:
> > +	case CCSR_SSI_SCR_I2S_MODE_MASTER:
> > +		i2s_mode = read_ssi(&ssi->scr) & CCSR_SSI_SCR_I2S_MODE_MASK;
> > +	default:
> > +		break;
> > +	}
> 
> So all you're doing is saving the mode only if it specifies master or
> slave mode, but not if it's normal mode (== 0).  This just looks like
> it's complicated just for the sake of being complicated.
> 
> Since we know what mode this is in when we run fsl_ssi_setup(), can we
> not save that value into the fsl_ssi_private structure and re-use it
> here?

Currently we only have fsl_ssi_setup() to set I2S mode. It's definitely
a good idea to save it into private structure at that point. But there
will be new ASoC function -- set_dai_fmt() appending to this driver.
It will provide ASoC machine driver an interface to set I2S mode again,
and we must put a saving code as well at that time. So I think put the
saving code here would keep the modification within a small range. But
I here might be so obsessed with trying to make the patch as neat as
possible that I picked a demon sword.

But I'm still willing to learn the lesson. And I'll refine this patch.

Much obliged,
Nicolin Chen


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
