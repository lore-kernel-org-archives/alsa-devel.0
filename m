From: Mark Brown <broonie@kernel.org>
Subject: Re: Separate input and output jacks for one UCM device?
Date: Thu, 19 Mar 2015 14:42:40 +0000
Message-ID: <20150319144240.GV2869@sirena.org.uk>
References: <5509D4D4.6030000@linux.intel.com> <1426756559.7258.22.camel@loki>
 <s5h3851t6xx.wl-tiwai@suse.de>
 <E7B1D079BA13FB44A978CC8F69C7D6A901BDA3F0@SHSMSX101.ccr.corp.intel.com>
 <s5hd2455a07.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5537234250380022515=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8466B260588
 for <alsa-devel@alsa-project.org>; Thu, 19 Mar 2015 15:42:48 +0100 (CET)
In-Reply-To: <s5hd2455a07.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Arun Raghavan <arun@accosted.net>, "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5537234250380022515==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZUxj+kVYsk1YKJSS"
Content-Disposition: inline


--ZUxj+kVYsk1YKJSS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2015 at 03:37:12PM +0100, Takashi Iwai wrote:

> The uniqueness of item name is also needed for input jack.  There is
> no check as of now, and input drivers allow multiple items with the
> very same name string, but user-space can't distinguish them.

The theory is that this is handled by the fact that the userspace ABI
includes a reference to the struct device and therefore a chain showing
where the thing is attached; anything registering two different jacks
with the same name attached to the same device probably qualifies as
broken.

--ZUxj+kVYsk1YKJSS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCuBfAAoJECTWi3JdVIfQnF4H/0cm/Jrux7KCthAczi0GMY3b
S/W3vN3YjST0PkJ9UvdsVia5Y+LISnSZyq5hcRaWUbAELTw09rm4otYOQFbGZYdG
4fuDipMxs2aqzftreU1uKq7cNxlXDGI7bmNDvPRZLot7GnIgSmEJZf2oWu3evYtI
krcaGpxeO/LE2RMgj2EiOJcME4X3rJfgO42+T45aAY++l6tewlE5Pft2YFhRsgR3
Hv0FSrN2YHUjq74K5qPq9RuvGuHqvryl9vM+sapCjUWoqwAb/UPXVfkCaYrQD64j
yJktT42dG/Vr6ZikHFpDWjP1N93tBLa/CQkgdEN8V1+wBNtBPsk1ccXFSCFj1aQ=
=ySm8
-----END PGP SIGNATURE-----

--ZUxj+kVYsk1YKJSS--

--===============5537234250380022515==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5537234250380022515==--
