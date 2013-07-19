From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: wm892: Set an initial non-mute volume
 for the headphones
Date: Fri, 19 Jul 2013 10:41:20 +0100
Message-ID: <20130719094120.GB9858@sirena.org.uk>
References: <1374194838-30735-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2622801083727614013=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C2368265623
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 11:41:24 +0200 (CEST)
In-Reply-To: <1374194838-30735-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============2622801083727614013==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0eh6TmSyL6TZE2Uz"
Content-Disposition: inline


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2013 at 09:47:18PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> By default the headphone left/right registers have a volume of zero.
>=20
> Instead of having to change the volume via alsamixer in order to be able =
to hear
> something, let's set an initial value of -20dB, so that audio playback ca=
n be=20
> heard by default.

As a matter of policy we go with the chip defaults on things like this.
It doesn't make everyone happy since it's typically not actually a
useful configuration for any use case but it provides a standard.

--0eh6TmSyL6TZE2Uz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR6Qm8AAoJELSic+t+oim97DYQAIb9vnlN2DsERth5uEugT3d9
srgQhyXzxfCix7Y8/mqfhwGH2kOOAv2kk2Z+s5SrpyB+aUvQ+Xm5urX6JwrrgMLn
qIggKWIBdoGWzI9GifR0ZhNaDFkdg4COfldbkNan7HFxaSrN2OFKMcTHA4rfP4MU
oj5PRl9aNfUe69svYy71OZGRX40JTJPyftJo5ExjwXNZjVBx3tuB68JWa8hIOAZI
5CuOOTAipBzt61X2gdAP2NTc0LVcUBG9yLtH0aMKJvHle9iDw7n4/eEHv+70RlVa
ohkL4gXCncfYWAY8CtVuIg/wxOHY9ass+UFA3mTeItoTW7378KNs9dsEerKXMe/S
FPsRcMBKKD5B8armThCTjOX9mIU1bGXzOysEc8uqWxVTJNzFs+/RAs5Iir+6KoX6
z91dJoz6CeJm9xtAhP4S8yAKlO6+nhI5lDnSDwhyjuDrnSC26q62CNaWLgAPnWbs
kX6qCLr3MtmZwHcsAlIYdN6Cz9VTL73siqTfDwxG8lO9iciB5sA28oLKnRrp8DGU
9Hjj8RmFM4MF9uvl0wsdUtEPX2ovReISBGsvpSLXyC3zYawwLFDZypn2Fr8GhsuV
BBZo+83dnY01lbky/RzfCIfhZo4DkMOh5E/IgBS0i8TS3t/YXXFmAsf6l/Ebud2Q
xfZqimD7zUrUbXvvt4A2
=enVb
-----END PGP SIGNATURE-----

--0eh6TmSyL6TZE2Uz--

--===============2622801083727614013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2622801083727614013==--
