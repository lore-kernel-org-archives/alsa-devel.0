From: Michael Niedermayer <michael@niedermayer.cc>
Subject: Re: ftp.alsa-project.org connection problems
Date: Mon, 25 Feb 2019 21:43:47 +0100
Message-ID: <20190225204347.GZ6706@michaelspb>
References: <20190225180431.GY6706@michaelspb>
 <f358a020-3166-ec1d-dd88-f08d8c5e6996@perex.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1125873441273735170=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net
 [217.70.183.195])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BAA7F89658
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2019 21:43:49 +0100 (CET)
In-Reply-To: <f358a020-3166-ec1d-dd88-f08d8c5e6996@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1125873441273735170==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="q5wOvoHkaccQRDme"
Content-Disposition: inline


--q5wOvoHkaccQRDme
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 08:52:33PM +0100, Jaroslav Kysela wrote:
> Dne 25. 02. 19 v 19:04 Michael Niedermayer napsal(a):
> > Hi
> >=20
> > Iam not sure this is the correct place to report this to but i didnt se=
e it
> > being reported anywhere yet on the ML archive or google
>=20
> ...
>=20
> > =3D=3D> PASV ... couldn't connect to 207.180.221.201 port 35333: No rou=
te to host
> Hi,
>=20
>   it seems that the ftp conntrack module was not loaded correctly after
> reboot, so the firewall blocks the passive connections. Could you give a
> try again?

works fine locally

Thanks!

[...]

--=20
Michael     GnuPG fingerprint: 9FF2128B147EF6730BADF133611EC787040B0FAB

The smallest minority on earth is the individual. Those who deny=20
individual rights cannot claim to be defenders of minorities. - Ayn Rand

--q5wOvoHkaccQRDme
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlx0U4MACgkQYR7HhwQLD6u4tACfW0PYTU9Dthd0re0gHZLGXV30
NGQAniGcmi+gkJ8Z8kOa11OdzDOQY3iP
=l9v4
-----END PGP SIGNATURE-----

--q5wOvoHkaccQRDme--

--===============1125873441273735170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1125873441273735170==--
