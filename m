From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 17/17] ASoC: fsl: add imx-sgtl5000
	machine driver
Date: Tue, 6 Mar 2012 12:02:47 +0000
Message-ID: <20120306120247.GF19635@opensource.wolfsonmicro.com>
References: <1330957865-19085-1-git-send-email-shawn.guo@linaro.org>
	<1330957865-19085-18-git-send-email-shawn.guo@linaro.org>
	<20120305144601.GQ3224@opensource.wolfsonmicro.com>
	<20120306073900.GP16232@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4153350713670428760=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0F9D924361
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 13:02:50 +0100 (CET)
In-Reply-To: <20120306073900.GP16232@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============4153350713670428760==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mrJd9p1Ce66CJMxE"
Content-Disposition: inline


--mrJd9p1Ce66CJMxE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 03:39:02PM +0800, Shawn Guo wrote:
> On Mon, Mar 05, 2012 at 02:46:01PM +0000, Mark Brown wrote:

> > This you can just set in the card struct, no need for explicit code at
> > all.

> Yes, I just tried.  It also works but a little bit differently.  We
> only set_fmt for codec_dai here, while ASoC core will set_fmt for both
> codec_dai and cpu_dai if dai_link->dai_fmt is set.  However, the
> fsl_ssi does not provide .set_fmt implementation, and consequently we
> will see error message below, which does not impact functionality
> though.

>   fsl-ssi-dai 83fcc000.ssi: Failed to set DAI format: -22

> I hope we keep the code as it is now and improve later when fsl_ssi
> gets improved.

No, we should fix the core to work better in this case - not having a
DAI operation is perfectly normal and should be supported.

> > > +	ret = of_property_read_u32(np, "fsl,mux-int-port", &int_port);
> > > +	ret = of_property_read_u32(np, "fsl,mux-ext-port", &ext_port);

> > It seems very odd to have namespacing on the individual property names.
> > Why are you doing that?  The properties are already defined in terms of
> > the device binding.  Though everyone else is doing it so not really a
> > problem.

> The general device tree binding practice is we'd better have a vendor
> prefix on the property name, if the property applies on specific vendor
> drivers instead of common ones across different vendors.

There's nothing generic about this device, it only applies to a specific
combination of things and in so far as it applies to those the
properties are generic - any board combining i.MX and this CODEC is
going to have an audmux.

> > > +	/*
> > > +	 * The port numbering in the hardware manual starts at 1, while
> > > +	 * the audmux API expects it starts at 0.
> > > +	 */
> > > +	int_port--;
> > > +	ext_port--;

> > Should have error checking somewhere to make sure that the user
> > remembered this.

> Because different i.MX SoC may have different internal and external
> port number, I do not think of a way to check that.  And I would not

In that case the audmux code should be validating the arguments.

> worry about it that much, since all the hardware documents number the
> port from 1, while device tree user/author will have to look at those
> documents for the data.

OTOH the in kernel API uses a different numbering and if the user is
porting their existing code over to device tree...

> > > +	imx_audmux_v2_configure_port(int_port,
> > > +			IMX_AUDMUX_V2_PTCR_SYN |
> > > +			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
> > > +			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
> > > +			IMX_AUDMUX_V2_PTCR_TFSDIR |
> > > +			IMX_AUDMUX_V2_PTCR_TCLKDIR,
> > > +			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));

> > I'm not sure we've really gained much from converting to a platform
> > driver given that the device just registers something globally...

> Converting audmux to a platform driver does not change anything about
> that.  It makes device tree support easier, and gets the audmux users
> (imx machine drivers) stay away from including <mach/audmux.h>.

It's not actually fixed anything in the APIs though and we've now also
got a race in the driver probes since the audmux now need to come up via
the device model instead of just being there - we could try to configure
the audmux with no platform driver bound.  We should really have the
audmux as at least an aux_dev in the card to make sure it's there.

--mrJd9p1Ce66CJMxE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVfzgAAoJEBus8iNuMP3dhekP/RFWVo/2/sHYX7m/zw11/anV
a3rPF9Z39FmmteX6Pr1JCeEpVvu/efHMlvBBecbfBb2HfFh1ROJMqAxCvleQQjst
g3p2SSo5vzFJMm+PTv2c1iKw4OjoT8fP85IYC3OwudE96CpjAxcR9Ags1C9vt6N1
eYSSQxODBEq2Q3jNrkTIGwKnEZvwOzTd76tFZ+0tygfvpF/ooC/9NQEz1XRtfmc2
dTxrkrvKFHy/TtND/SP/PJpwlkCnkXw+/AsQAZpL6OHv31K7Yzm0FxcDz++M7XEP
TnJbqTXEgzjjlKWHqB2gbXLR/V756tnUC4BTB1mfxZwp7y73cjQB0V3OqCF+QXeT
ZKvnZ6rMKQ2Gw4JtgANgBekDoWiABlrEmdVFEWidzc2fD2wTIPGoXGZB6ERRHHI3
Un47Rm7snmQLMeylYxRIL6CTmx6dC2ludRA1xC2j6igvdV8MsfEqEa039C6B6TSH
rAWzLC7/fDBjacb4UA7JbPD6DC076IaIntO77LHrl/2/mLSebL2cTVUU9S/Dh3Ip
zwqBDBxfOGchtKFTTDjwFBMCLY9u5L4fSYjivDsuLbXiuQt0hqUUq9FRSDEdEfPH
zlha6dZoCpsUnV1E0R92h2h2OJ8JD4+kYDEyl/8+ynRiQ7zGXzy09Aqgy0NQXuBz
idKwIwCeCmuWjD3Y2XTc
=UZx4
-----END PGP SIGNATURE-----

--mrJd9p1Ce66CJMxE--

--===============4153350713670428760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4153350713670428760==--
