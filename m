From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 01/10] ASoC: Intel: mfld-pcm: don't call
 trigger ops to DSP for internal streams
Date: Tue, 16 Sep 2014 11:54:03 -0700
Message-ID: <20140916185402.GZ7960@sirena.org.uk>
References: <1410255693-6958-1-git-send-email-subhransu.s.prusty@intel.com>
 <1410255693-6958-2-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4972501950845432060=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 416E6261A7F
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 20:54:06 +0200 (CEST)
In-Reply-To: <1410255693-6958-2-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4972501950845432060==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JkwjF0+O6jX31edR"
Content-Disposition: inline


--JkwjF0+O6jX31edR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 09, 2014 at 03:11:24PM +0530, Subhransu S. Prusty wrote:
> From: Vinod Koul <vinod.koul@intel.com>
>=20
> For internal stream i.e. BE we have don't need trigger ops as that
> would be handled by DAPM for us in subsequent patches

Applied, thanks.

--JkwjF0+O6jX31edR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGIdKAAoJECTWi3JdVIfQLk8H/3f2ioKAzc65FaUYih/MjS3+
QEX9TLKX9M4xMzs301vr87nq0XxDNLBVsIM0ulT/f3XECi8AZ9XFOHJ1+IbThvYe
KrOFEJIx5Qof/3pfn11+bC+/ydSLWtwwLlGmCtMm2TJdaUZ/jh8GA6grRkBLYxFf
Ddz7pH6EjHfWG9JVbHYDcwfoEZS7YhgDvGaxeevMVGGW4H0B4wuGW7E5cTEV7cx0
w5bH8/8mgjQI6fE92ieQ+M9ymU+KkRZ67DvRVBKM+grg5+wJ6ueAl3g6bUbVhpuV
bV3g1PMEzezNiq/1/MGKUrJPS3zLdq1R1NTii9knK23KuQ2Sb1kHWemmOp05UvI=
=zOuC
-----END PGP SIGNATURE-----

--JkwjF0+O6jX31edR--

--===============4972501950845432060==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4972501950845432060==--
