From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: si476x: Fix IO setup
Date: Mon, 10 Mar 2014 11:26:16 +0000
Message-ID: <20140310112616.GB28112@sirena.org.uk>
References: <1393922513-31824-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3508478544910593408=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 151E126507F
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 12:26:35 +0100 (CET)
In-Reply-To: <1393922513-31824-1-git-send-email-lars@metafoo.de>
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
Cc: Andrey Smirnov <andrey.smirnov@convergeddevices.net>, alsa-devel@alsa-project.org, Xiubo Li <Li.Xiubo@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3508478544910593408==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LxaJkMtlT1pByyLD"
Content-Disposition: inline


--LxaJkMtlT1pByyLD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 04, 2014 at 09:41:53AM +0100, Lars-Peter Clausen wrote:
> The si476x is a MFD device and the CODEC driver is using the regmap struct of
> the parent device, hence automatic IO setup will not work and we need to
> manually call snd_soc_codec_set_cache_io(). The issue was introduced commit
> d6173df35f ("ASoC: si476x: Remove custom register I/O implementation")

Applied, thanks.  Please if you're listing which commit is being fixed
do it using a Fixes tag - it makes it easier to apply.

--LxaJkMtlT1pByyLD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHaFVAAoJELSic+t+oim91PkP/A56bbj6X2W5o7zqs4y4dvuu
0Sb4hwQ8kCquXizuA5SY45N4ZCLGeCl0zDJYMySbJE4Zx2tO28YJuGM2py83Bix8
oq4V13JrfURcZJ0hEcMZt3AztlzLNdc62wTT4b3mVvi1znigl2r4vS8d9FPQu4m7
89Ez8TYfQQxGXp/MibazYkA2GkLz+TlFdlH46DvIh9TOemvkOm3Fgrp9EPeGYaGf
nj6Dpx0bbEDf2TvKb1EQUdvtHZVkrC9LHjKQxZ+M700MUgV4gRJNSKY0J6gKDtyj
sfTWXOH1rFNZFvdWY65aJ7Ty1tjAJJLoLaUrY7ELZLbNPzlvBlwQfa5eSH9Pd2jO
oV1TXSXVz0J5H8S1+hW06WQvwbmmfmtcIw0Wm6uycnhIXlzQkeJAS5CulTGMLkv9
pl+I3F3ahXZd6ZmPh7hSwBTzLLNKozKlslWZWnAunW0Oth0ROKZDnNsyLvsR0DR5
5HEmWQ+3LAsP82xB8OOdmauUH+y0hVbghsfjp4bjFklB2K+k7/OXHT1MKQF76XKO
DeRoCUhBnsKnU4Ky9KQ+fuCE0ao4KP1mBbnpINUflGn3PR/vj44or+w4EoGcupSY
HGQF/x4E5HapFSEdMVQ5Al9vLxdK/FCPIufxO0Dn2X7cHBK1QE/kD5geZdYYT4uY
XFf7w7ElMlBPQY+HAaXI
=HeRH
-----END PGP SIGNATURE-----

--LxaJkMtlT1pByyLD--

--===============3508478544910593408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3508478544910593408==--
