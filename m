From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pass snd_soc_jack_gpio to
 jack_status_check callback
Date: Tue, 18 Feb 2014 10:16:52 +0900
Message-ID: <20140218011652.GP2669@sirena.org.uk>
References: <1392528972-9440-1-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8863758153372205129=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 91DA9265114
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 02:32:04 +0100 (CET)
In-Reply-To: <1392528972-9440-1-git-send-email-xiaoxiang@xiaomi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xiangxiao <xiaoxiang@xiaomi.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8863758153372205129==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l7GkBbkEatsaRqBf"
Content-Disposition: inline


--l7GkBbkEatsaRqBf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2014 at 01:36:12PM +0800, xiangxiao wrote:
> so the implementation could get the context data
>=20
> Change-Id: I5542613ccf9881deb672e71d0f0c4f603ad761fd

This shouldn't be on upstream patches.

> Signed-off-by: xiangxiao <xiaoxiang@xiaomi.com>

> -	int (*jack_status_check)(void);
> +	int (*jack_status_check)(struct snd_soc_jack_gpio *gpio);

Why is the callback using details of the implementation of
snd_soc_jack_gpio?  Perhaps there's a good reason, I'm not sure and
you've not included any implementation.  I'd have expected to see the
jack able to provide its own context here?

--l7GkBbkEatsaRqBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTArSBAAoJELSic+t+oim9PkgP/1gNvnP5bO2IQH6NPOqkYqiZ
LYqLK4pup7mEvCscu9mojidW68Muq4NEERXoHmiM6B0rtt8V2m6AWmQROmUFuORT
rnCRhlgEQScj4hh8ZvvIVd4Lg5qtpOCoC5aMR6Era3kOvt0KgohsHAMDB17ZN6Av
OHuXp9OF60x/xSC3RHBllJ/tzg1R9v9NPLFbEjTJjFurxhFymx6lIh6+DbpUZ2oK
/moCV4eEJhS8a+ZWaxVbu4QL+iJWYnHh5bHxGxLMe7Tqxg0303wqf61rqialnBO2
G/AMvZBGl8A4IlnY7c5RYfUIc3nMFSj4h68oEPDBVX7piHs7VoM0glO3vWmw9E6j
oVWNfHlj2gPKmwh8JVPYIlIrDUBnT2h14uR65VjvBwI1sgR0604OCYEJyK84ZTvh
HJQK9dExK6pKKdi6cvbEAYr00wL+QBSAMAH4JifayvqUZCijrj8PrKh2SQOHJ1dK
jHgSzda+HE6xS7ow+etjCSLaNi23sjKsdsNJTqYGuHOsa8Q0PeF8bE6R0NuR0n+8
8vKrI+hvL6pAMHoJAwwTGGS2SALrUf5lmiuIUvoMgvbwjuphIhGOxvj8VqhdNR9r
HIyw92jwphZ8QjH1jG23s3hKZ0h7lTldjBm72qWZIm49EVZDzPg8q1e65ueONpLe
jrvCuxfGF/FoVWG0FW7X
=2l/f
-----END PGP SIGNATURE-----

--l7GkBbkEatsaRqBf--

--===============8863758153372205129==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8863758153372205129==--
