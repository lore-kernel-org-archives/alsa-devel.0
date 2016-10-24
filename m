From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 4/7] ASoC: sunxi: Add sun8i I2S driver
Date: Mon, 24 Oct 2016 14:34:49 +0200
Message-ID: <20161024123449.npo4grdlbrj4tcsj@lukather>
References: <cover.1477142934.git.moinejf@free.fr>
 <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
 <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
 <20161023094503.fbb22dd0701e3f2785828609@free.fr>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rmyuhci7t6uxvhth"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB3VVXHAAKGQE7YVNRWI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20161023094503.fbb22dd0701e3f2785828609-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--rmyuhci7t6uxvhth
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Sun, Oct 23, 2016 at 09:45:03AM +0200, Jean-Francois Moine wrote:
> On Sun, 23 Oct 2016 09:33:16 +0800
> Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> 
> > > Note: This driver is closed to the sun4i-i2s except that:
> > > - it handles the H3
> > 
> > If it's close to sun4i-i2s, you should probably rework that one to support
> > the newer SoCs.
> > 
> > > - it creates the sound card (with sun4i-i2s, the sound card is created
> > >   by the CODECs)
> > 
> > I think this is wrong. I2S is only the DAI. You typically have a separate
> > platform driver for the whole card, or just use simple-card.
> 
> An other device is not needed. The layout is simple:
> 	I2S_controller (CPU DAI) <-> HDMI_CODEC (CODEC DAI)
> The HDMI CODEC is supported by the HDMI video driver (only one device),
> so, it cannot be the card device.
> ASoC does not use the CPU DAI device (I2S_controller), so, it is
> natural to use it to handle the card.

Still, duplicating the driver is not the solution. I agree with
Chen-Yu that we want to leverage the driver that is already there.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--rmyuhci7t6uxvhth--
