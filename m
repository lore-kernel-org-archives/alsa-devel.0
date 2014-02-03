From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/6] ASoC: tlv320aic32x4: Use signed int
	mixer controls
Date: Mon, 3 Feb 2014 12:47:51 +0000
Message-ID: <20140203124751.GX22609@sirena.org.uk>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
 <1390824190-18376-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8840798057659665060=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A745260885
 for <alsa-devel@alsa-project.org>; Mon,  3 Feb 2014 13:48:01 +0100 (CET)
In-Reply-To: <1390824190-18376-4-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org


--===============8840798057659665060==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9FlPK/CTwZII6yRd"
Content-Disposition: inline


--9FlPK/CTwZII6yRd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 01:03:07PM +0100, Markus Pargmann wrote:
> There are a number of mixer controls that support negative values. They
> use signed values for this with different number of bits for the values.
> Currently they only support the positive range.

Applied, thanks.

--9FlPK/CTwZII6yRd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS74/0AAoJELSic+t+oim9cKwP+gP7Db3M7cb/Fdt7YmIvazQE
fGmCzY0qZCZNoW+upl7XzIApy44/EyWx06h0e9LGe5Z1sm9mfoplpTajThJUshJx
13g6wLK+BhqIksKH/o2UhyQ53QBbb72nOvAilhC2MF3rZQXQsPrlvXl2WPfdwKvw
dcPkF5NjXofG1pcp4yHY/tkAdn4JuMmxe0sTpMYm8+cc79nN55Ak1bXGC1N9TigV
n97DZpOfhvUvT0/GJgG9JwQzE/nhYjKe7Hn0+G6BCpGYMErZvJHXrvZ+xxxM0N8c
V+RgR4Bn+takeYY5o0LX6Y+EnEvHEgCP61KK5YsneXX2L0o8ifG9wWluFVKGzFDs
BGJaz6EHHxzjOqpi3AUri0ASwGwORZ+gcKh6CiBaeq257pSWT9xI2uoARgJB/KUg
ZbTFKnu1LFdZewq4sa47QBFpNOV3cb9xv21m3F3VSGZEK8W51LqOuxYnlBELVzf/
Z25OXawdYNRPEtUKa1MvVF1wtpE1ILDyqk8yTdhz2XeNK5pRwhe3NyZle/1nyL9M
lHsL30OETtMXvtOhnD10o4pzlb85ll1Lwpgh93Pjmle1M4PDDJYSZR8v9cs07uOm
rQvOmmmidlWjpvibgs4vx7pduup8gyi5TKNG7eSeyHVmxQ1RAf6mrKfuMWjQqyzt
6FqSexPLbwTsxF1rUdPi
=kN0D
-----END PGP SIGNATURE-----

--9FlPK/CTwZII6yRd--

--===============8840798057659665060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8840798057659665060==--
