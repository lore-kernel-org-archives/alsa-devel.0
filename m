From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Adding wm8962 support to mx6qsabresd
Date: Wed, 19 Dec 2012 16:42:01 +0000
Message-ID: <20121219164201.GU4985@opensource.wolfsonmicro.com>
References: <CAOMZO5BLH-r77EMduGz7jOQVQcFyvW721UEiHY+sE1d7T4mwVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2546602556644886986=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FC49265049
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2012 17:42:03 +0100 (CET)
In-Reply-To: <CAOMZO5BLH-r77EMduGz7jOQVQcFyvW721UEiHY+sE1d7T4mwVA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============2546602556644886986==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l4+/aJnPlhOv5JVj"
Content-Disposition: inline


--l4+/aJnPlhOv5JVj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 19, 2012 at 02:33:58PM -0200, Fabio Estevam wrote:

> I am working on adding audio support to mx6qsabresd board, which
> contains a wm8962 codec.

Without seeing your code or knowing which kernel version you're running
it's a bit hard to comment...

> wm8962 0-001a: wm8962->lrclk = 44100
> wm8962 0-001a: Selected sysclk ratio 256
> wm8962 0-001a: read 4 => ffffffff
> wm8962 0-001a: Failed to read DSPCLK: -1

This suggests that physical I/O to the device isn't working.  Is it
clocked and powered?

> wm8962 0-001a: read 3 => 100
> wm8962 0-001a: write 3 = 100
> wm8962 0-001a: ASoC: POST_PMU: HPOUTR PGA event failed: -5

You've not enabled any of the debug in the driver...  it might give you
some hints.

--l4+/aJnPlhOv5JVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ0e40AAoJELSic+t+oim9bKoQAJlCcYjmWJ0tySMoKLm6pDMn
fHGgbnACifkPtvANH4lEY3auDzjR9Nx6yVPYtYFKFw3s+MwNaw/0LUmt4H4LZGEu
uAOAgvlOrHvLEZKPiMvKKQo5jLl+XjbwxPn0ykFncdS0690ArcqbuJgwe9dpkFlh
PAC4BwC5NFqF4Lf3M14e8LRJ7eNLm0V6+hW7X23/HMm9ZblcZk+0VMJepapaOHWQ
D5DFvCR+jqUXyGzpoI/RKUeKEAyViUIyycxSahIskGoqmatnz4N759sQefwGxcvV
WcBDrJHYcODBB7vm1mldhGiEIjsVyBSqmGl2LclYgstp6SIwgAqz1e6AUsBzisX5
a12x0EzzqnoSCfBZrMBX6D2gPCPDPSoJ00AchttaOG3SCu3EtjxYnF5mcRhwGTV/
30ZHWEMoRVl4tO8b8zLA0gwAQy4ME7uQgaeqYea17R4s0e4Ce3Zf/6r+Com7rwg1
nBC7vYh7qkwYrtyOql4hFi9HMLmC2Lp5Wlgc+It5YLHN4P7hAY0WZ9B5WVn/kwKY
Du2ecQ/zt2Gi5t/k66p3gmcQVLFrrYlbesmwh8Fja+iqOJFLf4ZsgFrj89ntzCNb
IWQliEosXjGAxUW1TjIUF5wrB9gXl8C7ERfYXkK+sf51gVxlIIxdYEJR8fuTNDAi
Ho0Tglc9oHhdMF1fH4I1
=r7+L
-----END PGP SIGNATURE-----

--l4+/aJnPlhOv5JVj--

--===============2546602556644886986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2546602556644886986==--
