From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 8/9] ASoC: Intel: Skylake: Initialize
	NHLT table
Date: Sat, 19 Sep 2015 09:27:20 -0700
Message-ID: <20150919162720.GG30445@sirena.org.uk>
References: <1439832404-12424-1-git-send-email-vinod.koul@intel.com>
 <1439832404-12424-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2100116755779175334=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E02D1260672
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:33:00 +0200 (CEST)
In-Reply-To: <1439832404-12424-9-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2100116755779175334==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Content-Disposition: inline


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 10:56:43PM +0530, Vinod Koul wrote:
> From: Jeeja KP <jeeja.kp@intel.com>
>=20
> Load and Initialize Non HDA Link Table in Skylake driver
> to get platform configuration.

Didn't we need this before we started trying to use the NHLT?

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV/YznAAoJECTWi3JdVIfQb24H/ir+FK5O5IO/f0W/TJyr/p83
CIlCj/td0CyXBup6+8liiVMGT/qTpg8QAxRYX1pChQzC0NO5SvPWHGWDT7C4TAJZ
0OnqUW/L/5noA5K+1kUQQ9PzZR0ZEzezplHdqIy8osPxXdOsiW/sQpYIhhni9V6F
3Jha5wVr6MJ+6bF3GfSEOMRJGdVj5PuBniR5fuT+5z8xsbcjtX5anTZcYPYYmEa4
Nx3tSnrJdkHfYeuzc7TLhmk+lQcV2dVTojAfCc303HJtioEnJvIk+D8jCwQdmXeA
HbxCzpbRbUDeiiDaBbaJ7+FK8HKxZWOFAAqjFAYiWB3PQSdwRoHijVFwAdQ6g1o=
=wsni
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--

--===============2100116755779175334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2100116755779175334==--
