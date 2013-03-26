From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Fix to check return value of
 snd_soc_update_bits_locked()
Date: Tue, 26 Mar 2013 14:10:40 +0000
Message-ID: <20130326141040.GX18316@opensource.wolfsonmicro.com>
References: <1364276465-13238-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6820676984769801903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4297B265096
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 15:10:45 +0100 (CET)
In-Reply-To: <1364276465-13238-1-git-send-email-jy0922.shim@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6820676984769801903==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zll6mx50Q8J7qlLQ"
Content-Disposition: inline


--Zll6mx50Q8J7qlLQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2013 at 02:41:05PM +0900, Joonyoung Shim wrote:
> It can be 0 or 1 return value of snd_soc_update_bits_locked() when it is
> success. So just check return value is negative.

Applied, thanks.

--Zll6mx50Q8J7qlLQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRUaxZAAoJELSic+t+oim9B+AP/Rr8YF5S+jbeaQeJCmcuhWO9
1o2DRA3XH4C+sXKKRfCfyXBthBCMci/ZbgsO+rElfEZ6NJJ7MRefB5GC3yaGzb5v
xl79jroZyfLSAiE4+SpSV5HZCJJwKJzRjXwm2tzP1bX7f0a+Tgu82jz3G7dq3QOa
B0P0vhEwoYW1xslK7Moa1huKtunw0zSBxF0LLnBI4E9d3ZBcOKWXViJzZfES2eoM
UGsKfzph8ZNnR9682jExvHa0oqTpxuYqk74ElrO07nv28YZFJD9kXBiERqdOLEXK
JE9tddICtcy8BC5nfKnAm68y6Q79eYRGXCywxFCE44AKUKAMhtN4fCpsfTuLO3Ka
QeHcSvR0dEHEfaT/UofhObxR0gJxWX6Hlb+NAQ+Jl/40+2KNrWzqrRDvFVp3QuJn
0oFEEUKss1KftO8bnpceTZl8CjR5SOqaAu0//Cc5jSaQnO2oPnN+ntdYXLL30RaY
yaMIIrpBys+LCdbP4Nrcezgn6CcN6PjLjx24Dv+jh8vJrUUMNMkgnjBXpndjCXJG
GE0SAm8QDOQ94yQRwkZowKrbvwihC3iFR+v6IZiqiu8M8vip1+usisZwlDMK0QR8
+qwS7qXlHObag7KdLgQKkiFf5OuEbzPl+REXF3aPMAUOBPFo77Q3IRNxUuufun4c
FO7Zsrv5YiTpW0CbT3o7
=bozu
-----END PGP SIGNATURE-----

--Zll6mx50Q8J7qlLQ--

--===============6820676984769801903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6820676984769801903==--
