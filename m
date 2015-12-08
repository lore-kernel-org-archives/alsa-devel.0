From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: The soc card can have auxiliary
	components
Date: Tue, 8 Dec 2015 18:58:17 +0000
Message-ID: <20151208185817.GX5727@sirena.org.uk>
References: <cover.1449036307.git.mengdong.lin@linux.intel.com>
 <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1941733778789951879=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EEA62604A9
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 19:58:25 +0100 (CET)
In-Reply-To: <bb343fe20b14af90f695939d8faae50fae1ba97a.1449036307.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1941733778789951879==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xUyMHIOv46mebLva"
Content-Disposition: inline


--xUyMHIOv46mebLva
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 02, 2015 at 02:11:56PM +0800, mengdong.lin@linux.intel.com wrot=
e:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
>=20
> Machine drivers can set the name of one or more auxiliary components.
> And the ASoC core will find and probe the auxiliary components.
>=20
> Machine drivers can use this to specify the components with topology.
> Then when the components are probed, topology info will be loaded to
> the core.

This makes sense as a replacement for the existing aux_devs but this
doesn't feel terribly strongly related to the rest of the series and
we're not actually doing the transition yet.  What's the relationship
with dynamic links and what's the plan for transition?  There's CODECs
that could be transitioned relatively straightforwardly since they have
no DAIs and can only be used as aux_devs, it's them I'm mainly thinking
of here - the rest will need to wait I fear.

--xUyMHIOv46mebLva
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWZyhIAAoJECTWi3JdVIfQQngH/1GwOsGqHLeSBdMEpq+SHGZk
GNotTqiwfXk4ltw6uaDkDZmcdE2YgcvDkLvIy7ZiDdEH9m3fKGcqawUGIjiQTDcC
il9X/TYV7BFjONX5Gu/8uv8u7kxS0FmjW2eNEYKDOdBoj5W8GtnrzzIraP9WMCUl
WYxK2Vwm0e62DfKQtmLYKHfLZttOG9fFlRZyYCE6XTDTr/suuXP/lFLlN9H0HxhB
nQXfL446IMoYVPLOlh5KAmgd5ttDwcrUdBB5EE2aL/mtz0CQNae+WbX90u0LjR6V
BR++0nMcRUKMWtmeOPwK39KdcxH8osxWi7cAxLPsiPKtv4v/FSxn9apUhjEI+20=
=Iz8H
-----END PGP SIGNATURE-----

--xUyMHIOv46mebLva--

--===============1941733778789951879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1941733778789951879==--
