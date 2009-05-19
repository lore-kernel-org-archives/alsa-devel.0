From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Mon, 18 May 2009 21:38:52 -0500
Message-ID: <1242700732.8063.188.camel@petrie>
References: <s5h4ovovtwe.wl%tiwai@suse.de> <4A0C0985.9040004@knobbits.org>
	<4A0C0CF3.3000902@knobbits.org> <s5hvdo3vpmu.wl%tiwai@suse.de>
	<4A0C0FC1.1050709@knobbits.org> <s5hprebvozj.wl%tiwai@suse.de>
	<4A0C17AF.8020607@knobbits.org>  <s5hfxf7vmok.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3962309306473966281=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (unknown [64.71.161.129])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EFD824365
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 04:38:55 +0200 (CEST)
In-Reply-To: <s5hfxf7vmok.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "Michael (Micksa) Slade" <mslade@knobbits.org>
List-Id: alsa-devel@alsa-project.org


--===============3962309306473966281==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-WviU1hHx/60D5wyJqY7G"


--=-WviU1hHx/60D5wyJqY7G
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 2009-05-14 at 15:28 +0200, Takashi Iwai wrote:
> At Thu, 14 May 2009 23:07:59 +1000,
> Michael (Micksa) Slade wrote:
> >=20
> > Takashi Iwai wrote:
> >=20
> >     At Thu, 14 May 2009 22:34:09 +1000,
> >     Michael (Micksa) Slade wrote:
> >=20
> >         Swtiched audacious to 24bit.  It very quietly plays a badly dis=
torted version
> >         of the song :)
> >=20
> >     What about aplay with 32bit samples?
> >=20
> > Seems to work fine.  Also 24bit.  Guess it's audacious' fault.  Probabl=
y.
>=20
> It's possible that audacious tries to access 24bit, not 32bit format,=20
> and ctxfi driver has a bug around that.

Audacious indeed uses 24bit formats.  We will add proper 32bit support
in the 2.1 merge window.

William


--=-WviU1hHx/60D5wyJqY7G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkoSG7kACgkQoB+26npOQg6MiACgmJL3u3T4iTuJvBU0FEZkOaA4
9MYAoNdaIq5u0e2xYFlFABCKQYgcCOJa
=fz/E
-----END PGP SIGNATURE-----

--=-WviU1hHx/60D5wyJqY7G--


--===============3962309306473966281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============3962309306473966281==--
