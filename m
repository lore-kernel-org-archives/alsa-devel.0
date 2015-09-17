From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH 2/2] ASoC: sunxi: add support for the
 on-chip codec on early Allwinner SoCs
Date: Thu, 17 Sep 2015 18:37:56 +0100
Message-ID: <20150917173756.GE12027@sirena.org.uk>
References: <1442064384-23379-1-git-send-email-maxime.ripard@free-electrons.com>
 <1442064384-23379-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150916191612.GM12027@sirena.org.uk>
 <20150917133135.GE4684@lukather>
 <CAGb2v67D30+_itOAyWqGzychxeM_d7rF6TTu1_WBYuFPfFEk1g@mail.gmail.com>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rRLHt+g8zo1nijuo"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBCHV5OXQKGQEVNENKNQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v67D30+_itOAyWqGzychxeM_d7rF6TTu1_WBYuFPfFEk1g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--rRLHt+g8zo1nijuo
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Sep 17, 2015 at 11:10:41PM +0800, Chen-Yu Tsai wrote:
> On Thu, Sep 17, 2015 at 9:31 PM, Maxime Ripard

> >> > +           .formats        = SNDRV_PCM_FMTBIT_S16_LE |
> >> > +                             SNDRV_PCM_FMTBIT_S32_LE,
> >> > +           .sig_bits       = 24,

> >> So presumably also S24_LE (ie, 24 bits packed into a 32 bit word)?

> > Hmm, probably yes, I'll test that.

> IIRC when Emilio first wrote the driver, we tried 24 bit and no sound
> came out. Turns out it's an alignment issue. The codec's FIFO register
> is 32 bits wide, and takes the higher 24 bits as input when set to 24
> bit mode. The internal FIFO is only 24 bits wide. A20 user manual P174
> describes how the bits are copied.

> So for 24 bit audio, you would actually send it 32 bit audio samples,
> and let it truncate or drop the least significant 8 bits. This is why
> we have SNDRV_PCM_FMTBIT_S32_LE with .sig_bits = 24.

> I don't know if this is just a workaround, but a few other drivers do
> this as well, for example twl3040 and omap-mcpdm.

That's very common - it's essentially what S24_LE mode is.
--rRLHt+g8zo1nijuo--
