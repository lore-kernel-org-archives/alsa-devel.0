From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: sgtl5000: Use devm_ functions
Date: Wed, 9 Jul 2014 10:01:34 +0200
Message-ID: <20140709080134.GE30458@sirena.org.uk>
References: <20140706070800.GA2927@himangi-Dell>
 <20140707144832.GL30458@sirena.org.uk>
 <alpine.DEB.2.10.1407071655171.4757@hadrien>
 <CAOMZO5AiFCnfTzo4TyB5e5c+xiHQiHUbhRVY7z=AbjOWZDX3NA@mail.gmail.com>
 <alpine.DEB.2.10.1407071721270.4757@hadrien>
 <20140708080232.GQ30458@sirena.org.uk>
 <alpine.DEB.2.10.1407081012400.2347@hadrien>
 <20140708145249.GX30458@sirena.org.uk>
 <alpine.DEB.2.02.1407090727410.2022@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G5yIW5EaChZ5gJdA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1407090727410.2022@localhost6.localdomain6>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Fabio Estevam <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Himangi Saraogi <himangi774@gmail.com>
List-Id: alsa-devel@alsa-project.org


--G5yIW5EaChZ5gJdA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2014 at 07:30:40AM +0200, Julia Lawall wrote:
> On Tue, 8 Jul 2014, Mark Brown wrote:

> > All devices do this - it's done as part of the driver model core code so
> > there is no need for individual buses to do anything.

> How should one realize that this does not apply to the original file=20
> under discussion, sound/soc/codecs/sgtl5000.c?  The associated structure=
=20
> is snd_soc_codec_driver.  What code could one look for at the call sites=
=20
> of the probe and remove functions to know that managed memory can be used?

That's not a device model driver; the way you should realise this is
that there's no device being registered on a bus which is matched by the
driver core.

--G5yIW5EaChZ5gJdA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTvPbbAAoJELSic+t+oim9CnMP/i24KZrZWKcpcV38PdzSTt/p
c02opOYdtpMaGg2Xt37SYnCf37RahIXf84FoUaQc/AMDvegsLT7tLFqHcKMhvA2B
I78NBJxt3wrOWmusZmYYHYy3pDvC5s7+eG6CYP3Wh5iqq9G/UC1J7kjrYaHAIP+C
3TmUyF+M9cwdoHVdT75pvPXjPPQvTEOSXqrUsOvH6iG7ohS/DG9Ny+r9IAmZBsnv
ygUX5p5yx8G+vXgPqoHvZSYPj53cipWoXRckfxxPztZnq3kKrATGNAxuZI7KwKRo
7QJq6cUOdIDM2Vmc/VudK7wNjkPRcKT+1WX1f/jSlwI4Bfqw1BXa+EZXjhiFMinF
joY6evIThul+ntAXjhizo9ynT7anEUrJDR/jrSbYx1XwygEpN4nZTP8bB+pGCQaE
WcNghUvEd5XNKcdKfque+eqGHvJjrgqNrhbHVTcPjHa+tVNMJdSj+QV1CaDd3M7I
ahFdgHea0hbC/oCV4JNSAo5YgRhXUVGsbr4fc27y1ghvBgJmJirIq0GzxwF74rSB
k+9d8AKXzpvqdE5PJaI4B1z7AACHFHTd4dvImrQ0HMgi02DEJUcMPv/dIyr4rDs7
ixDfQNwKzAdOBBToGtC0fadd6x3ot5h12hOvd/OZC1nrkARkVriQ6NvypB0H+sHy
zzgt6yj5p6ga7xzbQ/U1
=Lv8n
-----END PGP SIGNATURE-----

--G5yIW5EaChZ5gJdA--
