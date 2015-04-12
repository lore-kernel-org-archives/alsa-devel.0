From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: fix array_size.cocci warnings
Date: Sun, 12 Apr 2015 19:47:29 +0100
Message-ID: <20150412184729.GD6023@sirena.org.uk>
References: <201504130212.486RaUV1%fengguang.wu@intel.com>
 <20150412181621.GA106685@athens.lkp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2612870571021295393=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C2FC926060F
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 20:47:46 +0200 (CEST)
In-Reply-To: <20150412181621.GA106685@athens.lkp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: alsa-devel@alsa-project.org, Christian Engelmayer <cengelma@gmx.at>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, kbuild-all@01.org, =?utf-8?B?UGF3ZcWC?= Piskorski <pawel.piskorski@intel.com>, "Lu,
 Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2612870571021295393==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zws7dh+9FI8drUAC"
Content-Disposition: inline


--zws7dh+9FI8drUAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2015 at 02:16:21AM +0800, kbuild test robot wrote:
> sound/soc/intel/haswell/sst-haswell-ipc.c:646:28-29: WARNING: Use ARRAY_S=
IZE
>=20
>  Use ARRAY_SIZE instead of dividing sizeof array with sizeof an element

Applied, thanks.

--zws7dh+9FI8drUAC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKr3AAAoJECTWi3JdVIfQc3oH/izdm1fw17etTwmbbWtC8lJy
w/tnY/5/PDURM81luD9LIaBx3sek7C1GH/+lQlQTOpARiomuDS4HJhIuQTByIMaP
ce6q89U5MANIPlanyA4k0ptY0+IUViEwYvbl/6PES8aTeI6whFQ7VaBFdoTyQAA6
o2SftDU2dk6hlxEwRmSTZjDwiwA2xbldzynbh4+/6nXY15yLXqh6P/0pDWMMvrYD
Oiy7vKjxx+LfC5WcahTmHOUFi4WgAer84oz1hCkfjjjqufDpzOEGG4dOv3MsJBHX
9cgw80wN7d86oB2TLgJwxtG15Eiq+R/gGatGcZGr4UrVZNTnDGdmBYNW3jo1dgM=
=US6c
-----END PGP SIGNATURE-----

--zws7dh+9FI8drUAC--

--===============2612870571021295393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2612870571021295393==--
