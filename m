From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix the unpaired
	runtime_get/put cases
Date: Thu, 20 Dec 2012 13:51:05 +0000
Message-ID: <20121220135104.GB4985@opensource.wolfsonmicro.com>
References: <1355913397.17896.10.camel@cliu38-desktop-build>
 <20121219091127.GL4985@opensource.wolfsonmicro.com>
 <27240C0AC20F114CBF8149A2696CBE4A1F3CA7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1868978283222825975=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8882C26167D
 for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2012 14:51:06 +0100 (CET)
In-Reply-To: <27240C0AC20F114CBF8149A2696CBE4A1F3CA7@SHSMSX101.ccr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Liu, Chuansheng" <chuansheng.liu@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1868978283222825975==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qesg98+uAFykT7J8"
Content-Disposition: inline


--Qesg98+uAFykT7J8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 20, 2012 at 06:37:26AM +0000, Liu, Chuansheng wrote:

> Meanwhile, is it useful to add one warning there for that case?
> After all, in probing, set the bias to _STANDBY even idle_bias_off == 1, and calling get_runtime_sync(), it
> will let the code more obscure. So giving a warning there to indicate the driver:
> it is not suggested that in probing, set the bias to _STANDBY even idle_bias_off == 1.

Probably, send a patch please.  Like I say it is possible to start off
in _STANDBY providing the driver grabs the runtime PM reference too but
I can't think of any reason for doing that so the warning seems sensible.

--Qesg98+uAFykT7J8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ0xfBAAoJELSic+t+oim9OcwP/2qvlKJiYgOSs0EcPmKGyLxI
nTuHXHDykUuNxmCq7mYNGIlSfkoTtuQGtjxiRaKyY6myXShky1qxka8RZ1o8XsYt
gIC/veb+G9kxSid92v/pxXkLkfU3X0mEdRzYqbTlyLWVBfsIZQjqeVrJsBGDHZkO
1MQmz0YAHvGdhzAO8Iw7627E8xDRAUwlPfNMwnKsUAUF7KOe1p3En4pKJlRqYAfB
ZvFeFpfAUjeOB5nz/cV2zZ2wJby7cqDs8tUoRKupozZR+PpVRTVEOkY0v/9UTnTo
qwp3yE6GOTcQycvG/RChaTM4t5CfXYE9hGTbO8QM/BVaVOGJ3XAfXlt1vD0X+6UU
h/adDNdkcZwtiA77Gv5SD7YPBS2SWOn+c7w/bGgBKybl3f/chFwH7ssMQKj87boN
RGa10rXttvRgn1zdEn97hryrfQOa/ygbPcFjXzDQfeTOV7QEihTgKTQ4X0WBd+/f
0ogHZo/N3k16N2YUbs44GbYr3+HnnqkVOg8WgcZ3XnMNeaQz5tgs2Hh3w+w0h4pS
NQC+1EHpoe4GHR9nGHiu9GMlVWHPQF093b1WJ0/q3R2qhUPJrOi+m0z9++fv6SdJ
RX0M4XUL3ECrYJdVHNX6HAozca4GuSDEgaXYc89Nu3uT93TAsjGoCBi2RLNxt0c+
iU2dxBPMzpopJUUtXy3V
=UZDv
-----END PGP SIGNATURE-----

--Qesg98+uAFykT7J8--

--===============1868978283222825975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1868978283222825975==--
