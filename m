From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: tegra_alc5632: Use card DAPM
 context to access widgets
Date: Wed, 8 Apr 2015 21:10:11 +0100
Message-ID: <20150408201011.GO6023@sirena.org.uk>
References: <1428059048-32315-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7063458981316458423=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AA4872606E2
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 22:10:27 +0200 (CEST)
In-Reply-To: <1428059048-32315-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lucas Stach <dev@lynxeye.de>, Liam Girdwood <lgirdwood@gmail.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============7063458981316458423==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MPbi04vS07RSAQLa"
Content-Disposition: inline


--MPbi04vS07RSAQLa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2015 at 01:04:05PM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct will eventually be removed
> (replaced with the DAPM context from the component embedded inside the
> CODEC). Replace its usage with the card's DAPM context. The idea is that
> DAPM is hierarchical and with the card at the root it is possible to access
> widgets from other contexts through the card context.

Applied all, thanks.

--MPbi04vS07RSAQLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJYsiAAoJECTWi3JdVIfQjfEH/isJvQX9D5sd5bTRmf2rcUF3
9cSIdJMEvZWHrtWkMfQmJCSrkuUw52pA9hkfzlIrVBEt/ZjQHq5oR21v5uCmmnRB
KyZ4O3B2kPD2KIt0tYnEi9/CTBt40So0HPI+W574Ordvvb8sdOLCXk47wyFx48nT
+91x2yi2CSS06JtiESq2zNju/vKHT0DA86dbJjpOM5KT9D5HlYdBk+huzEY86R4o
MQEF6OiojnriuG4POVlysbggPzkYVqaYU6arCVBZLjgt/NG3Ab/8lUFc0S2T27sQ
C5cFFCX69qDOQ69PhpggHK/X3UKAHbOjxBAehFcXKh8YBSzQYYpOObY+bfZCpL4=
=IaUh
-----END PGP SIGNATURE-----

--MPbi04vS07RSAQLa--

--===============7063458981316458423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7063458981316458423==--
