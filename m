From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 2/2] ASoC: sunxi: add support for the
 on-chip codec on early Allwinner SoCs
Date: Thu, 17 Sep 2015 15:31:35 +0200
Message-ID: <20150917133135.GE4684@lukather>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442064384-23379-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150916191612.GM12027@sirena.org.uk>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SKW69dzTt3T8RCN0"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBOMB5OXQKGQEKKGM57I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150916191612.GM12027-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--SKW69dzTt3T8RCN0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Mark,

On Wed, Sep 16, 2015 at 08:16:12PM +0100, Mark Brown wrote:
> On Sat, Sep 12, 2015 at 03:26:24PM +0200, Maxime Ripard wrote:
> 
> This looks pretty good, there's a few minor things below but I'll apply
> anyway - please send followup patches fixing these.

Sure, I will. Thanks!

> 
> > +	if (clk_set_rate(scodec->clk_module, clk_freq))
> > +		return -EINVAL;
> 
> Better to pass back the error code here rather than silently discard it
> (it might have more information).

Yep.

> 
> > +static struct snd_soc_dai_driver sun4i_codec_dai = {
> > +	.name	= "Codec",
> > +	.ops	= &sun4i_codec_dai_ops,
> > +	.playback = {
> > +		.stream_name	= "Codec Playback",
> > +		.channels_min	= 1,
> > +		.channels_max	= 2,
> > +		.rate_min	= 8000,
> > +		.rate_max	= 192000,
> > +		.rates		= SNDRV_PCM_RATE_8000_48000 |
> > +				  SNDRV_PCM_RATE_96000 |
> > +				  SNDRV_PCM_RATE_192000 |
> > +				  SNDRV_PCM_RATE_KNOT,
> 
> No need to specify both explicit rates and _KNOT, _KNOT covers
> everything.

Ack.

> > +		.formats	= SNDRV_PCM_FMTBIT_S16_LE |
> > +				  SNDRV_PCM_FMTBIT_S32_LE,
> > +		.sig_bits	= 24,
> 
> So presumably also S24_LE (ie, 24 bits packed into a 32 bit word)?

Hmm, probably yes, I'll test that.

> > +	/* Enable the bus clock */
> > +	if (clk_prepare_enable(scodec->clk_apb)) {
> > +		dev_err(&pdev->dev, "Failed to enable the APB clock\n");
> > +		return -EINVAL;
> > +	}
> 
> Ideally we'd have runtime power management to disable the clocks when
> idle.

We don't really have any kind of power management support currently,
but adding runtime pm everywhere is definitely on the todo list. It
might not happen before a while though.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--SKW69dzTt3T8RCN0--
