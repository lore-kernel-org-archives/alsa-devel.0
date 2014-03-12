From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Fix use after free
Date: Wed, 12 Mar 2014 12:07:20 +0000
Message-ID: <20140312120720.GO28112@sirena.org.uk>
References: <1394609679-10045-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7687417068714445773=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48869261A97
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 13:07:30 +0100 (CET)
In-Reply-To: <1394609679-10045-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org


--===============7687417068714445773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gp6RjDnwomNN3fWo"
Content-Disposition: inline


--Gp6RjDnwomNN3fWo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 08:34:39AM +0100, Lars-Peter Clausen wrote:
> Freeing the current list element while iterating over the list will cause a use
> after free since the iterator function will still use the current element to
> look up the next. Use list_for_each_safe() and remove the element from the list
> before freeing it to avoid this.

Applied, thanks.

--Gp6RjDnwomNN3fWo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIE31AAoJELSic+t+oim9xM4QAJ1U43BBu0/2rfbnEWGnU97p
O369BBNCrT+pkyAJScTQiE/RJKZ+iWZKcj4pej1WXWVxozkjrPln4x42xgOiNPEs
VEUlHmkb9pEa4WaOJcK5CrEmFj8nQg0tC63Zn+b/D/0z4TshVUxQE4PIqWpsFkhc
BwgJSfbzxpCIlczEicCL/HR7OEOSTMcQI3ODStWcje0O/7F6/gozuN9VFXm2vHsk
00kRjj6410rolIql2BdHgIMjrLbfH8GgQkedZRyC9Rc/SoObTfKlsod/Z5PJ2bpy
t8p/x4ioymvjqRVsVCJa/AhHWuAJlIp7cV9bnF7y6t21jvG970K1M+z3BtMkIz9I
Ktffx05e0jNg8oV8PtymNoMZtVCBOAHHgEO0Uoh3Al/NJaYpNhltHefnaFIOe1oL
/3lTrNBtW+qCgTR0yJmHX2JP03k98nY2JwbK42Qk8yowu8LuhA/6vDJ0sjmJoHj2
nxRx6lulTaKG6LO2sZ69OpzHEKAwASy7hMzgHhd36QuGwCJsXcrgUmKk+1E3Pt6w
549UaJ766E9pf1uMR6leNolXOHRJbuWBQX9P5EqJXZHPgX/4rj1FPJmfK+l5mqmj
rOvjarj5HLfqcvRIkTzl9zX1FD2t2rbplJcVSi4Y/++Uta5QcE4FoNhmLWwzGuzW
CEonxru2IXcuK8pWRFot
=e1dY
-----END PGP SIGNATURE-----

--Gp6RjDnwomNN3fWo--

--===============7687417068714445773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7687417068714445773==--
