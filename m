From: Michael Niedermayer <michael@niedermayer.cc>
Subject: Re: ftp.alsa-project.org connection problems
Date: Thu, 28 Feb 2019 12:58:45 +0100
Message-ID: <20190228115845.GB6706@michaelspb>
References: <20190225180431.GY6706@michaelspb>
 <f358a020-3166-ec1d-dd88-f08d8c5e6996@perex.cz>
 <20190225204347.GZ6706@michaelspb>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3092081639457165543=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 92B9FF806F6
 for <alsa-devel@alsa-project.org>; Thu, 28 Feb 2019 12:58:46 +0100 (CET)
In-Reply-To: <20190225204347.GZ6706@michaelspb>
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


--===============3092081639457165543==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fo/b2PYVqg2cQvBK"
Content-Disposition: inline


--fo/b2PYVqg2cQvBK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 25, 2019 at 09:43:47PM +0100, Michael Niedermayer wrote:
> On Mon, Feb 25, 2019 at 08:52:33PM +0100, Jaroslav Kysela wrote:
> > Dne 25. 02. 19 v 19:04 Michael Niedermayer napsal(a):
> > > Hi
> > >=20
> > > Iam not sure this is the correct place to report this to but i didnt =
see it
> > > being reported anywhere yet on the ML archive or google
> >=20
> > ...
> >=20
> > > =3D=3D> PASV ... couldn't connect to 207.180.221.201 port 35333: No r=
oute to host
> > Hi,
> >=20
> >   it seems that the ftp conntrack module was not loaded correctly after
> > reboot, so the firewall blocks the passive connections. Could you give a
> > try again?
>=20
> works fine locally
>=20
> Thanks!

Another related issue
we tried to switch to https and that fails too with wget but works with bro=
wsers
It appears this is due to a incomplete certificate chain

https://www.ssllabs.com/ssltest/analyze.html?d=3Dwww.alsa-project.org&hideR=
esults=3Don
"This server's certificate chain is incomplete. Grade capped to B."

IIRC we had a similar issue on one of our servers too, required certificate=
s to be
concatenated together, so might be thats the same, or not ...

wget https://www.alsa-project.org/files/pub/lib/alsa-lib-1.1.0.tar.bz2
--2019-02-28 12:53:25--  https://www.alsa-project.org/files/pub/lib/alsa-li=
b-1.1.0.tar.bz2
Resolving www.alsa-project.org (www.alsa-project.org)... 207.180.221.201
Connecting to www.alsa-project.org (www.alsa-project.org)|207.180.221.201|:=
443... connected.
ERROR: cannot verify www.alsa-project.org's certificate, issued by =E2=80=
=98/C=3DUS/O=3DLet's Encrypt/CN=3DLet's Encrypt Authority X3=E2=80=99:
  Unable to locally verify the issuer's authority.
 =20
  [...]


--=20
Michael     GnuPG fingerprint: 9FF2128B147EF6730BADF133611EC787040B0FAB

"You are 36 times more likely to die in a bathtub than at the hands of a
terrorist. Also, you are 2.5 times more likely to become a president and
2 times more likely to become an astronaut, than to die in a terrorist
attack." -- Thoughty2


--fo/b2PYVqg2cQvBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlx3zPUACgkQYR7HhwQLD6v+gQCfYOvHAkDx80mGE+0+VLGHfDLC
SYUAn1tcA00k68A6uO5P4VZW2DD4BoE0
=3Ixg
-----END PGP SIGNATURE-----

--fo/b2PYVqg2cQvBK--

--===============3092081639457165543==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3092081639457165543==--
