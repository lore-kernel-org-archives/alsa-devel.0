From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 01/11] ASoC: Move name_prefix from CODEC
	to component
Date: Sat, 21 Jun 2014 21:03:34 +0100
Message-ID: <20140621200334.GO5099@sirena.org.uk>
References: <1402935191-18398-1-git-send-email-lars@metafoo.de>
 <1402935191-18398-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2469082438089762127=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4614E261A7F
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 22:03:44 +0200 (CEST)
In-Reply-To: <1402935191-18398-2-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2469082438089762127==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="o/s5EVDMealX6CVa"
Content-Disposition: inline


--o/s5EVDMealX6CVa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 06:13:01PM +0200, Lars-Peter Clausen wrote:
> Move the name_prefix from the CODEC struct to the component struct. This will
> eventually allow to specify prefixes for all types of components. It is also
> necessary to make the DAPM code component type independent (i.e. a DAPM context
> does not need to know whether it belongs to a CODEC or a platform or something
> else).

Applied, thanks.

--o/s5EVDMealX6CVa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpeUTAAoJELSic+t+oim94zcP/RaA7u5DnrpPD0v1P8v2fT7v
UfapyQ7htXoViwpJ2aglMHZas2S+4BgtG4bE7IxR0eYkpKk9ZbptHJFPez2EcHTK
MvCdyNuHxuQAMLJOFbnCfSJcHaRtdL980hrj2ljfpnBgw8ZZA08Pw/WVU2+YlKZd
VIaPWLWA3RZ0+HhONP58TIBMkrKgZ5SNzPXdN/5l/8uqUuUjQxA60ZXA4hsw6JLt
lBkgm0Xnf/lhXkEzGYZr69bGXtXCL2wt+gPlDcl8q+O6zIF+e4zoJsLXsAyJ/IOW
MIkrjEQC+2y2OvPXmKsix7ioDvX5gr1z53FIRygWqF46Gmr8iSuNLeoF9VbYgEFY
R/vw74PNty7qY/k5ggwU5DOc6OubtlQZ92pD4eg8JSdzyOk1oHmKNntqO0/VDhIF
b1OZo/JtFMBb5FCDdbEV/uIbd5ASsz+CIj9T4vES2Hi41On6MPhWCVRkFj1n/enl
jP5rdNflhBJCRSIGVeXzj3NxQ2SiKinw1qZcxPX/s+i7LD9Ono7lWy8u5qLhrE9u
Wp9fPN2pwOYr+Msh3Y/UOQotY8i6MdSnO6Ip8BEdjJsrhxdfmJpgnzu5ikDqNMWc
tfn+jl2dvN0RTABsKhCdf5kRefWdWZ7G5qhvDhAaa6YH0Ax++O21Oz197UOzRAXU
5ywIvAiwQCg7BmCE83xY
=2yGb
-----END PGP SIGNATURE-----

--o/s5EVDMealX6CVa--

--===============2469082438089762127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2469082438089762127==--
