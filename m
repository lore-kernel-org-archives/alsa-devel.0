From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Mon, 5 Oct 2015 16:12:55 +0100
Message-ID: <20151005151255.GU12635@sirena.org.uk>
References: <1443722959-5094-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4275342261354417323=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FC92260789
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 17:13:10 +0200 (CEST)
In-Reply-To: <1443722959-5094-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: albertchen@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, benoit.thebaudeau.dev@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4275342261354417323==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AhvJQTq3ZY7+0psJ"
Content-Disposition: inline


--AhvJQTq3ZY7+0psJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2015 at 11:09:19AM -0700, Anatol Pomozov wrote:

> + * - I2S right/left justified: frame consists of left then right channel data.
> + *      Left channel starts with rising FSYNC edge, right channel starts with
> + *      falling FSYNC edge.

These are just called left and right justified - they do look a lot like
I2S but I2S isn't part of the name in normal usage so it's a little
confusing.

Also it's more normal when talking about both left and right to list
left first, it scans better.

--AhvJQTq3ZY7+0psJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEpN3AAoJECTWi3JdVIfQA1wH/3Yo8PnnPjmcX04PXg/MP5zZ
P+lZWRNm4iSu44jbnZ8BN2O4XGBhJ99KZPmcPlmLYdmkirdSsPBvBe91ayuEBExH
pNP9cLg/OrD5vAIu5lPdSMzWR4khJg8JSJUY30/JHRHRXvvLijRjooXtUvZeGsLr
lzgtJp+dTfpw4LiG0eRNZoBnp9FLVA3tAkhosx7kPiw2oW2Zb4kz/RoKHNplNoRi
zl16lo4S/lWg6W/jfKFNXg9E7vDsWjYJs3qF3aHqDkp78F0x4jXPbFOtSEnhJA5l
8+fkfAZAZf/D72pKq+OJRgKCQjI4nlTMdK0Y2LRwt9W+M8AmxW66zu+zGmFmZLE=
=goib
-----END PGP SIGNATURE-----

--AhvJQTq3ZY7+0psJ--

--===============4275342261354417323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4275342261354417323==--
