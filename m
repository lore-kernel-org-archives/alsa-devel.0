From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: adau1977: Fix reset-gpios typo
Date: Tue, 19 Feb 2019 11:11:17 +0000
Message-ID: <20190219111117.GB6319@sirena.org.uk>
References: <20190215102633.12700-1-bogdan.togorean@analog.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2419714198574446430=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A1838265523
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2019 12:11:19 +0100 (CET)
In-Reply-To: <20190215102633.12700-1-bogdan.togorean@analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bogdan Togorean <bogdan.togorean@analog.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============2419714198574446430==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 15, 2019 at 12:26:33PM +0200, Bogdan Togorean wrote:
> This change fixes a typo in the dt-binding examples (reset_gpio ->
> reset-gpios).
> Even though 'reset-gpio' is a valid construct for gpiolib the naming
> 'reset-gpios' is more suited for dt-bindings documentation.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--0ntfKIWw70PvrIHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxr5FQACgkQJNaLcl1U
h9CtnQf+NoJB0Yopx+2IR5L4aN935UsJkKu/UFQZm9ByCB5Ic21EO56CYe8D1u/0
uxPiG00M3Q1SNMQpvlwVQhzu/BHVq4YQ5x9He30BoayyO8Y2mPXfHB7cfcBCD57p
+FvygqrL7cNoWmgfj+elab0guvOhGe7cKUEGjrRv1tPYcWrZJf7rZZR/mLB77TTl
oNJm0cun4t7RXIIdctqEctee62y5Un9gCYU0YLUHE0zRYBHH1mv972+aOk6FLomv
WY/jtL2rTnWOxluYUNSw0CXSewB92YF+pYSzt5NJ6HF2sv0uyh11GEYs5N6oYoAo
3tklYgbQHUiJ23m7O0mKIDxLGbrAaw==
=S90x
-----END PGP SIGNATURE-----

--0ntfKIWw70PvrIHh--

--===============2419714198574446430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2419714198574446430==--
