From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: Intel: modularize driver probe
	and remove
Date: Fri, 31 Oct 2014 16:46:25 +0000
Message-ID: <20141031164625.GD18557@sirena.org.uk>
References: <1414666312-4657-1-git-send-email-vinod.koul@intel.com>
 <1414666312-4657-6-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5359340259577660128=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B8782606DA
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 17:46:54 +0100 (CET)
In-Reply-To: <1414666312-4657-6-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5359340259577660128==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jgcrNRut14sNbEwy"
Content-Disposition: inline


--jgcrNRut14sNbEwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2014 at 04:21:48PM +0530, Vinod Koul wrote:
> From: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>=20
> The driver probe which initializes driver and remove which cleans up can =
be
> shared with APCI as well, so move them to common init_context and

APCI? :P  (same typo in all these)

--jgcrNRut14sNbEwy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU7zgAAoJECTWi3JdVIfQwU0H/jKgFnbAw8THhEimkVdAOpvk
RLA5hZwE93SKEI2n2CCUvoumn9YvslaFQnCpAw+SBBpt/Yxm1El3QhlNvMEp+am3
HMJXRd6/XJElNhGP9wy0MjBikNcPUuqWfsrWVQxFHfuynoPfW9zlU0JmXyOQLRUF
51HHajmR1h8fYK79uoK8gITYO8mIH698264xSqUyyVsZPAczR9XZohHQcMOdFpSJ
J0q1Tjd1e28DTCw9DZZEt3J+yc0bExpXeqZKXkddM2clT6Vkp9FxuEwOhN8LdV3h
ziYMHSkjA8yIp46Udtnuh9BTP/p2h2fhYQ5Ps1FX/Ervw8EOx3DRN25jAys6/o4=
=VHoW
-----END PGP SIGNATURE-----

--jgcrNRut14sNbEwy--

--===============5359340259577660128==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5359340259577660128==--
