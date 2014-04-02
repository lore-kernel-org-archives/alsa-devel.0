From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Only kmemdup binary control
	buffer if masking
Date: Wed, 2 Apr 2014 15:41:03 +0100
Message-ID: <20140402144103.GF2269@sirena.org.uk>
References: <1396448225-19936-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3945655987555544266=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E636E2654BA
 for <alsa-devel@alsa-project.org>; Wed,  2 Apr 2014 16:41:28 +0200 (CEST)
In-Reply-To: <1396448225-19936-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3945655987555544266==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7PNTktb2klXrVksx"
Content-Disposition: inline


--7PNTktb2klXrVksx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2014 at 03:17:05PM +0100, Charles Keepax wrote:

> When writing a binary control we may apply a mask to the first register,
> as this requires modifying the data the buffer is duplicated, currently
> this is done for all binary control writes. As most binary controls
> don't use the mask facility and thus can freely use the original buffer,
> avoid the kmemdup for these cases.

No, that's not why we're duplicating...

> -	data = kmemdup(ucontrol->value.bytes.data, len, GFP_KERNEL | GFP_DMA);

...note the GFP_DMA there, it's about ensuring that the buffer is
DMAable since the underlying APIs end up wanting that (or will for
larger coefficient blocks anyway).  What would be slightly more
efficient in the success case would be to do a kmalloc() then
copy_from_user() into that block allowing us to bypass the copy.

--7PNTktb2klXrVksx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPCF8AAoJELSic+t+oim9/nYP/1YtFlri0N0pgrBd56btGq3N
hUN96j6GHZad7LOE290P06BapW0Yton9MvHJ70xX8shnFNsW1OS6imlPMdD7rp2Z
o0tRU3edN0uKKWt72OPpSsP4QZZCkinlhqssoqXNhr9IOgaizsosf0CVjOlqANRs
3F99drWYb/w+NMhZjhhxHc/hker2q26GtoKdRDIJmLn3Ax09e6BXRB+nIh1AZeis
8agaJSEAm0PBJv9FO+cihMjSp26caZJHuP27Q+9YeTirfhjTW9yWaSFoayqOSmpt
ISquyrlyiZiYSI9qn8Xus9VMIR4BKFWB24TrIxdvep32fwCOSZE/BwIaVKkaJt5a
dA2mLR2I6Mu9ogFiYE+oaATzvgx/f+qgfOfDTwyccXk4okKR5uA0sH6h7j8dKhKh
2TUTeTSrZMVrGT97Th1gtS8jMR8gAXHdkNhfV96mZMT+rGgdw1MoF3Pn/fvjNLUa
auMc7UKARNbwEiDmDy7whkOgiO0b20fKCOGcjkfsuY8foHginaM2HlDMdFviGdtZ
XJ1/8CpbfJL/LXfiyZjOEpNuO775oOEX6ys2kgEUQilbOAaGVzzxKrKN923FVj0b
7TCJ7w1YI8xbUkEFEcXDVBRRFkViz2C1y6He1W0PI4zgmDbghT7sc/GYuGggZRRP
PFLKdW0GkOVFHz+u/4uW
=A3/4
-----END PGP SIGNATURE-----

--7PNTktb2klXrVksx--

--===============3945655987555544266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3945655987555544266==--
