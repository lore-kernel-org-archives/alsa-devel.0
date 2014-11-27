From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/11] ASoC: cq93vc: Remove unused state
	struct
Date: Thu, 27 Nov 2014 11:11:40 +0000
Message-ID: <20141127111140.GK7712@sirena.org.uk>
References: <1417031880-11364-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3798522820834233758=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AA778265DB6
 for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2014 12:13:39 +0100 (CET)
In-Reply-To: <1417031880-11364-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vishwas A Deshpande <vishwas.a.deshpande@ti.com>, M R Swami Reddy <mr.swami.reddy@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============3798522820834233758==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/WyilgS7+6IU2yVA"
Content-Disposition: inline


--/WyilgS7+6IU2yVA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 08:57:50PM +0100, Lars-Peter Clausen wrote:
> While two of the fields in the cq93vc driver state struct are initialized
> none of them are ever acutally read again. So remove the whole struct.

Applied, thanks.

--/WyilgS7+6IU2yVA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdwbsAAoJECTWi3JdVIfQXUIH/2nksjuZ8cpruOi0KQu22zPy
m4GXpoZkCkyTL68AZdVGHEuem5OX2dQHdafE6EIz+OYoes7I9tB7qRbqqoMm4UvH
3VTufRG/it0ziHIYFULLi0/MP+TX9RQyq24jQI3rrJa8BUoAvE3CkWTOsMQPNbQ+
uNj3eCeZtZ7OdBu6NCS8jjJfcp4ywyYz8Uh/WkSInPH+ZUuQDzeISH4rKdrqMwDJ
QBI8AR4LFNDKc6IRNoEg+2Bjud4ruxJCSXzg4LucBLzxQHDfNTm4s9zdi4bEssi3
y+qEz+M9Qyj6nKvSA8ssAE896IHfAOdvM1lIE/fpqrv5XRbaq6sifr/SDWcx+2s=
=9RsZ
-----END PGP SIGNATURE-----

--/WyilgS7+6IU2yVA--

--===============3798522820834233758==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3798522820834233758==--
