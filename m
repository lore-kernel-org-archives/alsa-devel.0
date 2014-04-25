From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: tlv320dac3: Use
	devm_regulator_bulk_get()
Date: Fri, 25 Apr 2014 12:16:26 +0100
Message-ID: <20140425111626.GJ12304@sirena.org.uk>
References: <1398389226-18569-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7606198194453868316=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 98C65265466
 for <alsa-devel@alsa-project.org>; Fri, 25 Apr 2014 13:16:35 +0200 (CEST)
In-Reply-To: <1398389226-18569-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7606198194453868316==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V8yjsR76vRqc3PZb"
Content-Disposition: inline


--V8yjsR76vRqc3PZb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2014 at 10:27:03PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Using devm_regulator_bulk_get() can make the code cleaner and smaller as =
we
> do not need to call regulator_bulk_free() in the error and remove paths.

Applied, thanks.

--V8yjsR76vRqc3PZb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWkQHAAoJELSic+t+oim9ow8QAJ5BVrRDlohgnJ3syriQI3Ry
SZLmImXsO+kVG9WJq4lCOUd/naZGgX3pE08DHhgzwzEWU9qmtduKcOn8sS9tgOao
zQ1ix+eZnuMDog8ecJDk+s5+MHp9lSlH6uiWF5V/Uq7Z5bHQho4ua1U5X/kLFiPB
UOS8e/HUU5lkoaTXLCS6h6M/1d86u+0QhTH3WaRHJFtTWZ5fRDHcpeKEBhwnZ8/T
RoHnfTHt+2OvlL828O1pkHKlJJf+lWSlNVJJY83ZicL8fAB4JByeuqnp9v3DvEGN
Zcn2RXFlddIL5R/vVCZhMIIUsuPGOxHnkl4G86kt1nAYXKReGvzal83j20wUfN34
pu5bRk9ejivIvtPQq+LaWi4+t+01tNGvZCwD0G2HmxYNEHXZQziUTTljZXZ0riLq
1b2xl7m6y9ZijwrSHdct1BnYrepmIybQh5DhEosDzrYJ6rvf1m8MdVkmKUAwXpbJ
ity6JCXOqMZeb/pGRkdV5daj09NMt/JK2Mb+oLY8IJKvW9EJPBIK8NWQdiTTcvoj
mjBxuZUos4QIOY+r2tqxfdWnSls98tx1DVh7Ln0qThJlPIgPBSwwZtg3TdDMKF8B
t53Ca/LNaYALrkUinWMmgXFZA3eelhTTZLwq9rgJBQ9Ac5cj1OsKj9zRI1GLNxHU
vJpc+PRNY2+2DeG28Scn
=1Mkf
-----END PGP SIGNATURE-----

--V8yjsR76vRqc3PZb--

--===============7606198194453868316==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7606198194453868316==--
