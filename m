From: Mark Brown <broonie@kernel.org>
Subject: Re: What is exact definition of "normal/inverted"
 FSYNC signal polarity?
Date: Tue, 1 Sep 2015 13:14:30 +0100
Message-ID: <20150901121430.GU5313@sirena.org.uk>
References: <CAOMFOmXwfBydswh0BiSOB42KMa0T+0-W1mj0=d4AhisToFxkVg@mail.gmail.com>
 <20150831180250.GT12027@sirena.org.uk>
 <CAOMFOmVfE2qiXN=h7i1pJ38JJL3J94UgrN_q+ratYTu=nr372w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3260102110810513607=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2732265090
 for <alsa-devel@alsa-project.org>; Tue,  1 Sep 2015 14:14:37 +0200 (CEST)
In-Reply-To: <CAOMFOmVfE2qiXN=h7i1pJ38JJL3J94UgrN_q+ratYTu=nr372w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Ben Zhang <benzh@google.com>, =?utf-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, lengo@google.com, Dylan Reid <dgreid@google.com>
List-Id: alsa-devel@alsa-project.org


--===============3260102110810513607==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rHeCoQbvuHTnkkIZ"
Content-Disposition: inline


--rHeCoQbvuHTnkkIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 31, 2015 at 12:05:51PM -0700, Anatol Pomozov wrote:

> Thus "normal" FSYNC for this driver means that the frame (L channel)
> starts at rising edge of FSYNC (wm8731 datasheet calls it DACLRC).
> "inverted" means frame starts at the falling edge. It differs both
> from TegraX1 and rt5677 above.

> It looks like each driver uses its own definition of FSYNC polarity.
> To avoid compatibility problems between different codecs/socs there
> should be a clean definition of what is FSYNC polarity is. I would
> propose something simple like:
>     ****  "normal" FSYNC means frame starts at rising edge of FSYNC,
> and "inverted" frame starts at falling FSYNC edge ****
> i.e. the same as for 8731.

Right, the Tegra and Realtek drivers are buggy here - the wm8731
definition is the one that essentially everything is using.

--rHeCoQbvuHTnkkIZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5ZalAAoJECTWi3JdVIfQQpkH/2Y8wcB9MEMu+v1Xhb8hhd3T
0jcT8GvZtYedqg/vzQogBJCDsIAPvIHBs8xzPMlpBB3kRqrF4tzuBnxTL6Mn8chC
zB0zyMcVuQ+kKy/oGxpHqcx83OUyUZSfgphvjwsKbzvQv+KTkqGAcN6tqHbEqMtV
Kx8GupXni/+R0R9p486oLX52z1E3wzbssW4I3PNNGXAWV9Wi6pnApwEOHtPmb6Fs
6hf8jX7G2fDO1aNXWSqncSzAEADT11qryVQeo6nC2od8NTCd01f2DsmZ8L7z6NBj
B8BjfENgbaYZ7aA6Jeu3UtaWe+ij/dCwAPF0oHi0DpFzCrKnfkqwV2eTES5FcWQ=
=XdYZ
-----END PGP SIGNATURE-----

--rHeCoQbvuHTnkkIZ--

--===============3260102110810513607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3260102110810513607==--
