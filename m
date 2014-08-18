From: Mark Brown <broonie@kernel.org>
Subject: Re: [v4 05/12] ASoC: Intel: mrfld: add bytes control
	for modules
Date: Mon, 18 Aug 2014 09:19:42 -0500
Message-ID: <20140818141942.GZ14537@sirena.org.uk>
References: <1407145563-1303-1-git-send-email-subhransu.s.prusty@intel.com>
 <1407145563-1303-6-git-send-email-subhransu.s.prusty@intel.com>
 <20140813200012.GO17528@sirena.org.uk>
 <20140818053609.GD14041@vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8737361768561931738=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BDB33265ACB
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 16:43:40 +0200 (CEST)
In-Reply-To: <20140818053609.GD14041@vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8737361768561931738==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bNvn4bxlrUVLu6cT"
Content-Disposition: inline


--bNvn4bxlrUVLu6cT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 18, 2014 at 11:06:09AM +0530, Subhransu S. Prusty wrote:
> On Wed, Aug 13, 2014 at 09:00:12PM +0100, Mark Brown wrote:

> > > +	default:
> > > +		pr_err("Invalid Input- algo type:%d\n", bc->type);

> > dev_err().

> We are using pr_err() in all the error conditions for our driver. If it is
> really required to change, we can submit a single patch to change to
> dev_err() once the patches are merged.

Better yet, submit the fix first.  It's definitely better practice not
to use pr_ when you have a device.

--bNvn4bxlrUVLu6cT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT8gt7AAoJELSic+t+oim9z3EP+QExYWmHZztzKZmGMf4DecPB
12Y25gCoE5jZXd2OG3zZs9A03sOCGc91s7/3eoGhn5dH3mBuoHgzCa19ZrXOT5qH
fkI8bIaBt/N2r/Nd3E8Ol8ucjwPl3xGaAdghE+JtYmtYd/WSnlOEtBDp5UhiV2Zt
rWL486H5JkCH5lil4OzLY7nl4b4klBFaUGr1ZNmCcpMV4cukcnWg9boWhjMS6ZKa
SIeIwSC60ORMyaXKt+10rHUCAu0FovUW4/zLMKSXou2kzrpNdRuUD3mNvw6UaXPy
GWCIR5KnamakkM+yY7x3K4wYbaZJKQs65e6orbXYspzN1nSPmo6PXFqiEvndTeBC
nBm9qDUl8c6UX9Y6frF7donKr1XdGoGleiELEhoNI1KAGlaeSWF/5ZhXT0nnjnf4
5AvA7UpdLwMHtgqnRY9on1gEdiyd8C2LgeUFZr6Bec2EiBUoeI8TIr/FXLOVcBx6
qr403yJ8WdEQtyPSct3/Xi2s+wRJJf5FZB84fS92cdy9MRiGn1WKKueXl/OFxGZ/
Iy8aSHdNapLeaCL8GjJZCX9qIBZpFrJTKhhFBTJhsWU9xa8hp+bSssWDCfK2fV3T
RP89bnZUBwh3M4SN4P8gW/SF7oSYW2H5ybbNavaGCGpRQ0vhxP+7X1XGHtLQUEcM
ktyr9a258vywzrNYG3ja
=Lbu3
-----END PGP SIGNATURE-----

--bNvn4bxlrUVLu6cT--

--===============8737361768561931738==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8737361768561931738==--
