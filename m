From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Adds push button support for
	rt5650
Date: Wed, 8 Apr 2015 18:14:59 +0100
Message-ID: <20150408171459.GE6023@sirena.org.uk>
References: <1428407718-10641-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6064156878514219438=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D1F72265467
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 19:15:06 +0200 (CEST)
In-Reply-To: <1428407718-10641-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, john.lin@realtek.com, koro.chen@mediatek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============6064156878514219438==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wmp8XYsjNC4bnPNJ"
Content-Disposition: inline


--wmp8XYsjNC4bnPNJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 07, 2015 at 07:55:18PM +0800, Bard Liao wrote:

> +int rt5650_set_button_detect(struct snd_soc_codec *codec,
> +	struct snd_soc_jack *jack)
> +{

Why is this not part of the existing set_jack_detect() function?

--wmp8XYsjNC4bnPNJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJWISAAoJECTWi3JdVIfQvhQH/jhjzyiKfKb76iUGoNzsS/M4
UCHwIHgebZ2UUwGoFgk0EwFIIghlryrKzccq7MCFsF4DOj2fj6X1owevfn33bf+r
2uCJh6/CQyZzNaP7aJVJKS5EeZt0I+3RU1YGPfDTG9JLIlcRk12NO+M05N9tBddP
b7nVZuhOtg+AOO0rJqJmQDk4P/AscVwgdV2JJg9KiTZ/qxJM/stEJZ+x6KCY6iYB
FcfjbXlwNbH5+qXS1QOxF8GN71OcdiA4Kl26J7AuuDZeCcqFrn/rJ8YbzPBGm1K5
P9lnM9xX6m/zOQu15uKCSXS/sjDHfhLyZZCxB9s1GgCGsZipg8gAU4lZCASwHSw=
=wEmE
-----END PGP SIGNATURE-----

--wmp8XYsjNC4bnPNJ--

--===============6064156878514219438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6064156878514219438==--
