From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 01/14] dma: sun6i-dma: Add burst case of 4
Date: Tue, 4 Oct 2016 18:55:54 +0200
Message-ID: <20161004165553.GS5228@lukather>
References: <cover.1475569400.git.mylene.josserand@free-electrons.com>
 <3a2404510b5f8b16ae3bb193982d70f158700b2b.1475571575.git.mylene.josserand@free-electrons.com>
 <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="REOXmE5zpOGz6VLu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161004124011.d7f5754a082d5f17d5185fc4@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, vinod.koul@intel.com, wens@csie.org, mturquette@baylibre.com, sboyd@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lee.jones@linaro.org, mark.rutland@arm.com, robh+dt@kernel.org, thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, alexandre.belloni@free-electrons.com, dmaengine@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--REOXmE5zpOGz6VLu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 04, 2016 at 12:40:11PM +0200, Jean-Francois Moine wrote:
> On Tue,  4 Oct 2016 11:46:14 +0200
> Myl=E8ne Josserand <mylene.josserand@free-electrons.com> wrote:
>=20
> > Add the case of a burst of 4 which is handled by the SoC.
> >=20
> > Signed-off-by: Myl=E8ne Josserand <mylene.josserand@free-electrons.com>
> > ---
> >  drivers/dma/sun6i-dma.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> > index 8346199..0485204 100644
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
> > --=20
> > 2.9.3
>=20
> This patch has already been rejected by Maxime in the threads
> 	http://www.spinics.net/lists/dmaengine/msg08610.html
> and
> 	http://www.spinics.net/lists/dmaengine/msg08719.html
>=20
> I hope you will find the way he wants for this maxburst to be added.

I was talking about something along these lines (not tested):

-------8<---------
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index 83461994e418..573ac4608293 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -240,6 +240,8 @@ static inline s8 convert_burst(u32 maxburst)
 	switch (maxburst) {
 	case 1:
 		return 0;
+	case 4:
+		return 1;
 	case 8:
 		return 2;
 	default:
@@ -1110,11 +1112,19 @@ static int sun6i_dma_probe(struct platform_device *=
pdev)
 	sdc->slave.dst_addr_widths		=3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 						  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 						  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	sdc->slave.dst_bursts			=3D BIT(1) | BIT(8);
+	sdc->slave.src_bursts			=3D BIT(1) | BIT(8);
 	sdc->slave.directions			=3D BIT(DMA_DEV_TO_MEM) |
 						  BIT(DMA_MEM_TO_DEV);
 	sdc->slave.residue_granularity		=3D DMA_RESIDUE_GRANULARITY_BURST;
 	sdc->slave.dev =3D &pdev->dev;
=20
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "allwinner,sun8i-h3-dma")) {
+		sdc->slave.dst_bursts |=3D BIT(4);
+		sdc->slave.src_bursts |=3D BIT(4);
+	}
+
 	sdc->pchans =3D devm_kcalloc(&pdev->dev, sdc->cfg->nr_max_channels,
 				   sizeof(struct sun6i_pchan), GFP_KERNEL);
 	if (!sdc->pchans)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index cc535a478bae..f7bbec24bb58 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -673,6 +673,8 @@ struct dma_filter {
  * 	each type of direction, the dma controller should fill (1 <<
  * 	<TYPE>) and same should be checked by controller as well
  * @max_burst: max burst capability per-transfer
+ * @dst_bursts: bitfield of the available burst sizes for the destination
+ * @src_bursts: bitfield of the available burst sizes for the source
  * @residue_granularity: granularity of the transfer residue reported
  *	by tx_status
  * @device_alloc_chan_resources: allocate resources and return the
@@ -800,6 +802,14 @@ struct dma_device {
 static inline int dmaengine_slave_config(struct dma_chan *chan,
 					  struct dma_slave_config *config)
 {
+	if (config->src_maxburst && config->device->src_bursts &&
+	    !(BIT(config->src_maxburst) & config->device->src_bursts))
+		return -EINVAL;
+
+	if (config->dst_maxburst && config->device->dst_bursts &&
+	    !(BIT(config->dst_maxburst) & config->device->dst_bursts))
+		return -EINVAL;
+
 	if (chan->device->device_config)
 		return chan->device->device_config(chan, config);
-------8<------------=20

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--REOXmE5zpOGz6VLu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX898ZAAoJEBx+YmzsjxAgltQQALVv8yT8BEcrCxqFcFnSbog1
dhFSw+o5Xz62P+r7DA41uoQR/R8cWoShprC3xlFXFnnMgqtm31tRllRns6sUkeXR
aEuePrPHiBj17RVrYDv+zEfm29KOqP2sipC2uMLFx7i3w0ii/udFcPqprFXfKibi
nLSBqKN9PD7mlFLSzxy7VF9ikbjTc+g0k5TS668BJ6QIgr9J+n99nm4y77SzJQS4
tyyv4AZ3pW6JZDqYjgSqd1OHHHmewjYuumd0/1KMS6P5IsM1h98Su/xlBG+hTR0o
4X24hSmV+3XCdGnOZHZ3/7UZ0ru/Pp5u05wR0A9VI49rCrFJ37X3pYf/ULxpBIJf
+M2CTILXk6IMCiKcbIQvIcMUHHPCibTuoj87FZ/3Szb/YHens+5DnRmkf1BXX8bh
ynAYnDj/gSuTapZJjMp/K8wRPas6xSM4KJnc3GVth2MKCN2th+a5ZDRr7VJZAYNl
libY1vwjPZigiHvuZ9fDiWa3kFY+wQZ6edZQvry9im/9AhMWuo9B0oulQOVZH5SP
+VWBaASlfB/MsMOFKdsLKODk8LscpEZWwHP/Qwt5MNXJNVcaD1RW/Bty/tpac57N
JWxbi3krOOK9HHbMccAQ+YMM8tyrk/Fi4ocBEOfhSM1o/0WvttdU6odVHoXvPQtj
ITzrol1xjKT5pGR1VuKt
=rGp+
-----END PGP SIGNATURE-----

--REOXmE5zpOGz6VLu--
