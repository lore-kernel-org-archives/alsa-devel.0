From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Add API to set supported jack
	type
Date: Wed, 6 Aug 2014 21:54:21 +0100
Message-ID: <20140806205421.GZ17528@sirena.org.uk>
References: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2578459888023934088=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 525622619D8
 for <alsa-devel@alsa-project.org>; Wed,  6 Aug 2014 22:54:34 +0200 (CEST)
In-Reply-To: <1407217970-20126-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2578459888023934088==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nwFUwwwa9Vid+Y3g"
Content-Disposition: inline


--nwFUwwwa9Vid+Y3g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 05, 2014 at 01:52:50PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> RT286 need to configure the jack type (combo or non-combo) according to t=
he
> HW design. This function is given a easy way to set the correct jacy type
> for those without platform data supported.

If this is coming from the hardware design I'd expect this to be
configured via platform data or firmware data rather than with an API.
Why do it this way?

--nwFUwwwa9Vid+Y3g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4pX6AAoJELSic+t+oim9V6IP/3uxfVC4mhfTAs0f73vYZWpD
sYPpJhQtB15OJsMEN+SUyJa770GZRfnYugoZxUCoxki9E0f/IGkgKYOhyZyeB76V
zpXZTjDoext38Hj2sDI3TqGc9hs9Mhzek1/T+TgX1M6jcITcOSqxxhxsJM4uGDWY
w9JDTfOD9ErgqrpPQJ269F0PKUqBsvcX9imjimBiXDga5uxtjnnU22qCFIfqEkNI
pdEcP2hYgGxu48PX7tmUFufrALcqC0GaY9QQbbgpbCtHjDmgfSmjEp1g/aipso0l
25K8biFPA/ngoldyi6lbFz92BP6dWik2JnBd+ljzRxGCOkFhX5X8yhIvs+u4M2sz
8XW/OzIMu9soytCc+uUZlm7Skyae9c/bAP98p9wV6OnFd4vJa5RhmS84XR93FYuC
WQu+56QI/IN6WzVOe1ROtQcNTzAzoz79E9gO8LG50UPpYcl0VzzA5O8z8Q5VE8h4
ni1yztChmz0vN4oBvjctkaDNtytLAhSXgSfOoNG1Z8wHCRsgT/dr9aWwl99xlEds
bE1bLAgEWyzU2fJmkIdn6R2mhMBgD6ufdltm7UKTTqiKQu8dTEVAHJOIap0Pdfjh
sWiac/igfC71712ktvVc9V/pzaXn5qiF2KklBN9rVx8youOf4Cq4k6GFzYWafzRy
C3fmR86gXYQ3/9sCWmVR
=3+r8
-----END PGP SIGNATURE-----

--nwFUwwwa9Vid+Y3g--

--===============2578459888023934088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2578459888023934088==--
