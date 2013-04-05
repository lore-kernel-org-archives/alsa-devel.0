From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v6 1/2] ALSA: ASoC: davinci-mcasp: don't
 configure AFSX direction in DIT mode
Date: Fri, 5 Apr 2013 11:27:48 +0100
Message-ID: <20130405102748.GI6597@opensource.wolfsonmicro.com>
References: <1365084800-17929-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9219623700936680439=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 572E62616E1
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 12:27:50 +0200 (CEST)
In-Reply-To: <1365084800-17929-1-git-send-email-yegorslists@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yegorslists@googlemail.com
Cc: alsa-devel@alsa-project.org, vaibhav.bedia@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============9219623700936680439==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Content-Disposition: inline


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2013 at 04:13:19PM +0200, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
>=20
> AFSX won't be used in DIT mode. The related pins are AHCLKX and
> the data pins.

Applied both, thanks.  Please use subject lines matching the subsystem.

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRXqcaAAoJELSic+t+oim9YuQQAIvrVAceciqK0OZe4n7fmzKl
WztemBxRuSW85UNZi5jZspzZNH+0gPhCElmuKooojnwZuSX13jQhrtlrEDK5ERtO
e/sBS6CMdBFOq4aY0clbin4yRUn+JWSgKLIo+bg9E/litGwPjFjwA0yKqJADl8Jv
7VdI3N0A5cjR5S57VxShKpw2iRg1MA7khh3VUwHe43tJTnGnp+beXj6+ejE2pDkw
/n/UkzHEESOEejpD+wnpfRot3SgACDfXQRuHPL1zmNnJO7eHGTDF9Xtmf/ZOB+AW
+ruetpUWFb9F5EWKC5nkAuVY61dyzncB6+9b8e0zHar2Cf5UWP27iDzZpCmN3cdi
HRmWNzQNq3X1bgNfgDHdJBSJjZV2zmgo2tV1k3rTnBKimihW0ZsAuQNjmtEsAUzP
vqLzhi727mdGKYTUO2UEhiaKvXvQX0OhBC+JkEnxj/0ZmR5KEmfB0aifUaTqBsde
dfURXQzLmJrpZl2nEUWey0GH7yozDRt8LNm+/Rr8trJmLhJ5DBCFcwxgNoh81doR
tBoYcQikyK7XKK95zW0cCxtjDX2L61Fs1A0rj2dE7PPOKKBePE1EyvnrqrbNBPbj
ms/1BOGLvvCptyE3O4WNMOYNBygQejXE4MdX/DYOgoBKZYD8jJ33LoRfq9Q4qwCA
s7sVJVrSKmnG/PUhDohi
=8qnp
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--

--===============9219623700936680439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9219623700936680439==--
