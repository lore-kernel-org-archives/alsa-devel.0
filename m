From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98088: Fix logging of hardware
	revision.
Date: Wed, 17 Apr 2013 14:33:03 +0100
Message-ID: <20130417133303.GJ13687@opensource.wolfsonmicro.com>
References: <1366167754-14664-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5245884342559283417=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8573326164D
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 15:33:04 +0200 (CEST)
In-Reply-To: <1366167754-14664-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5245884342559283417==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9pltayyoy9lWEMH"
Content-Disposition: inline


--M9pltayyoy9lWEMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2013 at 08:02:34PM -0700, Dylan Reid wrote:
> The hardware revision of the codec is based at 0x40.  Subtract that
> before convering to ASCII.  The same as it is done for 98095.

Wow, someone had fun defining that...  applied anyway, thanks.

--M9pltayyoy9lWEMH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRbqRiAAoJELSic+t+oim9+2wP/034z1aFWEb46dypF+RZn6f9
qLA+HTnxeNHUNPZUYgbYw7RzpBTHLcMfWnqHwmWC8kIXpJbC/XT+X2mWY4LbpTtq
pYzVVW4BfeFHLjW331pJOeC5wD8HaltuScyIcduZRdHbsIoeXTqNh4EOyoL/Tg7/
tYuWym13GtcpQJ8UBN/sZiG7XC+Kdz6rFmmcQVuUevr9+hNdGTLN6LDP07vWFCBM
n2LgDmJLWH2wVe7DAYQpbBTYJIPKI/YpEekYtH+8Nz2FfjCCJA4cYidB3Rb/VT0d
d29b7VK8nBCJtt8ghl1tA56quSg/KJMehllKtEeV7sXWNRrDNavutQB99uLfp8oG
TXvBUqaRJhglLeP0kKDGXfYRsiFOSBGAEKBH4hfqRZ1IM4Z2cFe5ecZcP+uq8lqK
qJQ68HcBcXA752YhiD0vJq+0cKs8wOqr4b7gJjK8QQ1Zf0k3jP0iXdSVQYsO3kFh
rWU7DjIlw0nbZ0C9DAOlIRgkGD+cc9Kn/8Lh/qceIGEPgtsJwj6Ot4BUiMHCMKSt
cvRdBqBHrH33zCXUlhpIUyFJiFEKqO7odW9O1coC4DKUXqdr5+uhh/X7yWzglmOf
o4t8YmtDi0jIdymI+ravpFHPABe4ZduutL5Z8RmC1MEuLQiYKthRI0k18hq7KlzT
d+55ohsQ0AyNsPJs0Aj6
=posb
-----END PGP SIGNATURE-----

--M9pltayyoy9lWEMH--

--===============5245884342559283417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5245884342559283417==--
