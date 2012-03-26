From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question: PCM short and long sync formats
Date: Mon, 26 Mar 2012 11:26:50 +0100
Message-ID: <20120326102650.GC3098@opensource.wolfsonmicro.com>
References: <4F69ABB0.2000706@linux.intel.com>
	<20120321115146.GC3226@opensource.wolfsonmicro.com>
	<4F7031AD.3090202@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4206835774177617744=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 501F0248D4
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 12:25:18 +0200 (CEST)
In-Reply-To: <4F7031AD.3090202@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4206835774177617744==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2012 at 02:36:53PM +0530, Omair Mohammed Abdullah wrote:
> On Wednesday 21 March 2012 05:21 PM, Mark Brown wrote:

> >What do you mean when you say "PCM short frame sync" and "PCM long
> >frame sync"?

> Sorry for the late reply, I was away.

> What I mean by short/long frame sync is: the frame sync lasts for 1
> bit/1 word wide.

> Eg.: For short frame sync, we get a frame sync signal for 1 clock
> before the first bit on the RX/TX.

> It is different from I2S mode where the frame sync is inverted and
> the transition starts 1 clock before the bits and lasts till bit 1.

I'm sorry but I still have no idea what you're talking about.  You've
described PCM mode but not explained what "short frame sync" and "long
frame sync" mode are. =20

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcEMLAAoJEBus8iNuMP3dEfIP/3flf9OIggc2Dv2ghNMW2Cza
FPuExuNAS1lN5AlFVYAS9c7iZaSXfCDhKSWtxL6uyo4Ic41Lsn2Zkzi672yxFwHk
7mk6If6T2bncAazoDSdw+n5g7yh+SMT8+HCdIqrUHz75CV7A7TmOWXBi6XEg94+Z
Jkh41m1H8jAS4M0ev8mfqST4wA0Evf02+uanjmSI9y77UVtM/wQtM0RaYgOr69vu
078IDv/XbYEkvyzusR9jde4GCgC18g4seehCL54crWKPNOOUZXNVTOYr1mKjokM1
fCe4Xrypinnf3hmKVPeHhZ+k/PwN2z9FHGrt1Cg0yapifL4/enFeJASgtZuNuu7R
XKLcVpZ9NvqarngiWEQkf6Fsuz9LiOY5Vru0TE2kAl50d0uZi39sy0oFZfjtdrFN
EwfE1FFkhR+Jhu5yGF5ROxjTWfs4vQgtnjh6hrkK7PN0gG/zN9OTEdbVfqfwW4J0
nBeUI5Am3dOWPY8YZ6Enh03IInUSpo4BswoY4f1ebY6D6tqLuAnrEpz1BIEnoHCq
qVu1XlbZi5AKVnd5GPsOu7w2SEe2yc+vEdIHDBhLLYQDjiKJREe6SxAET7VjB3DM
oI9Z60397EbqxsJSBE0oCOi7qA6f4QjHKAXystr+oc+09ku2QrgB8mre/jWfluLt
1HuhXA8unerppxpk/SEP
=GNqe
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--

--===============4206835774177617744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4206835774177617744==--
