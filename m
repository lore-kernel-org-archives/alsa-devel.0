From: Martin Josefsson <gandalf@wlug.westbo.se>
Subject: Re: [PATCH] Fix ALSA resume
Date: Sun, 05 Dec 2004 13:11:40 +0100
Message-ID: <1102248700.1560.69.camel@tux.rsn.bth.se>
References: <1102195391.1560.65.camel@tux.rsn.bth.se>
	 <20041204172855.350100d0.akpm@osdl.org>	<41B282F0.3020704@triplehelix.org>
	 <20041204235155.3b8ad3fc.akpm@osdl.org>  <41B2DDA5.20208@triplehelix.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-HHUuHLKgGAfTZAWPS4FX"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <41B2DDA5.20208@triplehelix.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-HHUuHLKgGAfTZAWPS4FX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-12-05 at 11:06, Joshua Kwan wrote:
> Andrew Morton wrote:
> > OK, suspend was failing, yes?
>=20
> Yes.
>=20
> > Can you please test Martin's patch?
>=20
> Works for me.

Works here as well.
This is the only problem I've had with ALSA and swsusp.
It even handles suspending in the middle of playing music and then
resuming and continuing where it was.

--=20
/Martin

--=-HHUuHLKgGAfTZAWPS4FX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBsvr7Wm2vlfa207ERAgliAJ0R31DlwbNSPQkimfo+EBd8q13qggCdG7Lx
lxL8pnj2HvLMAzBIPCPPD9I=
=jyRt
-----END PGP SIGNATURE-----

--=-HHUuHLKgGAfTZAWPS4FX--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
