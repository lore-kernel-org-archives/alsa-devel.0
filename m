From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ALSA: ASoC: add codec driver for TI
	TAS5086
Date: Fri, 8 Mar 2013 21:07:11 +0800
Message-ID: <20130308130706.GK28481@opensource.wolfsonmicro.com>
References: <1362747129-7932-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6109834594660189844=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 23436261717
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2013 14:07:47 +0100 (CET)
In-Reply-To: <1362747129-7932-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6109834594660189844==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2013 at 01:52:09PM +0100, Daniel Mack wrote:
> This patch adds a driver for TI's TA5086 6-channel PWM processor.
>=20
> This chip has a very unusual register layout, specifically because the
> registers are of unequal size, and multi-byte registers require bulk
> writes to take effect. Regmap does not support these kind of mappings.

Applied, thanks.

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJROeJMAAoJELSic+t+oim9RZwP/0pjIJ+AQugkbUgZpvHE1daJ
CbP6ecOxi4Gva6s365grnv2HC2/tqmTgD4bgq4/QErJuOE1+RKkKDgefynNatqWz
GK0+Wvl6nfRmJe2sBvCUoj1yG8GMuxxK+l7PpbktTBUCpRHQvOqIHWtAIz1Wf8vS
TbtCmOSdqNEk4XZau5aQW2vDKt9wqVDR4mTjCle5FVFKHCazrKPqlwpShvsOA5GY
iqebQ5J0UJuSEfU1GWfLkytd5fbzVxYDg/7zGHCQAgu2Bh8SNwrbZNTMk1kQ9LJp
wh4WqNEuauNueJ9o1q3N2sUMDBJViUsIOGRZWaQA0Bjx7YnhKM6raQ349dXvd5Rd
pLX5l63LITZ9u2Cp1bls6sKpdEDWR3yCdrOM6vgDtgR7cTZTTBa895vFKGUIOSDs
fWHnDDaFoibU3bqEcvmIyZi3PDhpIXZvSe63suhyKenW7LxLgIeUlNiOpO0C6rWA
nGJXqCqRTG7CQDkJ6tJUTIRkNsd3V/KK1+7i/p52RyL7iYaeQoOua0bnd5Ee121Y
kA1E0B68lB12QnjZ0RNIgXENJ7Cs4iI42Lgb0zlZkX5tV3GtHcBU6PJR3/kK1vy/
AYxO6HKCj0t3kpfvokCIspc1jiBn2lG9dFMTwTmYQA0cwdsS0qWibykNWxPZSNst
MT1I7rkdxvVzcq1LHoyW
=Uaax
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--

--===============6109834594660189844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6109834594660189844==--
