From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: init delayed_work for
	codec-codec links
Date: Wed, 31 Jul 2013 14:25:22 +0100
Message-ID: <20130731132522.GP9858@sirena.org.uk>
References: <20130731131627.GA32631@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3168852311659972187=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 703CD2615F2
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 15:25:26 +0200 (CEST)
In-Reply-To: <20130731131627.GA32631@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3168852311659972187==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zCmrFqZYZ3TEjivu"
Content-Disposition: inline


--zCmrFqZYZ3TEjivu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 02:16:44PM +0100, Richard Fitzgerald wrote:

> Pointing it to a dummy work callback is cleaner than taking
> special cases in the code to bypass the flush_delayed_work_sync().

Why is this better than pointing at the normal work that you'd expect to
be used there?

--zCmrFqZYZ3TEjivu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+RA/AAoJELSic+t+oim9lwwQAJM7l2LppIEkQiAFMZwzq+Wp
zyKBucwlPeHoJcga6OFWpkctS2dBVtrgU+GTxw2uZp9kAzHJSPgV8YriJP6ckbVh
tAh692dWPZpdTOCHzCS0zjnf6jp/BCw/NKwSH+X/9CzSUqCtMYxkTQFxF2BDpQRT
tDqxeuoujQ48mAT5cJCFgaUb/cP9UIuJ9IYMlUtOpe1VS8ByXb6K0Jo2HODuIirp
KnCxmowH+09BH6K1any/+zoYLAoSHCLWosllO5Jv1UGD2GcOV9EIGGcok64ICklB
wv7Jl+YLJ7iVsJnfCSvvsnA9+hikmhv69zvxTm0CWrhWDQdjbhoDOUEj/AxKMVMq
9WoiiVam+QntiOcXg+M+WvtHxOz9u5RTWm7xUMfHrNYmk+cAdFQZ2mXiZ9iJ71Kr
cCGVwXjGxl4nEI8hTa80kj4ar2Gtz0YCNveBiG4s8hwXE+Sq4KtT+U4yquwSwHNU
0h1w2RP5IxnK108ZBGl42I2JkNV+0mcmRfFoQfSYB+sF+mZ6X03RUQjO0E6j41b7
9Bykx8sdmcpbwFyoHLeJ5liBexvcFmsrhmBFPSRfDeJCIlorWmRDSf45AicZbMRO
OHJrSxZcsEwxjYh9cs4KN4pfZkI06eGFN9/7o/upyYdxiS/G5rgmceeLkjxcbQ3f
gIoXG7261MccVecfTgrs
=CIQD
-----END PGP SIGNATURE-----

--zCmrFqZYZ3TEjivu--

--===============3168852311659972187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3168852311659972187==--
