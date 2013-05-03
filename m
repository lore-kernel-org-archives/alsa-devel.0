From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: McASP: Fix receive clock polarity in
 DAIFMT_NB_NF mode.
Date: Fri, 3 May 2013 09:30:15 +0100
Message-ID: <20130503083015.GF4945@sirena.org.uk>
References: <1367559456-20208-1-git-send-email-marek.belisko@streamunlimited.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6966399053600823105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 62F7326529D
 for <alsa-devel@alsa-project.org>; Fri,  3 May 2013 10:30:34 +0200 (CEST)
In-Reply-To: <1367559456-20208-1-git-send-email-marek.belisko@streamunlimited.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, linux-kernel@vger.kernel.org, zonque@gmail.com, Marek Belisko <marek.belisko@streamunlimited.com>
List-Id: alsa-devel@alsa-project.org


--===============6966399053600823105==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 03, 2013 at 07:37:36AM +0200, Marek Belisko wrote:
> According documentation bit ACLKRPOL is set to 0 (receiver samples data
> on falling edge) and when set to 1 (receiver samples data on rising edge).

Applied, thanks.

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRg3WUAAoJELSic+t+oim9iXEP/10GJesDmFRXlzzdmtB1JDYy
WMaP4gwQOqPJRg1HIbp97A0d4XEK29lhnbSGN0428WTZk96scSzgtunXN0dFdV5c
WopOHUS/YcXlFGp9I2KYAzH1S8BbnRhkUN1rD0EWC2PUEj2tQc637zRntKh77S/y
WYbt6dRUNzihLZpO+WVqzlcKNyqZaeagFiuxcClpunXwok0NwjaV9r0KNxkD3JK/
dgfrOIzbHZUWCwJcuo6k3q1d24NPjH7yjByDRJKguLYmYYNuLbA0VZaxv0aaReEL
+ba7XKJUWDUCEybcpsElbzdTggJ8uVOsLW0vC93JWVPeBeJn1Oebol6iez92TbdM
kPjy3ng8Xcuo50Ve1fL70aRHiOuKaQI9FagiecK/e3YMJECjHoUwITD/wx6zm86g
I3seGNRR3EpisoIa5w598mOwkKxO/Rw92PQcT4kfGmeuzX8f4p0bR6mtZR9BQfS9
Y7Hpty6EZfiZIX/t3bjJaR549rerON9Ar6SyfOnALqt89o0bYk2wLMymQSQzijAq
SSIAV+HAZEU1jZ94+Yy2q5BY3w1fZA2xsBFNhWHg70H2isdn1ktttlzIbxS4t7EA
kxMbWoe9zPn6bXg7tCrypJ7u3hDEaa6Y2SeMiYgb8oDrd2E/FYytwmqKXTWhLDkU
Bp9XLSaauRJDjHl2mpDI
=62Tf
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--

--===============6966399053600823105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6966399053600823105==--
