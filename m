From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4] ASoC: Intel: fixed TI button detection
Date: Mon, 15 Jun 2015 10:51:44 +0100
Message-ID: <20150615095144.GD18309@sirena.org.uk>
References: <1432925772-117760-3-git-send-email-yang.a.fang@intel.com>
 <1433369261-98343-1-git-send-email-yang.a.fang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4283616321830590668=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2890261531
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 11:51:55 +0200 (CEST)
In-Reply-To: <1433369261-98343-1-git-send-email-yang.a.fang@intel.com>
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
Cc: alsa-devel@alsa-project.org, srinivas.sripathi@intel.com, vinod.koul@intel.com, praveen.k.jain@intel.com, lgirdwood@gmail.com, denny.iriawan@intel.com, sathyanarayana.nujella@intel.com, kevin.strasser@linux.intel.com, dgreid@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============4283616321830590668==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Content-Disposition: inline


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2015 at 03:07:41PM -0700, yang.a.fang@intel.com wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
>=20
> In order to make TI button interrupt working max98090 codec
> Need provide mic bias all the time as long as mic is present
> so SHDN and micbias pin are forced on.we also need set max98090
> codec bias close or lower than TI bias.We set them in bios/coreboot
> kernel reads them from device property

Applied, thanks.

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVfqAwAAoJECTWi3JdVIfQSeYH/Rh/y7kp0lO/i3M4TXpl0tYy
Z8fFWYSAdOAVR94RReY4bMuLgSmRhIwl2LpRr4lEkNNQYWlSbAchkVWxCQL2qPLh
IyfRsanWO631vgl2DK6tdl5YLKB7+l/9Fo6ZZlYnb8Xq3NfH5fizzn6NvFPv3P81
Sxp5+zyhri0SAl8setmVle2aCjj29yG1AybcEMAv6SKnvWJw9Up7z/tmVbKHgbcD
Wysr280FoqS/IzsVMdXOLh2zlV1c5H8W8YBDVhGL7f3kc0uMjgVPeNa49bEHEaVY
2ek0vbKj8ICDHqnE/vJdZtxDNlq2jOLiOW7UMLzrfB2ePvQZSQ+uc000xL3bloI=
=rOqn
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--

--===============4283616321830590668==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4283616321830590668==--
