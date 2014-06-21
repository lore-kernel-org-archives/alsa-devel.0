From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] ASoC: tlv320aic31xx: Remove duplicate
	const
Date: Sat, 21 Jun 2014 20:57:49 +0100
Message-ID: <20140621195749.GJ5099@sirena.org.uk>
References: <1403163631-26215-1-git-send-email-lars@metafoo.de>
 <1403163631-26215-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3233757140072064257=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A91852619E5
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 21:58:20 +0200 (CEST)
In-Reply-To: <1403163631-26215-2-git-send-email-lars@metafoo.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============3233757140072064257==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZZEGMFFBHS0xR+g5"
Content-Disposition: inline


--ZZEGMFFBHS0xR+g5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 19, 2014 at 09:40:27AM +0200, Lars-Peter Clausen wrote:
> SOC_ENUM_SINGLE_DECL() already adds the const qualifier, so there is no need to
> manually specify it.

Applied, thanks.

--ZZEGMFFBHS0xR+g5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeO6AAoJELSic+t+oim9Dp4P/R77d79jKGKByN7tO20nb91J
Sah6nWb1GBP99hkD6qh69GCmJTLIdvCfHWOSRdc5mtz1g+iw+wX81szMSmEz52xM
fC4WbFZQmcRBjhRA1Q7XoE8BxcblWRzmywQqpnUu7C0Aw+uV1R1vZIuOFCVyRX7L
EUrdUoWssyJQK6D0LuXT2zqs7Bem6SF+60dCRHdafg2tRLznMAx7QAr++mJy/gKm
uQbHL4yWdVzF3/efwpgOSUzuJi4uHfeVqPU18dk7+2GrZupRbY9R5PaC69La6w19
0t0eUtNTFl9gI/ult9KKWYgDGVXDGXy2tIqH6EdXj3HUfq7ffD4NScdQNpyJ4Njo
A7UxTYaCJm0rMu4u5EokMbFfHMYRzmmGoA32IUNcXJdm8SdEtoICL0wvqkX4WO78
wq9itd4tNJ0sHu+DLfdK9mTfbly3Li8w6yYiqk9vYAn48NNJZC15al647ImqgAkw
EI5QDiOIZkuKDuK1hrF27+VZMWDLOfVFRCqTD6EWBXNrQ1v/8DRrPLET9wAIn1nE
RQ03ta+VKLuVId1+KYRWGfSgLnugKRv8giuhm286SVOTnSqhbrb4u2nl9tVymhr8
+g8Va+WaXvh45I7bCSeDCOpMVe6XxFb9pvAkI0LPaE/Crl/Rb8KFoDO5qA+EgwzE
BJD2tU3hWti2eckLKNcY
=ArsN
-----END PGP SIGNATURE-----

--ZZEGMFFBHS0xR+g5--

--===============3233757140072064257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3233757140072064257==--
