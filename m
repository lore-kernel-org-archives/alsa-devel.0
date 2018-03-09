From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
Date: Fri, 9 Mar 2018 21:19:57 +0100
Message-ID: <20180309201957.GA7069@amd>
References: <20180308200653.GA47801@beast>
 <20180309125050.GD5252@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7948490629600426792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atrey.karlin.mff.cuni.cz (atrey.karlin.mff.cuni.cz
 [195.113.26.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 02B46267442
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 21:19:57 +0100 (CET)
In-Reply-To: <20180309125050.GD5252@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7948490629600426792==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-09 12:50:50, Mark Brown wrote:
> On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:
>=20
> > If a codec is not attached to the sound soc, a NULL deref is possible a=
s a
> > regular user in /sys.
>=20
> I can't parse this, sorry.  What is the "sound soc"?
>=20
> > +++ b/sound/soc/soc-core.c
> > @@ -137,6 +137,9 @@ static ssize_t soc_codec_reg_show(struct snd_soc_co=
dec *codec, char *buf,
> >  	size_t total =3D 0;
> >  	loff_t p =3D 0;
> > =20
> > +	if (!codec || !codec->driver)
> > +		return 0;
> > +
>=20
> How are we managing to create a sysfs file for a CODEC which doesn't
> have a CODEC struct associated with it?  That is obviously nonsensical
> and suggests we've got some more serious problem going on here - if
> there's no CODEC those sysfs attributes simply shouldn't be there.

Look for "linux-next on n900: oops in codec_reg_show() when grepping
sysfs" ... should be in your inbox.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqi7G0ACgkQMOfwapXb+vJs0QCfTPIVnAuhoIqDB/fjWIuRtEwD
OpMAniKHVGQxZHKELxmOfZ8VArHh06W4
=0i7s
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--

--===============7948490629600426792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7948490629600426792==--
