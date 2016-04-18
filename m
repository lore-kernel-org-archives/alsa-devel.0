From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: docs: add clocking examples for DAI
	formats
Date: Mon, 18 Apr 2016 12:31:43 +0100
Message-ID: <20160418113143.GV3217@sirena.org.uk>
References: <1460972390-30149-1-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4484507145773881376=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5AEA32608CF
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 13:31:57 +0200 (CEST)
In-Reply-To: <1460972390-30149-1-git-send-email-peda@axentia.se>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>
Cc: alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, peda@lysator.liu.se
List-Id: alsa-devel@alsa-project.org


--===============4484507145773881376==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8EXHJdkEfksMlRxO"
Content-Disposition: inline


--8EXHJdkEfksMlRxO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 11:39:50AM +0200, Peter Rosin wrote:

> +I2S
> + .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-. .-.
> +-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-' '-

There is an actual spec for I2S which is going to be clearer than ASCII
art:

   https://www.sparkfun.com/datasheets/BreakoutBoards/I2SBUS.pdf

is the first hit on google (there's a bunch of electrical stuff in there
that gets roundly ignord these days but the clocking stuff is in there).

In general I'd rather have some words rather than just pictures, ASCII
art as the only thing is pretty hard to read.

--8EXHJdkEfksMlRxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFMWeAAoJECTWi3JdVIfQ66kH/j4GK3o9jbZUxJ2suyW0kBTP
jgeeyrZOsUotvdwedx4pjeS5M3kHUzOs7GHY9i64yTEr8Mhq7bz22+Nff3T4cdZg
lEGH/Hg4/kpoZa392reLBeLo/S5ZXeGZcmulW0d1n78u6PqMUbGUZ2NTyZFCh4QG
o8iX3CpPtCCq/OXneM4aDsfEblr4YDxLnJh0XgWcSfrQpeVfRKPY4ryvc8kTh3MC
9OTAe4p61p+V+z6niFqSJHy5MdbkU1JgkrQ3sn/P+6FtOYE7zUMpW+2IIWg9tBlN
xcseKko05p0y4oZ0o3C3fJ4/j5FrxOz+CXIsfiaWAKXkYT8md3169a2vu+As41g=
=+bRs
-----END PGP SIGNATURE-----

--8EXHJdkEfksMlRxO--

--===============4484507145773881376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4484507145773881376==--
