From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
Date: Thu, 31 Dec 2015 22:19:35 +0000
Message-ID: <20151231221935.GG16023@sirena.org.uk>
References: <20151221123148.1ab6480b@dayas>
 <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather>
 <20151228040649.475a742f@dayas>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="evOcBaiMpN7OEvsd"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBEGUS22AKGQEEPNY5RQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20151228040649.475a742f@dayas>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--evOcBaiMpN7OEvsd
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Dec 28, 2015 at 04:06:49AM +0100, Danny Milosavljevic wrote:
> Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> > > +static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
> > > +			    SUN4I_CODEC_ADC_ACTL,
> > > +			    SUN4I_CODEC_ADC_ACTL_ADCIS,
> > > +			    sun4i_codec_capture_source);

> > Isn't it possible to expose this as two (shared) muxes with different
> > names to make it clear what will go to the left ADC and what will go
> > to the right?

> I don't know how to do that. I'll try to find out.

> Can two muxes use the same bit in the hardware without problems?

IIRC we fixed things so that if you've got two controls that share the
same register we do the right thing.  There are other devices with this
issue but it was years ago that I last looked at them, we do have
handling.

> > Those are not volume it's gain, 

> We tried to call the things ..." Gain" before and it was difficult to do, 
> with some breakage along the way, see below.
> Also, Mark said they should be named ..." Volume" (see 
> <https://www.mail-archive.com/linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org/msg15126.html>).
> 
> >and it should probably be two different shared controls for mic1 and mic2.

Yes, this is part of the ABI and honestly from an end user point of view
there is no meaningful difference between the two words (there would be
more if it were gain and attenuation since one is amplification and the
other isn't so there are different considerations when applying them to
signals but that's not the case here).
--evOcBaiMpN7OEvsd--
