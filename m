From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 8/9] ASoC: Intel: Skylake: Initialize
	NHLT table
Date: Mon, 21 Sep 2015 09:08:57 +0530
Message-ID: <20150921033857.GG2381@localhost>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-9-git-send-email-vinod.koul@intel.com>
 <20150919162720.GG30445@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7890828809762587549=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 55BFA260537
 for <alsa-devel@alsa-project.org>; Mon, 21 Sep 2015 05:36:16 +0200 (CEST)
In-Reply-To: <20150919162720.GG30445@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7890828809762587549==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2015 at 09:27:20AM -0700, Mark Brown wrote:
> On Mon, Aug 17, 2015 at 10:56:43PM +0530, Vinod Koul wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> >=20
> > Load and Initialize Non HDA Link Table in Skylake driver
> > to get platform configuration.
>=20
> Didn't we need this before we started trying to use the NHLT?

We have only added NHLT code, not calls to it. Since the whole driver
series is not merged we thought best to add enabling bits in later patches,
so added here at last.

Thanks
--=20
~Vinod

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV/3vRAAoJEHwUBw8lI4NHRWgP/iVh2fZxcfD2MQPrfpH6RSiL
t+pjp0iYG/mwLDDg274Su5NhVYhxFFSh13edCaTdh7UYljBXBUVVKe3+xDHrZ8b0
d8pvjrl3svRiaGmBW8bf0TZeo5hbTylYYOdkBdqI5L+dIAxOECmSxpuhL7qicVlt
FXbRPi2+K812T7Ke80jLNuX6SyBiIy0qP6TzlWgzgsM/HCsGG5UexHarT4GiU7qu
ZltEpHGftjcKjmW1Sv0NcYS5Wst+/9fbJrrlxNIjZpNV5DXOuX+Km4r3+HfwjNk7
thHQmiOldtoQ8WIVneSKCVhum/XGYhF8EMsGitdyfYZMnuq8uzkDDuFJ6T4e38Ii
lep+YmzOa63PGgEpuKJ01mLBVHRYGDiqBulpr4xQa+Ag7naAAS3Sk82ANepo4KmX
zaB7McDOTfQADWJwLalee6zf8n63QYLKGS1Ksbs041ScDwLmy7Rg4CTEoiTHKjFi
WfWNiwc77FfrhGzqaypZv+0V18W/5vB5gB7XOO+LUla+lNYmcfXySgLYG2JQhAAv
xO1iLMbbAIhj9rLdKtDkpKwF/GdAKsPSheKpV/5URCvRlW6Jc++iKDttKAklLu1L
DP3rztx42QQ2n++7Fu5OTUSzWo17MAJz98ujV6+IdQaJ3ANHqZ2FdNtdHBDJf7Yc
rSNjbrFQjQln1HsxKdU6
=0sAd
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--

--===============7890828809762587549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7890828809762587549==--
