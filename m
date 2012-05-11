From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: twl6040: Support for DT
Date: Fri, 11 May 2012 15:05:03 +0100
Message-ID: <20120511140502.GD3960@opensource.wolfsonmicro.com>
References: <20120509133511.GQ3955@opensource.wolfsonmicro.com>
	<4FABBAD9.8080008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7403588685434248282=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B42D24439
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 16:05:04 +0200 (CEST)
In-Reply-To: <4FABBAD9.8080008@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, "Cousson,
	Benoit" <b-cousson@ti.com>, Liam Girdwood <lrg@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7403588685434248282==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d9ADC0YsG2v16Js0"
Content-Disposition: inline


--d9ADC0YsG2v16Js0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 10, 2012 at 03:55:53PM +0300, Peter Ujfalusi wrote:
> On 05/09/2012 04:35 PM, Mark Brown wrote:

> > This really doesn't seem like it should be at all hard to resolve...

> By not using any phandle for the codec in the dts file.

Why even do that?  Just refer to the MFD.  It'd look a lot more
idiomatic.

> Mark: is this what you were suggesting?

Removing the DMIC stuff until we've figured out how we handle DMICs,
AMICs and jacks seems sensible yes - I think what you've got at the
minute is likely to be the way we end up going but it's better to be
sure.

--d9ADC0YsG2v16Js0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPrRyHAAoJEBus8iNuMP3dNK4P/2F+JpO4q9hUkOpRT/zQIfJT
zCcIb9924YTIt8TOilOcnF3Xrr1TpQ2J5bDVoxk+0CKRqToaqhyH3+hNzCIHoxVA
QitILowZoEy5lcyJUP+2AgKPVeM9C0ZRrgcZzq6Aw+b7n6Fvrd4fbizfV+juIAsH
gQWvvUtUJDgvDDLHoVdyNlyKFZmT59PArZgbYk6VCIcz4VCTz5y9i/cAWH2b23Re
KlZbqziz9bKur/ONvYMFOJKGFB/cKJ4kj86/N0EAeLP6lsWsqZdOAOslPOe8anRR
M0KTsfndGc+GDrg1C5CZiNzGpMk3Ivh+jlUYq60Lvnz03+p5KpP+yJI9rmQ4/Q2u
qju6cV1+REaNyxr0JmlVqAehOui7k1NlOQqTVbingVb7OS9N1PLL7FsnZ6a90l/D
ue9eRIFzuDVb8hZu5FAlaBxCD1RHeotgPEpYyVTdnsphTXVG54HFu9uOXLfVSHNE
lvUL2OT0H6/NMc9Q5ZuwVvxnlZNvUJvpD0toDWuIFYQDpxuBa3JLhvh2nIjKebSD
qy/DeCJg1KtjRhFoOY2rzMTEhqZzEhaeYsV2GhF/a/CfPazanhTi57uqGWPjKwZH
Bhd/3yJfOdaKzyFQob9gV0QHUvjmFARYcohDV019QWp7VXAvdbh3bS9N+wB7N3W/
Oi8eHMz1p3Xyth27vIOu
=QkOd
-----END PGP SIGNATURE-----

--d9ADC0YsG2v16Js0--

--===============7403588685434248282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7403588685434248282==--
