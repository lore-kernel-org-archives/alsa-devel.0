From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Using sync dapm_sync in stream_event call back
Date: Wed, 7 Nov 2012 15:47:30 +0100
Message-ID: <20121107144728.GH20844@opensource.wolfsonmicro.com>
References: <32F4D3A311A1404B92CF923AFF38C3C529E715@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6988426192706992204=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E35B2265079
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 15:47:33 +0100 (CET)
In-Reply-To: <32F4D3A311A1404B92CF923AFF38C3C529E715@BGSMSX101.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Babu, Ramesh" <ramesh.babu@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6988426192706992204==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Content-Disposition: inline


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 07, 2012 at 09:53:14AM +0000, Babu, Ramesh wrote:

> In my machine driver, I need to disable a widget in stream_event call back.
> I realized that I cannot invoke dapm_sync() inside the stream_event, because it causes recursive lock.

> How can I disable a pin (widget) inside stream_event call back?

This doesn't sound like something that really makes sense within the
model DAPM has.  What are you actually trying to accomplish?

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmnR4AAoJELSic+t+oim9iDkP/jYtpLIOdtKv90aeHCF+ztbN
UCGFh3HOJs159BbCFQATBbVjnaO2R820QtH6ieiwfryBCHei+tyBAy3i9KSlAZbD
hEHwS9fk3+bkTvpwUe0ILt11vB/qOrtk64kSPFeFT3uJ1gpmFAcSKH9kRLQv+85U
XieItEkq3jOp08/6eo2gbfMvbsPGvdBV075J5p73thIE84D5HHribm3NPz8X6zFu
JKFkWJfXVlxjtBAf8aIWCq1piYloLLw2/wUM5RVosDLfaVNBWbsWvbLU6pmFaDjk
DgwgB+8MJqu2A14Im4mItDEH9sv6VJlYV1VGk3B01TT+LQkN+ANcVghWbUujRJmC
b2JAxmpnB/p6L0YMzWH/z0+u0lTSE4vWwR5jdB5F/Q8lSe6ONULVg5izcmLoDGNP
iEwQ3lJzaRsWEeUVbbMPFKjCXQnwZpBMV3MoKquUsZt3OAlA69+cgRAJ1sQEBcHi
uFYN3vylmFHsZiW7w05O9RPD4zONdWjJuPSKpps2ug9fAvbxRl9KjRJyVpdJcX2s
EYaozewjK8KVhlmbEb1mPK4Px+tr3wj2E+oaaZQ/rv+o3FLrQYfRsC0rWiJE9LbS
l/os/5pLMRMLqV+FwxmM2TFoRjyBpnb1uzl5AuDl02crpR25m/WaLrbTJkharGCa
7V5RuY/7yT84p/r7IyCb
=urqQ
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--

--===============6988426192706992204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6988426192706992204==--
