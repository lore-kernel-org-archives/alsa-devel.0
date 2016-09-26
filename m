From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tpa6130a2: unmerge power enable error path from
 power disable path
Date: Mon, 26 Sep 2016 09:08:31 -0700
Message-ID: <20160926160831.e5gd4t4fqhkxgzii@sirena.org.uk>
References: <20160924183110.s4lxuigycpxegamq@sirena.org.uk>
 <1474886150-16207-1-git-send-email-nikita.yoush@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rpv3qvk5vjbklofs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1474886150-16207-1-git-send-email-nikita.yoush@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Helen Koike <helen.koike@collabora.co.uk>, Lars-Peter Clausen <lars@metafoo.de>, Sebastian Reichel <sre@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
List-Id: alsa-devel@alsa-project.org


--rpv3qvk5vjbklofs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 26, 2016 at 01:35:50PM +0300, Nikita Yushchenko wrote:

> I doubt that copying 7 lines into error path is better than having a tiny
> logic with return values, but still here it is.

Consider what happens if someone wants to change the code...=20

--rpv3qvk5vjbklofs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX6Uf+AAoJECTWi3JdVIfQx9wH/jl9XJm7PegFAsSqnMmmB8tk
gWdAGF+59A85eI3n/SXmThAGGK9V2XXeAwPnm1gIuK4JB6wbVz6S1e/XqYvmk60p
+nTAU77zxyvZQjdL2DdT4essBu4SifpwobU2YvTD4wLTgiKwN4u13RV4k10AsAmj
lpj1POWyWWpYEOF/WxLa7VpjfG7r8FMrm7gHpm2YlJkt6uACHJhafFbhUy9B5TJH
pcRu6ErPv12ry8bK0uwsk3v8Nc8v4GESv39ujA/BGb2J01oY0ALPwJbNV3R1zXtM
giCPkq29vJg/9n/bOplyzgMaKPyDm33JbjH6lBp0cbNAOLRZSkEJONbXrFQRCSg=
=zwMh
-----END PGP SIGNATURE-----

--rpv3qvk5vjbklofs--
