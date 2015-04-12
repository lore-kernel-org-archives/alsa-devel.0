From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm1133-ev1: Use card DAPM context to
	access widgets
Date: Sun, 12 Apr 2015 12:42:44 +0100
Message-ID: <20150412114244.GZ6023@sirena.org.uk>
References: <1428749521-7426-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1389428084782375033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7367F26056A
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 13:42:50 +0200 (CEST)
In-Reply-To: <1428749521-7426-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1389428084782375033==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vn58GiPRGMJY6CXW"
Content-Disposition: inline


--Vn58GiPRGMJY6CXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 11, 2015 at 12:52:01PM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct will eventually be removed
> (replaced with the DAPM context from the component embedded inside the
> CODEC). Replace its usage with the card's DAPM context. The idea is that
> DAPM is hierarchical and with the card at the root it is possible to access
> widgets from other contexts through the card context.

Applied, thanks.

--Vn58GiPRGMJY6CXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKlozAAoJECTWi3JdVIfQFAkH/0T751vnZehNnht95JWzpPyI
EuPzBaC9Hq0Z+DS/5jLKl5/U9QneYqWnlZsV64fRa79JxvmM/SrH2A6IcoPVJN2d
UoCMnYczE440k1dqRQkY1wBYYDRDd9I+7OnrK8IYQIXM/3cT5Qy573v6eZSWRQu+
J9V35NZPgodgJY5WaRs4j3V/swWJZKglKjj95c5wsUH34XK7oea75RYzO98rcsyW
W1epkFM0UGv/PrSGiYp0gy0wngRkX8bIA7EYshM+GSEqfUxF2zQZ8/wvWUMl2kWK
uLHjDQ8QNlxfJ0DlyrGhFKLzYD+EOdUTAWy7tJ0xwQ34MJQNfiow9takxcpRcWQ=
=r7ZK
-----END PGP SIGNATURE-----

--Vn58GiPRGMJY6CXW--

--===============1389428084782375033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1389428084782375033==--
