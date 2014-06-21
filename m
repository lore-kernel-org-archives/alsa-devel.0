From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 01/19] ASoC: Intel: add COMPILE_TEST to
	mfld machine
Date: Sat, 21 Jun 2014 21:38:11 +0530
Message-ID: <20140621160811.GL22053@intel.com>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-2-git-send-email-vinod.koul@intel.com>
 <20140621104241.GB5099@sirena.org.uk>
 <20140621153453.GI5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6022414059665206227=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E53826546B
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 18:08:22 +0200 (CEST)
In-Reply-To: <20140621153453.GI5099@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6022414059665206227==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2014 at 04:34:53PM +0100, Mark Brown wrote:
> On Sat, Jun 21, 2014 at 11:42:41AM +0100, Mark Brown wrote:
> > On Fri, Jun 13, 2014 at 06:03:50PM +0530, Vinod Koul wrote:
> > > Allows driver to be built on wider configs
> >=20
> > Applied, thanks.
>=20
> ...and dropped since it causes build failures all over the place
> especially around the SCU.  I'd guess you need a dependency on at least
> the SCU as well as COMPILE_TEST.

Sure makes sense, I will fix the SCU bits and resend this patch

Btw, there are few patches in the series which can go thru like:
 - path 5, its IPC defines for DSP
 - patch 6, stream modularization
 - patch 8, common stream for pc/compress
 - path 9, FE, BE ops
 - patch 11, fix trigger for BE
 - patch 12, generic DSP set params
 - patch 15, power control for DSP
If there are no comments on these. Since the kcontrol patches are in seprate
patches, I think they should apply, otherwise I cna split up in next set

Thanks
--=20
~Vinod

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJTpa3rAAoJEHwUBw8lI4NHAAsP/jOFtXio32PkbKCq9vcochum
zNsvc9NcD3Sud1JKe7bsEh756vchLcyqwHwIFiRrbE0F0L4vivCKw2yWcESb0Gkp
fp0r4IezyQxdhfWCONA2KR3GPsD53TOHlS9q8RtYaQTPeOXQqURZBpbKau5L0el6
WPKWlFhIoOZBRBOVq+Ffvv89Y+1by/55DUA2au3g+Amv+8PwvRhwpkZh9G1qgexH
sGrx1+3L1IFNjB8UnYh6IDA47SnnKpg/nTcnCqv/eAy+YHQOf4So0wSHzFrdXcRw
L+4jBSkIcOU+t4irp/4TCJ1xmebhRHDPVdpp+4bGZed55gLCpVDu+Gk2FjSjMmjV
N1HoatMKag5SMNuOWXq8eHltOL7N7oGhVq7jD9G/3GtKuPS/d9/sgq+rQ2L/wFFU
XMgTcaJqySVIsTE7K2o0PpcTdGru7CxeqETLujZ+n8vQmAqjMi721HTGhDblavAe
5o/3h8XcIeIl7S/3uBQq88+1CyCcp/5YuUO+O3sD9NmGaDFr1gKNKaa2gyZrayxI
EBIzShHKyZtZpzWMeYzJTXh9C0mUGr2GUfF+a3DYLXDUcgfRF3JMopIs+sxhJRvp
UzbgkJD9JcXnSkFrVRo8Jq83O2ePOyXNfzFLBi4NatUro9+tdxeCVW4HYiR2O0VE
u2+qhYD/8ZqScFgLs0+s
=ghYR
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--

--===============6022414059665206227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6022414059665206227==--
