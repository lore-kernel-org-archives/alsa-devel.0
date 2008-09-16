From: Harald Welte <laforge@gnumonks.org>
Subject: Re: [PATCH 0/7] HDA patch_via.c update
Date: Tue, 16 Sep 2008 23:35:43 +0800
Message-ID: <20080916153543.GK4162@prithivi.gnumonks.org>
References: <20080909073717.GC9638@prithivi.gnumonks.org>
	<fd3eb9bf0809090708k249b59d6l92133c9fd4a29296@mail.gmail.com>
	<20080916152326.GI4162@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2514455848405292161=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 94D0924492
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Sep 2008 17:40:13 +0200 (CEST)
In-Reply-To: <20080916152326.GI4162@prithivi.gnumonks.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vedran =?utf-8?Q?Mileti=C4=87?= <rivanvx@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2514455848405292161==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Content-Disposition: inline


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2008 at 11:23:26PM +0800, Harald Welte wrote:
> On Tue, Sep 09, 2008 at 04:08:04PM +0200, Vedran Mileti=C4=87 wrote:
> > 2008/9/9 Harald Welte <HaraldWelte@viatech.com>:
> > > If you have any questions regarding VIA's hardware or need access to =
data
> > > sheets or the like, I am happy to assist.
> > Yes... I (and probably many others) would like to know if there is any
> > Envy24-II hardware out (besides MEDIASTATION[1])? This chip has been
> > out for a while.
>=20
> I have received a response from the Envy24-II product manager, so I now k=
now
> who is the major customer.
>=20
> Unfortunately the infortmation is, as I expected, confidential.  So VIA,
> including me, cannot disclose information about who is the customer and w=
ho
> is the product.  sigh.

However, I can still tell you what I just found in a public revision control
system ;->

http://mercurial.opensound.com/?file/a4db8c571ba7/kernel/drv/oss_envy24/oss=
_envy24.c

static card_spec models[] =3D {
41 {0xd6301412, "M Audio Delta 1010", 8, 8,
43 {0xd6311412, "M Audio Delta DiO 2496", 2, 0,
45 {0xd6321412, "M Audio Delta 66", 4, 4,
47 {0xd6331412, "M Audio Delta 44", 4, 4,
49 {0xd6341412, "M Audio Audiophile 2496", 2, 2,
51 {0xd6381412, "M Audio Delta 410", 8, 2, MF_D410 | MF_SPDIF | MF_MEEPROM,
53 {0xd63b1412, "M Audio Delta 1010LT", 8, 8,
55 {0xd6351412, "M Audio Delta TDIF", 8, 8, MF_SPDIF | MF_MEEPROM | MF_WCLO=
CK,
57 {0x1115153b, "Terratec EWS88MT", 8, 8,
59 {0x112b153b, "Terratec EWS88D", 8, 8,
61 {0x1130153b, "Terratec EWX 24/96", 2, 2, MF_SPDIF | MF_EWX2496,
63 {0x1138153b, "Terratec DMX6fire 24/96", 6, 6,
65 {0x17121412, "Generic Envy24 based card", 8, 8,

--=20
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFIz9JPXaXGVTD0i/8RAiVHAJ9TTHUAQfxeyA6v9vDdATnjM3IU7wCgl8as
qXcbyEKPK0BN9cFucgdu0JQ=
=+cOv
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--

--===============2514455848405292161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2514455848405292161==--
