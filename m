From: "David E. Storey" <dave@tamos.net>
Subject: RE: aplay: pcm_write:1025: write error
	&	SNDRV_PCM_IOCTL_PREPAREfailed:device or resource busy
Date: 02 Jun 2003 10:49:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054565392.602.177.camel@localhost>
References: <NDBBLGIKBJENLAMOLFHGEELNCFAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-qKQy0tg4DqKGLGZhlxwa"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <NDBBLGIKBJENLAMOLFHGEELNCFAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-qKQy0tg4DqKGLGZhlxwa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

most likely,

aplay -D hw:1,0 sound.wav

d!

On Mon, 2003-06-02 at 10:35, Mark Knecht wrote:
> >
> > anyway, in general, BIOS on some ASUS boards have a bug, and the first
> > PCM device won't work on them.
> >
>=20
> Can I tell aplay to use any other PCM device? The second device? How migh=
t I
> do this?
>=20
> aplay hw:1 sound.wav???
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.net email is sponsored by: eBay
> Get office equipment for less on eBay!
> http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-qKQy0tg4DqKGLGZhlxwa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+22QQ+5sC2muyxOMRAqpUAJ9j5MltOqXft3Gb9WcUnP11+wMy8QCfblIR
Gu49rleOxVYsuXSeIsayKpU=
=RWXt
-----END PGP SIGNATURE-----

--=-qKQy0tg4DqKGLGZhlxwa--



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
