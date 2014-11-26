From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: bt-sco: support wide band speech
Date: Wed, 26 Nov 2014 16:38:05 +0000
Message-ID: <20141126163805.GJ7712@sirena.org.uk>
References: <1416978538-3318-1-git-send-email-21cnbao@gmail.com>
 <5475B9E5.7040705@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3768621386844750915=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 924062606B2
 for <alsa-devel@alsa-project.org>; Wed, 26 Nov 2014 17:40:10 +0100 (CET)
In-Reply-To: <5475B9E5.7040705@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Yibo Cai <Yibo.Cai@csr.com>, Barry Song <21cnbao@gmail.com>, lgirdwood@gmail.com, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>
List-Id: alsa-devel@alsa-project.org


--===============3768621386844750915==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zFWgeV7OZ5i9hETr"
Content-Disposition: inline


--zFWgeV7OZ5i9hETr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2014 at 12:30:45PM +0100, Lars-Peter Clausen wrote:

> This is modifying a driver global struct with device local data. This is a
> no-go. Either add second snd_soc_dai_driver with the new rates or add a
> startup callback and add the constraints using snd_pcm_hw_constraint_list().

Or copy into per-device data before modifying and registering.  Probably
the second snd_soc_dai_driver is the best option though.

--zFWgeV7OZ5i9hETr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdgHtAAoJECTWi3JdVIfQUacH/0iJbu3tZARMjddPsTYMCReB
X/s1JKpMuhsbUvONTyTWRJs90MorX6GhNXGmw0vqOZqIpV9ysI3Oqv0YnfRAjjrY
0JxpNnwhsZ65k4LoTeky2zLoSlM/2MChTWO4ehjSjPAtJ59Igjua/XRBN2VaRBmJ
q4xDDExW/Qrbxol0gCLDleYtVdyNX+bvCg4mhyNGOnBD7UNKmJEzQMn76ErLrdOm
mLIexsoTeMZ26X/+V9fNSI/RLa/9NuQCaTTz/Ls+gTDwfisP15xevZefXx52F/PB
awH1zNK55YKm+VCPMh5q9Yd0yrU2HKVfI2HYcrBjLIwzD/vbEvRullMcYHnGLNg=
=fPPN
-----END PGP SIGNATURE-----

--zFWgeV7OZ5i9hETr--

--===============3768621386844750915==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3768621386844750915==--
