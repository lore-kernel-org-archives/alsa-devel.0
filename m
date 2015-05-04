From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: lowland: Use card DAPM context
 to access widgets
Date: Mon, 4 May 2015 12:55:50 +0100
Message-ID: <20150504115550.GF15510@sirena.org.uk>
References: <1430674030-1388-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0163976842308827508=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 991DD2625EE
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:16:06 +0200 (CEST)
In-Reply-To: <1430674030-1388-1-git-send-email-lars@metafoo.de>
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0163976842308827508==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 03, 2015 at 07:27:06PM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct will eventually be removed
> (replaced with the DAPM context from the component embedded inside the
> CODEC). Replace its usage with the card's DAPM context. The idea is that
> DAPM is hierarchical and with the card at the root it is possible to access
> widgets from other contexts through the card context.

Applied all, thanks.  Whenever the headers were reorganized to remove
references to the mach headers these dependencies should have been
updated.

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR15FAAoJECTWi3JdVIfQRcUH/iFbKlPUai95aBqLhGzmidGJ
6rFloKIinqcwgoJzbRzuIggblPSbIDedpGIbhbAk8gVXxN/tfxivB+cVH+LA0vqd
0qnSFR7CseDm3FC2YLyRw7Uc8JUmgQZj9c/2h02YDQTe6j8NqSZM+iKnzBF3cBlI
NpRoj1fkpz1zGUdvnCfrpNKP9Qq7gJYrT/E4cHLbs4Tpg2u7IB6x+32cV6UmS/FA
GGQU6q1Na5iUqJK/v09MDZmHYtIx//IGYGofSAXjJMdu6z5tBgNHdMtG9WKf0+n7
jdCXvuo6eoKMx9L7HZy5hLPLcu8ngsn10RayoI1+ZqhAbd6hNKmmnpNCt1HqzL4=
=XApT
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--

--===============0163976842308827508==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0163976842308827508==--
