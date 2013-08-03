From: Pierre Ossman <pierre@ossman.eu>
Subject: Re: hda: sink info in case of AMD Radeon GPU card (no
	ELD?)
Date: Sat, 3 Aug 2013 17:02:47 +0200
Message-ID: <20130803170247.70e7825f@mjolnir.ossman.eu>
References: <CACna6rymTWUCcaibDzV8tXN509xmRTXh31SYb7C89cQX=5RJcg@mail.gmail.com>
 <CACna6ryydHmaJW+-j2sxkZTHDn69QG0EPZue13zn-qaw0ybB0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0691090775615545262=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-relay.ossman.eu (saehrimnir.ossman.eu [193.12.253.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A82261647
 for <alsa-devel@alsa-project.org>; Sat,  3 Aug 2013 17:02:55 +0200 (CEST)
In-Reply-To: <CACna6ryydHmaJW+-j2sxkZTHDn69QG0EPZue13zn-qaw0ybB0Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============0691090775615545262==
Content-Type: multipart/signed; micalg=PGP-SHA256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-30004-1375542171-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-30004-1375542171-0001-2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Apr 2013 14:04:00 +0200
Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wrote:

>=20
> I tried hacking this sink info problem again. I've installed "fglrx"
> on my AMD Radeon HD 6970M (BARTS =3D=3D DCE5) and verified it sets SAD
> registers:

Any progress on this?

I fiddled around with providing the ELD stuff out-of-band, but that's
apparently not sufficient. I guess the widget capabilities property
also needs to change. Did you check to see if that happened with fglrx?

Rgds
--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-30004-1375542171-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iF4EAREIAAYFAlH9G5sACgkQopDLsoqlmEISHAEAoEg/N+OAWkR5E6HDEG54ffYo
cl2ZP9Twn9sIT4UlcrABAMmeogOLP0x8gyyz9GUYbN4pKJMnuzTgd4MOKoGp+Cyh
=o4u/
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-30004-1375542171-0001-2--

--===============0691090775615545262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0691090775615545262==--
