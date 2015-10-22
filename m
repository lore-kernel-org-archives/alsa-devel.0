From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Let snd_soc_limit_volume() take a
	snd_soc_card
Date: Thu, 22 Oct 2015 13:49:07 +0100
Message-ID: <20151022124907.GI8232@sirena.org.uk>
References: <1445180673-27790-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2876795150330250657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F27F266D19
 for <alsa-devel@alsa-project.org>; Fri, 23 Oct 2015 01:34:46 +0200 (CEST)
In-Reply-To: <1445180673-27790-1-git-send-email-lars@metafoo.de>
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
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============2876795150330250657==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G3juXO9GfR42w+sw"
Content-Disposition: inline


--G3juXO9GfR42w+sw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 18, 2015 at 05:04:33PM +0200, Lars-Peter Clausen wrote:
> snd_soc_limit_volume() operates on a card and the CODEC that is passed in
> is only used to look up the card. Let it directly take the card instead.
> This makes it possible to use it when no snd_soc_codec is available.

It was actually in theory supposed to be a per device thing but indeed
that's not the current implementation.

--G3juXO9GfR42w+sw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWKNtCAAoJECTWi3JdVIfQM/AH/A9C8Y95tURxEGlbDWFA+e49
1gNKuU3x3bhe1M328CnfVfHRinMCjuGbJPa1KMrOt1UOUztKXvPRRf26T/jKahvV
by68b3aeKnWZsazrwyxctOqa4S3bWMoXgR6+7JOxPiYp7sxRZv4FrSFxBTX5uz1c
7Ct3HLlMwi291HlZfQIovcBMgdRnX8FHxf/B3R2K+0kXfEqbHQNEY+9HKanqTr78
+Z3G6TaH0kutlL4pch95HT9F6xKrqWqh3OYEoTloweuaXVNh7NacuUYNvZZwhaRf
dowxCelAeVKiG+a6wmtxNfVFJhIo8ecsksN3oPUtxfygbrwSL2Ax0tWTj032ui8=
=8HFq
-----END PGP SIGNATURE-----

--G3juXO9GfR42w+sw--

--===============2876795150330250657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2876795150330250657==--
