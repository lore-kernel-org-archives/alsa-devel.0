From: Niels Christian =?ISO-8859-1?Q?=D8rgaard?= <nc@blahzone.dk>
Subject: Re: Hoping someone can help me (Assertion `frames <=
	snd_pcm_mmap_avail(pcm)' failed.)
Date: Thu, 11 Mar 2004 17:00:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1079020815.23098.10.camel@Nc>
References: <1078939970.13994.28.camel@Nc>
	 <1079003467.18054.387.camel@renegade>
	 <Pine.LNX.4.58.0403111218360.1961@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-uUYIFMO0++rIBteybjWd"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403111218360.1961@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--=-uUYIFMO0++rIBteybjWd
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2004-03-11 at 12:19, Jaroslav Kysela wrote:
> On Thu, 11 Mar 2004, Ove Kaaven wrote:
>=20
> > ons, 10.03.2004 kl. 18.32 skrev Niels Christian ?rgaard:
> > >=20
> > > The reason for me being so confused is that this occures at the call
> > > "snd_pcm_readi(snd_pcm_t *, void *, snd_pcm_uframes_t )", which for
> > > starters ain't mmap :)  I use "snd_pcm_delay(snd_pcm_t *,
> > > snd_pcm_sframes_t *)" to verify that there is sufficient data in the
> > > queue, before calling readi(),
> >=20
> > Did you remember to call snd_pcm_avail_update() right before calling
> > readi()? The docs imply that snd_pcm_delay does not update the value
> > returned by the "snd_pcm_mmap_avail" in the assertion, but
> > snd_pcm_avail_update() does (by using the latest value from stuff like
> > snd_pcm_delay or IRQ handlers, so call it after snd_pcm_delay).
>=20
> This call is required only for mmap access not for r/w access.
>=20

I had tried using avail_update(), not finding anything telling me that
it was mmap-only. I stopped, as it would always return 0, and subsequent
readi()'s produced 0 samples.

/Nc

--=20
"An object is an object, not a pointer. However, objects are accessed
through a reference, which in implementation, is typically a pointer."

--=-uUYIFMO0++rIBteybjWd
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAUI0Pq9NfCmuAMosRAv6lAJ0X0ShvcH7+Qj31kHiuk7Z6hvnhmQCfXAe8
1G681SCxmrvLy+GhsOyxX9c=
=80ib
-----END PGP SIGNATURE-----

--=-uUYIFMO0++rIBteybjWd--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
