From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] ASoC: dapm: using freed pointer in
 dapm_kcontrol_add_widget()
Date: Wed, 31 Jul 2013 21:05:26 +0100
Message-ID: <20130731200526.GD9858@sirena.org.uk>
References: <20130731085244.GB8210@elgon.mountain>
 <51F8D2B5.7060504@metafoo.de>
 <CAOesGMgrztKFbLM4m3sr1cH=Od6FVy8p2BbEi_X=J_jDhyHBKw@mail.gmail.com>
 <51F9585F.8060505@metafoo.de> <51F95B01.7040002@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5403472366372716060=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 37891261640
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 22:05:36 +0200 (CEST)
In-Reply-To: <51F95B01.7040002@metafoo.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Olof Johansson <olof@lixom.net>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org


--===============5403472366372716060==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pFZPy2DnCTuiDxp6"
Content-Disposition: inline


--pFZPy2DnCTuiDxp6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 08:44:17PM +0200, Lars-Peter Clausen wrote:

> Something along the lines of this:

This seems to fix it for me, can you submit properly please?

--pFZPy2DnCTuiDxp6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+W4DAAoJELSic+t+oim9qIUP/0F2BjiRJhxb2wcY8nWqyLxO
t+cJFSdTts5duxfQxoizhn+hlY2MN7B6YLcskqrqewasZyRDQeeDDwam7/yhzOBF
SYsVot+kUVVYd2Gz1/bTlLrMEYTkiZWfJDqr/sM6NFVWarnxOjYAhAIWHT6BLMSZ
0a4Re6o0XplbswoOnCs6bAmpDZfxU5GMBg3BxAkTVbRY5+NMVrewAZBWUEoTMVER
eHZv7DRaln48RIN8yrTsrtJ7nXA2mcXv3vK7Pwr+M1MDZTBBH49iMUPyg9aVK7Wn
kOnyYvvEpy5OTQTLTOumWbMhOKhWaPYFadKSqKv0F/QIlpjWvGYbMBTDy2dBW+EA
q+ciJoJbrhijYmYK/TX95Netsq5NP8+56HZGx1BmidYWZByAG9tmTGQGzjtgZ7jY
53m20AdXGjW1Q8Qhqp9jegZkIMnIFnZY8B8tGHVdPd9qz17MT797FLQpY22bqCfC
yPsgN1JcicvwM9U9FvMbXDF0H3yuLaWjAHlPbfJn82Zzm8o72yM6Bs8Zpdol7kOJ
FgXfeiRSAikrIdJj2tk6/brSERSZnWy1jIrd9WK+zGD00T04jSLV1An8WY5YXxTV
aNpHHSFI9uB11CVe9p6LPN59A7u3hKnkangrwgSkLZfAwsnDpUgtje6Pl0UmVNgG
QBS6fOP8wyQ35PS8hyfp
=MpJf
-----END PGP SIGNATURE-----

--pFZPy2DnCTuiDxp6--

--===============5403472366372716060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5403472366372716060==--
