From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v6] sun4i-codec: Add FM, Line and Mic inputs
Date: Wed, 16 Dec 2015 11:47:36 +0100
Message-ID: <20151216104736.GT19456@lukather>
References: <20151209235530.7240df0a@dayas>
 <20151213205839.GA19456@lukather>
 <20151215025208.7c468673@dayas>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EmW68jKGQIhj8inv"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBSMCYWZQKGQEKKYGALY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151215025208.7c468673@dayas>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--EmW68jKGQIhj8inv
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Tue, Dec 15, 2015 at 02:52:08AM +0100, Danny Milosavljevic wrote:
> Hi Maxime,
> 
> On Sun, 13 Dec 2015 21:58:39 +0100
> Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> 
> > This is not the branch you should be basing your patch on. This is an
> > ASoC patch, base it on the ASoC tree.
> 
> Okay, will do. To the branch "sunxi-next" in 
> <git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git>, right?
> 
> [...]
> > > -static const struct regmap_config sun4i_codec_regmap_config = {
> > > -	.reg_bits	= 32,
> > > -	.reg_stride	= 4,
> > > -	.val_bits	= 32,
> > > -	.max_register	= SUN4I_CODEC_AC_MIC_PHONE_CAL,
> > > -};
> > > -
> > 
> > Why is this moved?
> 
> Because SUN4I_CODEC_AC_MIC_PHONE_CAL is sun7i-specific.

Yet, you're using it in both cases (A10 vs A20).

> Note: I also renamed it and moved the #define in the course of grouping 
> together sun7i-specific things:
> 
> > +/* sun7i-specific things: */
> > +/* MIC_PHONE_CAL register offsets and bit fields (A20 only) */
> > +#define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
> [...]
> > +static const struct regmap_config sun4i_codec_regmap_config = {
> > +	.reg_bits	= 32,
> > +	.reg_stride	= 4,
> > +	.val_bits	= 32,
> > +	.max_register	= SUN7I_CODEC_AC_MIC_PHONE_CAL,
> > +};
> > +/* end sun7i-specific things */
> 
> I thought about also renaming sun4i_codec_regmap_config but decided against it 
> since it's fine to use it on A10 and I think it's best if the name reflects 
> the minimum required hardware.
> 
> On the other hand, once I moved the define, sun4i-codec won't compile if 
> sun4i_codec_regmap_config is left at the top. So I had to move it, too.

You can also have the defines on top, and everything just works :)

> It will be clearer once I post a patch doing just the preparation of the 
> A10/A20 split.
> 
> I just checked A10 vs A20 some more:
> There's also SUN4I_CODEC_AC_SYS_VERI 0x38 present in original ASoC and in 4.4-rc2.
> It's unused by us, not mentioned in the A10 User manual V1.5 20130820, and called 
> "AC_DAC_CAL" in the A20 User Manual v1.4 20150510. Ok to delete? 
> Or is it better to rename it to "SUN7I_CODEC_AC_DAC_CAL" rather than delete?

You can rename it if you want, but it's not like it's of the highest
importance :)

> 
> > >  static int sun4i_codec_probe(struct platform_device *pdev)
> > >  {
> > >  	struct snd_soc_card *card;
> > > @@ -593,6 +740,7 @@ static int sun4i_codec_probe(struct platform_device *pdev)
> > >  	struct resource *res;
> > >  	void __iomem *base;
> > >  	int ret;
> > > +	const struct snd_soc_codec_driver* codec_codec;
> > 
> > I guess a single codec is enough :)
> 
> Modeled after the name of the original variable, see below :)
> 
> But OK, I'll rename it to "codec".
> 
> Note: the newest original ASoC sun4i-codec has a variable
>   "struct sun4i_codec *scodec;"
> as well in the same function (which is a different thing).

I don't know what you're refering to with "newest" and "original".

But two different variables with two different names doesn't seem so
bad, does it?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--EmW68jKGQIhj8inv--
