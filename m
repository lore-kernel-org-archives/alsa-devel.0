From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: generic-dmaengine-pcm: Set BATCH
 flag when residue reporting is not supported
Date: Mon, 2 Dec 2013 11:24:49 +0000
Message-ID: <20131202112449.GN27568@sirena.org.uk>
References: <1385830845-30517-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2765760195993464315=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CD308261673
 for <alsa-devel@alsa-project.org>; Mon,  2 Dec 2013 12:24:51 +0100 (CET)
In-Reply-To: <1385830845-30517-1-git-send-email-lars@metafoo.de>
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


--===============2765760195993464315==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gubR/AMv6tbKMdmr"
Content-Disposition: inline


--gubR/AMv6tbKMdmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 30, 2013 at 06:00:45PM +0100, Lars-Peter Clausen wrote:
> For dmaengine drivers which do not support transfer residue reporting we update
> the PCM pointer with period granularity. Set the SNDRV_PCM_INFO_BATCH flag in
> this case to let userspace know about this.

Applied, thanks.

--gubR/AMv6tbKMdmr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnG3+AAoJELSic+t+oim96pkQAIiVVL/rKT2N1YAnJw9cL1ix
fPZ+QleMABguYW30wkYXcKanGXJxcQbr/dsr9j4I5PB097XD1wpxx94Zv7vQO+WQ
nGjKRn8KNrZwqpqR2VhA3BRQJvthH/1GQI7bD1HKiW7hmhH+PKBtlttj/Rl5F55r
rScXqQuTcyr7gWW0vd1hLMzg1lMWKYz0kYT3lhSszIiU/XBsuCxroHngGzl6N+TF
XumSWfcO0ru4XCf7ja+ARS1HUb74kg0oAhbPY0Ri3ZUZ+U9x6aeUWMYAZ3k9G4uP
Gw7fAikZJbhfVo/xfloC96yMS8WQKrHh99Mk406xMP9tB8cEbmmlOmB7ZiSt6E4i
aIVlNl5sCZoXLn261Dmjwds/FiDU3KS+pOkdcfDMP7jiTPkKuEZAPTLbToF8r1Yd
JfhDD23X6fIkb+8frLrf5QcadT4dJ/WxcS9W+fxG7o9eOfuq3ww37WH9k9xXwOID
rV7gnVY42sgnsnaABY3N+mGBf7Y9nNUS1yUVSU4ZOPCk5Mpb4rd+XZubPBX2TT5d
Jqe/ymvfyUS11cC/ShZ6yzhAq0AGuiGGfkwV3uXqb7rHZFABLVZ+dkx06fvmARlU
5+OsxYZM0QhUovnYnxVLcBBZdfOmMhea+7CSt695RUoVtRxYkQ4cXl0MaXpvon2x
KXiPkoJ8rcihqf7CK0+3
=pgRU
-----END PGP SIGNATURE-----

--gubR/AMv6tbKMdmr--

--===============2765760195993464315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2765760195993464315==--
