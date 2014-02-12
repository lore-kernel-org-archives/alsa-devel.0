From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rsnd: tidyup original
	for_each_rsnd_xxx macro
Date: Wed, 12 Feb 2014 11:59:57 +0000
Message-ID: <20140212115957.GG28112@sirena.org.uk>
References: <52f54917.qk3y9f+gv07U3vXN%fengguang.wu@intel.com>
 <87k3d19lmi.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7995196764810848477=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 289F3261B1E
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 13:20:53 +0100 (CET)
In-Reply-To: <87k3d19lmi.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org


--===============7995196764810848477==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2014 at 05:15:51PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> Current for_each_rsnd_xxx macro will read out-of-array's
> memory after last loop operation.

Applied, thanks.

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+2I6AAoJELSic+t+oim9VbwP/3MhetpOOilvcHs2lbYTbjxJ
pUW8Q8nS0Lgaj9KBm+4T59h/8TsRkTUtjiPttrgStuXL2VMKBNnb8aK+W9X39UW9
xbgcIi2q8rle31FTWofdFytBRca6SUSE2iCnhvOu2qq+ZXfjjqAb8jc1EARqEG78
GiRnIps5sXHcqy34rm9Ak/uy+NYhaLEz4eIs2PBHPRoDwvX+XlKyTSnLfDJPAvQg
61hHd9zB3qCeGb8k3EcUQZRf9i9vz0X0U3ekI/fXR5sHlSipMHbbdGuEJBPlAF7e
wMNnndW4+06KaPQ/Ax+Adc4INsujB53yqcKzOwI2WP5p6EbTNIayFKVHAUm/ZgR4
jtW4heOllcAWweTqX/Eyio6v8/yJMHa5fIG9KY/+SgAprXnCzRBPBwvK/eQPS7TX
7XPB+wMgQcxMDLMyeiUFLu12T2686mh6kmoWNFMKzYshVfPw54Pdtycf9JgNWjam
kym1uBXfPsOTAIxdS5z9vP1ybpJ6ABZsA6MccH2SyzX5D2zRddhfWDoYXjBsxMMc
hOY7Gnm9McFCM9Thp5cRU0FsNxbwKldXH/pqniBooClOZVHZtG6r8QYHiLOkAgld
N1n9KHBLLWk0arnind+JhlcZzgDKR4KOhrofRyzNhRVDkhGWJZpYz5OzTW3Jmhwz
DX3iRq3XUSIPKrTSNJFo
=hGCK
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--

--===============7995196764810848477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7995196764810848477==--
