From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 03/10] ASoC: fsl: Move soc_ac97_ops from imx-ssi to
 fsl_ssi
Date: Wed, 3 Jul 2013 17:07:47 +0100
Message-ID: <20130703160747.GR27646@sirena.org.uk>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
 <1371734429-6081-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7756542439339805216=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371734429-6081-4-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============7756542439339805216==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JXgPQ6VbGllIp4i6"
Content-Disposition: inline


--JXgPQ6VbGllIp4i6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 20, 2013 at 03:20:22PM +0200, Markus Pargmann wrote:
> fsl_ssi and imx-ssi can be both enabled at the same time. To be able to
> add AC97 support to fsl_ssi, soc_ac97_ops have to be available to both
> drivers.

This needs to be redone on top of the changes that went into v3.11 to
support multiplatform AC'97 - it won't apply any more.

--JXgPQ6VbGllIp4i6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1ExQAAoJELSic+t+oim92C4P/Rb0QbfU4fazOijtfr3K2qh1
3QpWROpoL2iyJjGN/zZfK4X/n1bRDsR3dFhpAAeUdQe6hxvIJRNWmUFH2fHlssS6
NafGFB/SS5amNku8z3BB7NT6WtAF/LfSqKevysWRuK/gFnAqkg56ROTgj68/S86i
Emhtl18nZpDeta+/F6OcgdVRDUHM+Z0NIOnVDEWAAZoZ+ahaYGQkgRgKd0lKUMTC
AaxBh9rTiO/QZXtQhTwn3/ygkR2Q6UiC9WeOVLp33RtcJZUELX/JDDFDue7jQ2iX
3kZqCO0w0+okvKCuDtufg3vS36yp5jR63URS7im0VOa0dPGe61Y2M12WQe/KI+9t
8sdBpcEDUWUMtXWi0YziO4gWsTjIr7phK8EywwM2lB15tUV/bljs7oqhP4yTGJtS
RTmfNgBmZFx6/m2INFrMv7yhtZd4B043ZkjhKiOJztMHbIkKuFhrF/L3WCY5vfuM
FDS9lBFbHY3TQ8A43/dLTMAaN0t2cUGwoVqe1wrgwSDHxfo2/SFq2cgcnMy62jzQ
S0EamAaimNyA5Lt09eQVw0M3to8Mc257H+FEnW+QYxihfu0u2j7pUIX2VMGHkRwi
jlNEYg6qDaF4oSDdM2ToiRg/vqGjpjKO55FpaYvlShCaUPwtD6F9UZT0tGlvuuNA
wRWHEQOI9v3tcR1RrVQ2
=lS1i
-----END PGP SIGNATURE-----

--JXgPQ6VbGllIp4i6--

--===============7756542439339805216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7756542439339805216==--
