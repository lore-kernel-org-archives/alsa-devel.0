From: Ryan Underwood <nemesis-lists@icequake.net>
Subject: Re: [Openvortex-dev] OpenAL - ALSA interface proposal. I request for comments...
Date: Mon, 15 Dec 2003 09:00:13 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031215150013.GA3334@dbz.icequake.net>
References: <1071454898.17638.35.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1071454898.17638.35.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa Devel list <alsa-devel@lists.sourceforge.net>, Openvortex <openvortex-dev@nongnu.org>
List-Id: alsa-devel@alsa-project.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Sun, Dec 14, 2003 at 10:21:39PM -0400, Manuel Jander wrote:
> Hi,
>=20
> Since there is almost nothing else to do to support the Aureal Vortex=20
> 3D processor on Linux, just as i announced some time ago i started
> designing a OpenAL interface for ALSA. The design is meant to be
> applicable to other hardware too.
>=20
> I made a preliminary description, from what i have done so far, because
> i want to allow other more experienced people to comment and give input
> to this.
>=20
> I posted it in plain text. I hope that is compatible enough.
> http://galadriel.mat.utfsm.cl/~mjander/aureal/alsa/OpenAL-ALSA.txt
>=20
> Well, please give it a read, and tell what do you think about. Thank you
> very much.

few things,

- is it possible to capture the 3d rendered audio in order to do
  comparisons between different soundcards?

- nit pick, but using bit shifts is better idea than decimal numbers in
  the #defines for the flags field.  (1 << 0), (1 << 1), etc.

--=20
Ryan Underwood, <nemesis@icequake.net>

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/3cx9IonHnh+67jkRAoUCAJ45LZAPXvLnKJHrl+TgylCOP/pKLwCfWHOY
BCtV2nGr8vpRYdfN/GaaK3Y=
=ukXz
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
