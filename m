From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: adav80x: Replace w->codec with
 snd_soc_dapm_to_codec(w->dapm)
Date: Mon, 17 Nov 2014 10:24:42 +0000
Message-ID: <20141117102442.GQ2722@sirena.org.uk>
References: <1416213456-5987-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1713213334900063912=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E804F26152E
 for <alsa-devel@alsa-project.org>; Mon, 17 Nov 2014 11:49:53 +0100 (CET)
In-Reply-To: <1416213456-5987-1-git-send-email-lars@metafoo.de>
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


--===============1713213334900063912==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rUztinBX/EQDJOOk"
Content-Disposition: inline


--rUztinBX/EQDJOOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 17, 2014 at 09:37:34AM +0100, Lars-Peter Clausen wrote:
> The codec field of the snd_soc_widget struct is eventually going to be
> removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Applied, thanks.

--rUztinBX/EQDJOOk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUaczpAAoJECTWi3JdVIfQktoH/2D6afsQZE6WcZpb7UW3jvqL
94PO3q89pib/i8wANSPBSwl3rqlj0aqAAxFqfuj9wOTTFskqfTpGkEXYHT+jcsUO
xoGEGqCPCHKGaScASvLSOc0dwtJglXCwrbuk4VKgtJM77bYllV4COlLB/olj+AL/
BjK23UZsLTlY3/NrFv9BS6OnfrkfEf/CrHfQsVur+JkH8Cbq25bw9yobIfBGX3lC
oIXkTS8kSqCfk6t70ilxvBn7Lnh+pOSovkw98WxBH8kcj40oC3CrInpXqaiDKUjI
suDYeohGWc+UU7PWsLGNvRSxtkHwFQzD1JOHDpTCAJo2XaxyWD+DtCfTUa5M0Iw=
=y+ZD
-----END PGP SIGNATURE-----

--rUztinBX/EQDJOOk--

--===============1713213334900063912==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1713213334900063912==--
