From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
Date: Thu, 27 Oct 2016 19:51:54 +0200
Message-ID: <20161027175154.v4kuhyvm3r5n6tdo@lukather>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
 <20161004165553.GS5228@lukather>
 <20161023183107.5b75b6aad62853378713299f@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ytmjuq4pyc3h5ao5"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161023183107.5b75b6aad62853378713299f-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--ytmjuq4pyc3h5ao5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 23, 2016 at 06:31:07PM +0200, Jean-Francois Moine wrote:
> On Tue, 4 Oct 2016 18:55:54 +0200
> Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>=20
> > On Tue, Oct 04, 2016 at 12:40:11PM +0200, Jean-Francois Moine wrote:
> > > On Tue,  4 Oct 2016 11:46:14 +0200
> > > Myl=E8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> > >=20
> > > > Add the case of a burst of 4 which is handled by the SoC.
> > > >=20
> > > > Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.=
com>
> > > > ---
> > > >  drivers/dma/sun6i-dma.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > > > index 8346199..0485204 100644
> > > > --- a/drivers/dma/sun6i-dma.c
> > > > +++ b/drivers/dma/sun6i-dma.c
> > > > @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
> > > >  	switch (maxburst) {
> > > >  	case 1:
> > > >  		return 0;
> > > > +	case 4:
> > > > +		return 1;
> > > >  	case 8:
> > > >  		return 2;
> > > >  	default:
> > > > --=20
> > > > 2.9.3
> > >=20
> > > This patch has already been rejected by Maxime in the threads
> > > 	http://www.spinics.net/lists/dmaengine/msg08610.html
> > > and
> > > 	http://www.spinics.net/lists/dmaengine/msg08719.html
> > >=20
> > > I hope you will find the way he wants for this maxburst to be added.
> >=20
> > I was talking about something along these lines (not tested):
>=20
> I wonder why you don't submit this yourself.

I thought you were the one who cared. You asked for what I had in
mind, here it is.

> > -------8<---------
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index 83461994e418..573ac4608293 100644
> > --- a/drivers/dma/sun6i-dma.c
> > +++ b/drivers/dma/sun6i-dma.c
> > @@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
> >  	switch (maxburst) {
> >  	case 1:
> >  		return 0;
> > +	case 4:
> > +		return 1;
> >  	case 8:
> >  		return 2;
> >  	default:
> > @@ -1110,11 +1112,19 @@ static int sun6i_dma_probe(struct platform_devi=
ce *pdev)
> >  	sdc->slave.dst_addr_widths		=3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> >  						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> >  						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> > +	sdc->slave.dst_bursts			=3D BIT(1) | BIT(8);
> > +	sdc->slave.src_bursts			=3D BIT(1) | BIT(8);
> >  	sdc->slave.directions			=3D BIT(DMA_DEV_TO_MEM) |
> >  						  BIT(DMA_MEM_TO_DEV);
> >  	sdc->slave.residue_granularity		=3D DMA_RESIDUE_GRANULARITY_BURST;
> >  	sdc->slave.dev =3D &pdev->dev;
> > =20
> > +	if (of_device_is_compatible(pdev->dev.of_node,
> > +				    "allwinner,sun8i-h3-dma")) {
> > +		sdc->slave.dst_bursts |=3D BIT(4);
> > +		sdc->slave.src_bursts |=3D BIT(4);
> > +	}
> > +
> >  	sdc->pchans =3D devm_kcalloc(&pdev->dev, sdc->cfg->nr_max_channels,
> >  				   sizeof(struct sun6i_pchan), GFP_KERNEL);
> >  	if (!sdc->pchans)
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index cc535a478bae..f7bbec24bb58 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -673,6 +673,8 @@ struct dma_filter {
> >   * 	each type of direction, the dma controller should fill (1 <<
> >   * 	<TYPE>) and same should be checked by controller as well
> >   * @max_burst: max burst capability per-transfer
> > + * @dst_bursts: bitfield of the available burst sizes for the destinat=
ion
> > + * @src_bursts: bitfield of the available burst sizes for the source
>=20
> You did not define dst_bursts nor src_bursts.
>=20
> >   * @residue_granularity: granularity of the transfer residue reported
> >   *	by tx_status
> >   * @device_alloc_chan_resources: allocate resources and return the
> > @@ -800,6 +802,14 @@ struct dma_device {
> >  static inline int dmaengine_slave_config(struct dma_chan *chan,
> >  					  struct dma_slave_config *config)
> >  {
> > +	if (config->src_maxburst && config->device->src_bursts &&
> > +	    !(BIT(config->src_maxburst) & config->device->src_bursts))
>=20
> The maxburst may be as big as 4Kibytes, then, I am not sure that this
> code will work!
>=20
> > +		return -EINVAL;
> > +
> > +	if (config->dst_maxburst && config->device->dst_bursts &&
> > +	    !(BIT(config->dst_maxburst) & config->device->dst_bursts))
> > +		return -EINVAL;
> > +
> >  	if (chan->device->device_config)
> >  		return chan->device->device_config(chan, config);
> > -------8<------------=20
>=20
> Yes, I know that the burst size is always a power of 2.
> The best way to check it would be to change the {src,dts}_maxburst to a
> bitmap of the possible bursts as 0x0d for 1,4 and 8 bytes. But this
> asks for a lot of changes...

To be honest, I'm not really a big fan of those tree wide changes
without any way to maintain compatibility. It ends up in a single,
huge patch if we want to maintain bisectability that just isn't
reviewable.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ytmjuq4pyc3h5ao5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYEj66AAoJEBx+YmzsjxAg1p0P/RHAvXASog8JmNwxGhGfZtgZ
ykeNoQg+PyUNQ13u49vDv/UUkBwQa/bjBRtvM6/YVlosuto/xQCay4DLIte4kjDA
qXaQndsHGevPWRJZQgv2Sl/QQD3+lfKHK/gfMHNrgUZMcVEibXWraFMHdCGpRKzR
IGTbkyZv1xS5M5Z2E57lWHGsbABaK6vm0eK+eDmaBMFuUpn85vrE5LZLTb1QKnaq
HHU90XTlfnrExxPPKXoO2SyW5CZlgrG7Qs28Td2KHPlsQ6hm9LAFwOcX3SJObHMf
BLqqnNdzUtHFpMUfa6SqBaf2LzyIj7S3TuTYFxpRn5kMYm9YTeAFKh5O+8c5kUI9
mZ6aPp6ui3WYJ4A5RmfgiVA5BTeBzAAaCYq/Pp5oU5lEYFRDAZLnPAgWqs/5daRr
nE4IEXEGBM+chIW6+7eJjUlgjZa2mnTHWA4IfnYWZxE3ehg80CnfIIIjwxRKqLno
sk8EVaYaMOLP+RCu8FvyVmE1VhZ75+QigM1won54EnBL8oJsBeV00tc16eH7m9hN
60rEDhCsHMw62TeTTmxB2irtnRNNWHKWpErIVhk0MafYEwRkPzuRk1zAyWG0dtFf
hKE6B7R9CB75o/hpylMRdzWBt0Ecw/YST18jGPLQsA3yU5GEFPD8p8McvoMIq+qO
JWmFmknZCja+j+Fisjjy
=U4fb
-----END PGP SIGNATURE-----

--ytmjuq4pyc3h5ao5--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
