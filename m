From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v5 4/7] ASoC: sunxi: Add sun8i
 I2S driver
Date: Thu, 27 Oct 2016 22:01:49 +0200
Message-ID: <20161027200149.jxc4ey4u4qbylrln@lukather>
References: <cover.1477142934.git.moinejf@free.fr>
 <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
 <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
 <20161023094503.fbb22dd0701e3f2785828609@free.fr>
 <20161024123449.npo4grdlbrj4tcsj@lukather>
 <20161027171325.d68baa5ff51da4921ff8b94d@free.fr>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="obat3uet3dysvzgr"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBLV2ZHAAKGQEGQ2RMVA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20161027171325.d68baa5ff51da4921ff8b94d-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--obat3uet3dysvzgr
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Oct 27, 2016 at 05:13:25PM +0200, Jean-Francois Moine wrote:
> On Mon, 24 Oct 2016 14:34:49 +0200
> Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> 
> > Hi,
> > 
> > On Sun, Oct 23, 2016 at 09:45:03AM +0200, Jean-Francois Moine wrote:
> > > On Sun, 23 Oct 2016 09:33:16 +0800
> > > Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> > > 
> > > > > Note: This driver is closed to the sun4i-i2s except that:
> > > > > - it handles the H3
> > > > 
> > > > If it's close to sun4i-i2s, you should probably rework that one to support
> > > > the newer SoCs.
> > > > 
> > > > > - it creates the sound card (with sun4i-i2s, the sound card is created
> > > > >   by the CODECs)
> > > > 
> > > > I think this is wrong. I2S is only the DAI. You typically have a separate
> > > > platform driver for the whole card, or just use simple-card.
> > > 
> > > An other device is not needed. The layout is simple:
> > > 	I2S_controller (CPU DAI) <-> HDMI_CODEC (CODEC DAI)
> > > The HDMI CODEC is supported by the HDMI video driver (only one device),
> > > so, it cannot be the card device.
> > > ASoC does not use the CPU DAI device (I2S_controller), so, it is
> > > natural to use it to handle the card.
> > 
> > Still, duplicating the driver is not the solution. I agree with
> > Chen-Yu that we want to leverage the driver that is already there.
> 
> Hi Maxime and Chen-Yu,
> 
> After looking at the sun4i-i2s, I found 2 solutions for re-using its
> code in the DE2 HDMI context:
> 
> 1) either to split the sun4i-i2s driver into common I/O functions and
>    slave CPU DAI,
> 
> 2) or to move the sun4i-i2s into a master CPU DAI.
> 
> (
>  some explanation about 'master' and 'slave': the master is the
>  component the device of which is also the sound card.
>  As the sound card uses the 'drvdata' of the device, this drvdata pointer
>  cannot be used by the master.
>  In the actual implementations:
>   - sun4i-i2s
> 	master:	card dev = codec dev, drvdata -> card
> 	slave:	i2s dev (CPU DAI), drvdata -> i2s data
>   - sun8i-i2s
> 	master:	card dev = i2s dev (CPU DAI), drvdata -> card
> 	slave:	codec dev (hdmi), drvdata -> codec data (audio/video)
> )
> 
> In the case 1, there is no functional change, just a source split.
> The sun8i-i2s will then use the common I/O functions.
> 
> In the case 2, the CODECs using the sun4i-i2s would have to move to
> slave CODEC DAI, i.e. the card is created by the sun4i-i2s code.
> In the 4.9, there is only one codec (sun4i-codec), so, the change
> is just to move the card creation and the use of drvdata in both
> codes.

I think you're mistaken. sun4i-codec has nothing to do with the I2S
driver. It's a driver for the (poorly named) Allwinner's Audio Codec
which features it's own DAI and Codec directly into the SoC.

The DAI being different from the I2S one.

However, we want to use any codec driver with the i2s driver,
including those in sound/soc/codecs, and we already have drivers for
them.

So I'm not sure either solution is a good one. Why not just make the
HDMI part a codec itself, and use the i2s driver as the CPU DAI, like
any other codec?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--obat3uet3dysvzgr--
