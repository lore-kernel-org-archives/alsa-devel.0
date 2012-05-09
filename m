From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/4] ASoC: omap-abe-twl6040: Add device
	tree support
Date: Wed, 9 May 2012 16:59:04 +0100
Message-ID: <20120509155902.GF3955@opensource.wolfsonmicro.com>
References: <1336479314-27766-1-git-send-email-peter.ujfalusi@ti.com>
	<1336479314-27766-5-git-send-email-peter.ujfalusi@ti.com>
	<20120508135912.GR15893@opensource.wolfsonmicro.com>
	<4FAA58CD.5010609@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0169891271273293589=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08FE4245EF
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 18:06:07 +0200 (CEST)
In-Reply-To: <4FAA58CD.5010609@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0169891271273293589==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NG5rUlMnWRrIcOiS"
Content-Disposition: inline


--NG5rUlMnWRrIcOiS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 09, 2012 at 02:45:17PM +0300, Peter Ujfalusi wrote:
> On 05/08/2012 04:59 PM, Mark Brown wrote:

> > This seems like it ought to be an array of nodes, one per link, instead
> > of having an index in the property name.  It should certainly be easier
> > to parse.

> Very true. We can handle this in a similar way as we handle the
> routings. It might be a good idea to add this as a generic ASoC core
> feature?

Yes, that'd be great.  Something like how the routing is done, with an
optional library thing that machine drivers can include in their
bindings.

--NG5rUlMnWRrIcOiS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqpQ+AAoJEBus8iNuMP3dHlkP/RQxwMel3GXtD6AGyxy/Pr6+
MLzCjG4GZnLrVFQxAeZcnnrRGeRfzhT/0U6Y3YXwm2xa88T07f2gVL+ivNKvNdaM
YG7s0xroEogyyxwBrxY2zvxGI+bMD5BFUoeBI3zyUvuEYrWFzPTCoSanZfUvQk0w
HNPJKn74vIBhCSJuhXpcqBRSh+i0/0jhiZQRrA58fIwXlR5xh42FTbIi+h05xtNZ
DiPL2mLJ2Jx2SnUn16S9A82GfkN8kTO8/VNGb9xC/zyXKkY8FvkJMHIsJhJZXuIB
vCGbyzQkHG4XcTDL44HmY8bTRsay33X8ralIWT032IAh1+sG1xl6wDirrWfnTGq0
9p6H7OI8zOnIq/zd/oglkoHxawDzDt+eCj8sO7mpWPK0FCm3XHJ+os2ffeDeawik
SPmw9UowlWwobFlBLekWEYUFxMdn7i+DtUkKCwMHlDTYXw0MLBx2aS4SsDVnoCrq
KIjXPCEEnH0Bh7tWdMZz22U0BZ81OtIjlJYIGwGGlsvVg+AdKw/Pb4FiBZJEg669
ZH5oRNyyhdeiTKHREq17kGEJyiAPIz1cluY3VcAh6R4IADyug9JJeo0WwQ1UDVbN
x5FSuKiqLSgGPw/9FELwbuhQ+8a7Vhbz+r/PyOVsrNWBBRmvMt/8shPEEnebK3LC
reCK8rTcpoEsvbZipbRp
=WjsS
-----END PGP SIGNATURE-----

--NG5rUlMnWRrIcOiS--

--===============0169891271273293589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0169891271273293589==--
