From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 18/19] ASoC: fsi: fixup fsi_pointer()
	calculation method
Date: Wed, 8 Feb 2012 11:50:24 +0000
Message-ID: <20120208115024.GH3120@opensource.wolfsonmicro.com>
References: <871uqcjo9i.wl%kuninori.morimoto.gx@renesas.com>
	<87bopgi97k.wl%kuninori.morimoto.gx@renesas.com>
	<20120203115522.GG3151@opensource.wolfsonmicro.com>
	<87k440x0ft.wl%kuninori.morimoto.gx@renesas.com>
	<20120206164644.GU3070@opensource.wolfsonmicro.com>
	<87k43zv6uc.wl%kuninori.morimoto.gx@renesas.com>
	<20120207112959.GF3332@opensource.wolfsonmicro.com>
	<87obtayynm.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7210018200914697571=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F0578103DDB
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 12:50:25 +0100 (CET)
In-Reply-To: <87obtayynm.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============7210018200914697571==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N8ia4yKhAKKETby7"
Content-Disposition: inline


--N8ia4yKhAKKETby7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 07, 2012 at 04:08:52PM -0800, Kuninori Morimoto wrote:

> > I suspect it's worth fixing in 3.3 then, there's often issues where
> > userspace applications don't work that don't get reported well or at
> > all, often these are due to issues in the pointer implementations.
> > People end up coming up with configurations that work around them and
> > never think that there might be a driver issue.

> I'm not good at detail of user side applications,
> but aplay was working correctly on old/PIO FSI.
> So, I didn't notice it.

aplay is (un)fortunately pretty forgiving here - PulseAudio is the most
difficult test, though some other applications do run into issues too.
Anyway, can you please generate a version of this for 3.3 (or confirm if
the current patch is OK for there) so we can integrate the change there?

The change itself seems good, it's just that it'd be better done as a
fix.

--N8ia4yKhAKKETby7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMmF0AAoJEBus8iNuMP3d44MP/3LKDNfM+wvt+pqZnywS9ngL
m6LNNOlDuCqR6j2FE5RQ5mjNiq3yfdv4u+I8WQ7XSTFHzN8vrGNVrrW23yiBRqk2
gV3hS3kAQUCQ3K7/2T4MMlhTjyoBTaRDE+U8OklveQW+ovp6dHk/xzW/MJLWJ3m9
nd+KMUTbXa47oJPAEW9tURDKPc3eUaC069jecf03Zdr2B6wc0Jv025drAVaQVAmq
XBDSktC8r1frDkbUcOuv/+0KXX+uYjH/9diZfuSBP1YHemrGpuAdnDhu5LpJTteI
d1rFXFNgAS08nmlXkZ2ZlQs824CbjP0ztc/7oG9829SmD0EZoN11K8S5DvRVUDrH
5VQd1btsUJGhIzSFvo9R8vEXtv9Fz5IwxhoOhTqIs+LBiNksy0SQltF0K3mcyY2V
raJa8cFrcLF8+Q4Lw16h2PDIR4mNvi8fOHSTipmz+PjwMg07nsorMxUzWSn37vms
NW+yI2N5Qyw7xKkoDxpFA9x3ampKoLkSS9+0osI7dMgW3nM0+jaCpQwvIAxQIghO
9M4oTuZfQu/YFSDVQ2EOtlqlfl8nYp93gzNzvIUAZ14baQLoooKT3QLxZy63H4rg
E90j401ODY3g5VdwuRYnpKKyQWDUImwigrAhEFib/jlgcbEEPEwNGKy926tWNYO5
iZnaH5HEWgMkgGz7prru
=IpHi
-----END PGP SIGNATURE-----

--N8ia4yKhAKKETby7--

--===============7210018200914697571==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7210018200914697571==--
