From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: Intel: Add Cherrytrail &
 Braswell machine driver cht_bsw_max98090
Date: Thu, 30 Apr 2015 21:19:53 +0100
Message-ID: <20150430201953.GA543@sirena.org.uk>
References: <1430358238-74659-1-git-send-email-yang.a.fang@intel.com>
 <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9105478884810088010=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D7F626153A
 for <alsa-devel@alsa-project.org>; Thu, 30 Apr 2015 22:19:59 +0200 (CEST)
In-Reply-To: <1430358238-74659-2-git-send-email-yang.a.fang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yang.a.fang@intel.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, praveen.k.jain@intel.com, praveen.diwakar@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============9105478884810088010==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2015 at 06:43:56PM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> Add machine driver for two Intel Cherryview-based platforms, Cherrytrail
> and Braswell, with max98090 codec.

Actually now I think about it one thing here: this isn't a generic
driver for this combination of parts - it's specific to the Chromebook
since it relies on their TI headphone amp/button detect device.  This
makes Pierre's concern about documentation even more pressing, and
probably the driver should have an appropriate name.

Of course given that the ACPI ID appears likely to be reused by
non-Chromebooks that have the same Maxim CODEC things might get a bit
fun - I'd suggest trying to find something more Chromebook specific to
match on, or quirking he presence of the TI device.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVQo5oAAoJECTWi3JdVIfQTSQH/iGfePSGDbb6avhkUsRtmaCQ
YMF4vBbaVbR9ELH/mW3C7mOYzA/Mzi8lELHrAkPkSL3AEgXBZMT8fiJJMGq24U11
4DrtW5DRmNkabRZlToO6wPQNSB71NCBW95B01owvtw/kqkHbPGuKZI2nuzV29kJW
YdKT5Y0dHjB+6pcg/4DZYAXBx8DtwjhITuBUeTIFLIKjsjd5Cu4phzvtOoS0h0XG
pK4pGEdpqpCWFYSTQbdVnPxd8JoEp3sxQ3o5GUPpherh8KCEqk3EWhi3ky4Q54/D
JaJNX5wzWYvwhB6D4knGyIvddkWQfnv9HQrY57lt03TMv3dPKR3xvGl6aIQzQrc=
=ynPj
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--

--===============9105478884810088010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9105478884810088010==--
