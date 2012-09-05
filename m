From: Pierre Ossman <pierre-list@ossman.eu>
Subject: Re: radeon multi-channel lpcm
Date: Wed, 5 Sep 2012 18:19:23 +0200
Message-ID: <20120905181923.2e330a63@mjolnir.ossman.eu>
References: <20120831223447.065fcb62@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6435070454593624007=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-relay.ossman.eu (saehrimnir.ossman.eu [193.12.253.10])
 by alsa0.perex.cz (Postfix) with ESMTP id E4AEA265382
 for <alsa-devel@alsa-project.org>; Wed,  5 Sep 2012 18:19:29 +0200 (CEST)
In-Reply-To: <20120831223447.065fcb62@mjolnir.ossman.eu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--===============6435070454593624007==
Content-Type: multipart/signed; micalg=PGP-SHA256; protocol="application/pgp-signature"; boundary="=_freyr.ossman.eu-22386-1346861965-0001-2"

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_freyr.ossman.eu-22386-1346861965-0001-2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Noone with any insight? I'm ready to do some leg work, but I couldn't
find anything in either the HDA specification, or the AMD
documentation. :/

On Fri, 31 Aug 2012 22:34:47 +0200
Pierre Ossman <pierre-list@ossman.eu> wrote:

> Hi,
>=20
> I figured I'd have a go at finishing up support for multi-channel lcpm
> over HDMI on radeon cards. I read a post from the AMD guys stating that
> the GPU portions were already in place, and it was the audio pieces
> that were missing. Unfortunately I was unable to figure out exactly what
> it is that remains to be done.
>=20
> I poked around in patch_hdmi.c, and concluded that the generic code is
> what's being used for modern radeon cards. The card exposes two widgets
> (and output widget and a pin complex). But both widgets indicate
> through their capability registers that they only support stereo.
>=20
> I don't know enough about HDA to have any clue where to go from here.
> Should the capability field be ignored for HDMI? Or does it need some
> coaxing to allow more than stereo? The ELD stuff isn't properly updated
> from the radeon driver, but the code seems to suggest it is just for
> hints, and not critical.
>=20
> Rgds


--=20
     -- Pierre Ossman

  WARNING: This correspondence is being monitored by FRA, a
  Swedish intelligence agency. Make sure your server uses
  encryption for SMTP traffic and consider using PGP for
  end-to-end encryption.

--=_freyr.ossman.eu-22386-1346861965-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iF4EAREIAAYFAlBHe40ACgkQopDLsoqlmELubAEAm+/+3munFnhZZVlK6CTHeOwq
sFJDdOa83KFaZJeSN6YBALuZWPVdgcRJascioHKIB0b8ZKmKZeAhdBG2gQNG+++g
=g5Ql
-----END PGP SIGNATURE-----

--=_freyr.ossman.eu-22386-1346861965-0001-2--

--===============6435070454593624007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6435070454593624007==--
