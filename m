From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 02/11] ASoC: dpcm: Allow PCMs to omit
 the set of supported formats
Date: Mon, 6 Jan 2014 17:42:58 +0000
Message-ID: <20140106174258.GQ31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2519410064711237084=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 06D98265197
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 18:43:05 +0100 (CET)
In-Reply-To: <1389014356-7014-2-git-send-email-lars@metafoo.de>
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
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2519410064711237084==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8WfetLtxVmRwFcos"
Content-Disposition: inline


--8WfetLtxVmRwFcos
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:07PM +0100, Lars-Peter Clausen wrote:
> Allow PCMs that do not impose any restrictions on the supported formats to set
> the formats field to 0, Instead of assuming that this means that the PCM does
> not support any formats (which doesn't make much sense), assume that it supports
> all formats. This brings the behavior of DPCM closer to that of non-DPCM.

Applied, thanks.

--8WfetLtxVmRwFcos
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSyusfAAoJELSic+t+oim9Z44P/RoR1XjA9lQpefGA/H+ayma+
t1NsHwv/y8RhjOCewY7xaqCbiKx5Ek72/Tp4bL1wA/KXMEhUG6gZKPHL3w4S5vEh
r7EuEq/VffI+asPJE8qTAyKj9JXJ3SCwknHdUZWbQOh7I02bECM4MaZvfWRuNCoi
nQyZlS0uIhNW4C4E4BF2zJfWOVIwhw10nZgXoEcnR7zujsu9+r7yebaWRzrmiP1Y
Dv2f1Ue36iSpkzdPDQDJkmjs3Gcn4Unjl942n0xlW6ULX/UJz208bl4rYFkl9y4p
YhLiD0Z2mD7o3S1Rn1Rw031OvbXis1UT0fA9qhc7JuhSyynEAe2/61evVvgS7so4
HzeuLuu/IMyXIUlvG7uqVC6o2mjd7P8GQMr+qvCDpyHyKsl9zmsimMuuuaNVPZhz
btfQylIgyErKHYmvsedc7/avOnBfdu+/coCYMsiaWC7AOIhQd/H0LMcOuiuEWnjn
oG7qcFP6Op6kLolyOyHBKsJgHeb7eH17NzKaEIPzBIaN2vCsdnw3CiN3LB0QUU8e
pg6nX+76XvYK0k/VS9FU3kOQVtGQ/z7GUvarswTs9WSoNPgEdhTr6iVybVpkP2Pq
AP+qDZo/BKlJ5BfWZ7HkIxLnI7UySRSKlG+I+TbMT17c7McfWdMz0kVUC7FA0wIK
oRzciQnYuFT+9KlNW5cR
=j8sa
-----END PGP SIGNATURE-----

--8WfetLtxVmRwFcos--

--===============2519410064711237084==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2519410064711237084==--
