From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv4] ASoC: Add support for BCM2835
Date: Fri, 22 Nov 2013 14:05:19 +0000
Message-ID: <20131122140519.GN14725@sirena.org.uk>
References: <528E4E4A.20403@koalo.de>
 <528F5CE3.30105@koalo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1933143428570225189=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 27D05261AC1
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 15:05:24 +0100 (CET)
In-Reply-To: <528F5CE3.30105@koalo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Meier <florian.meier@koalo.de>
Cc: devicetree <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>, dmaengine <dmaengine@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============1933143428570225189==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5FetH82qe0Z6y/zI"
Content-Disposition: inline


--5FetH82qe0Z6y/zI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 22, 2013 at 02:32:19PM +0100, Florian Meier wrote:
> > +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev),
> > +			   GFP_KERNEL);
> > +	if (IS_ERR(base))
> > +		return PTR_ERR(base);

> Found a typo here, should be IS_ERR(dev) and PTR_ERR(dev).

No, it should be a check for NULL and returning -ENOMEM.

> Is the patch acceptable apart from that now?

Not looked yet.

--5FetH82qe0Z6y/zI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSj2ScAAoJELSic+t+oim9zCAP/1zcMpvVJkYKLvp/7mOKlugP
ercKdvPV12HmeNnjiHyzJemq4qjlAsShvsxX6lYZmuofLFzO9pxA+isiiq+9LqDI
eLO0QXCXnVywpn+B5w76XPr5EzAwm1p6WyPIS0TXRGrAy/27qY42+LG6MG5IA5Sb
Htc+Xx5BttNH5mTf0t5OpU7+zWyac3t2B5e/RJ+6ru0IpnA9Z4C3pgiosW8SBrUL
mEQk+msKKryQ2nObVjiIK0QAdEKhg5pGn4/VYFebAUYV/xzM7+xSCpWu62vcHMAY
msvam5ztE+27Dow63aop75V1JzPIhNY3XYk/T3TY56XDQ2rCrT2G3Q44JmztM1Xk
cIebndq29Ub4wY91QN5B2HBm2dJtLT8+3wf8WlS03QiEHpNIj5T+HlGs0LAtKVFK
5SVyOf7Ojeks7iYPplp98v33Z3lEdqmex4oTJjazHfdz75xA2SH7Ap9m1XnMRSVS
f8TpKMcYXS35NhueVvf/yt2ddKiWzNQ8I01ZwjrJLJtoPgdfdf+Cd/PMgjvenJB0
Az7FryN+VSZrV9SUpmjEFpd79XilESSlz32QK6W76KnUTZJe6opERmL15R41el9r
zmm52IcG2GoSJeiIs7f/Std6rg1/M2183X1QORfs0JT+JTrLAOsju1yzzEKGVNHw
G8mzWLMskQgZEGdAyoz0
=0yDE
-----END PGP SIGNATURE-----

--5FetH82qe0Z6y/zI--

--===============1933143428570225189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1933143428570225189==--
