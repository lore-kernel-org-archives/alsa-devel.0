From: Jordi Mallach <jordi@debian.org>
Subject: Re: Fwd: via82xx problem
Date: Fri, 4 Apr 2003 00:07:25 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030403220725.GA14648@nubol.int.oskuro.net>
References: <3E854FD5.7070801@boosthardware.com> <s5h1y0nkjpt.wl@alsa2.suse.de> <20030402225838.GA5225@nubol.int.oskuro.net> <s5hadf7sx7o.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hadf7sx7o.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2003 at 12:15:55PM +0200, Takashi Iwai wrote:
> most of ALSA-native apps should have options (or config) to choose the
> pcm device.  for example,
>=20
> 	% aplay -Dhw:0,1 foo.wav
>=20
> but in your case, i guess it won't fix the problem, because it's
> VIA8233A. please make sure that /proc/asound/card0/pcm0p/info shows
> the subdevices_count =3D 1.  if it's 4, a driver bug.

It does show subdevices_count: 1. Hmm. What's wrong with it being VIA?
:)

> do you hear any sounds or completely silent?

Completely silent, although XMMS "reproduces" the ogg.

> i know there have been bug reports about the stuttering sounds, and
> bugs on UT and quake (most likely OSS-mmapped apps).  but the silence
> seems like a different problem.

When I try to tell alsa-xmms about hw:0,1 or hw:0,0, both cases show the
error: "snd_mixer_attach: no such file or directory". What mixer device
should I be trying to use? By default, alsa-xmms sets "PCM".

Jordi
--=20
Jordi Mallach P=E9rez  --  Debian developer     http://www.debian.org/
jordi@sindominio.net     jordi@debian.org     http://www.sindominio.net/
GnuPG public key information available at http://oskuro.net/~jordi/

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+jLCdJYSUupF6Il4RAsIaAKCwWX5Anz3fUNDtKzYofAJPaKYVigCfamtD
twFveGoTOxWShrJt7gJYovA=
=eFXO
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
