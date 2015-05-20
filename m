From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/7] ASoC: alc5623: Replace direct
 snd_soc_codec dapm field access
Date: Wed, 20 May 2015 11:20:21 +0100
Message-ID: <20150520102021.GC21577@sirena.org.uk>
References: <1432064952-31997-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8291248100379375408=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E9CFB2615C0
 for <alsa-devel@alsa-project.org>; Wed, 20 May 2015 12:20:31 +0200 (CEST)
In-Reply-To: <1432064952-31997-1-git-send-email-lars@metafoo.de>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8291248100379375408==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 19, 2015 at 09:49:05PM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct is eventually going to be
> removed, in preparation for this replace all manual access to
> codec->dapm with snd_soc_codec_get_dapm().

Applied all, thanks.

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXF/lAAoJECTWi3JdVIfQJXsH+QESE3dS3y5+DCHY87g4hDM7
hl3Ch+L+cIWpg1IjmkOkt61gt2qqv9DFCl0GMw1GSyvOlAz28JoPd+/kYa3Xcxwm
Fk2VgC5d+QwQLZxfcZJ/J/HP6bxzbwFiAmA2mMMzqGW78kMEUXfWwU6vNRVRD9Tz
vsTbUY3jy3EUvMG1877axGxWiENQzwTJwClHMuTALmDtbTyKnLDKxmrswM0KPtr6
6CnUkiMTv9cmMfA0ldW+s3NLRZAAan5RajjL09WBkdn+VlrI8jz7sGzCVf98myH+
RgRqPXt8gfp5LJES109TVfTHaUbVBMYqq1t/5ez3Fj06fK7qC4OHtyMuAbiIOZw=
=N1Ta
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--

--===============8291248100379375408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8291248100379375408==--
