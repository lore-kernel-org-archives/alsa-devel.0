From: Mark Brown <broonie@kernel.org>
Subject: Re: ALSA SOC Driver (mxs-wm8753)
Date: Mon, 29 Apr 2013 21:41:41 +0100
Message-ID: <20130429204141.GI3270@sirena.org.uk>
References: <CAFio4Nem+9fj+=iUxN1awP=ZBzh=1Eca1kPi1ShjjjLR_9eO6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6115808284342785556=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C5AC2625CF
 for <alsa-devel@alsa-project.org>; Mon, 29 Apr 2013 22:41:44 +0200 (CEST)
In-Reply-To: <CAFio4Nem+9fj+=iUxN1awP=ZBzh=1Eca1kPi1ShjjjLR_9eO6A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Graham <johngavingraham@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============6115808284342785556==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OfrWf2Fun5Ae4m0Y"
Content-Disposition: inline


--OfrWf2Fun5Ae4m0Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 04, 2013 at 06:25:05PM +0000, John Graham wrote:

You should CC maintainers on e-mails, often things just on the list get
lost in the noise.

> The problem now is that the I2S data lines don't look right - the line
> from codec to TX28 looks like a (more-or-less) square wave with the
> same period as the I2S clock, but only going from ~3.1 - ~3.5 V, as
> opposed to the 0 - ~3.3 V I expect. Furthermore, it's a pretty regular
> square wave - it doesn't have all the breaks you see on a working I2S
> data line.

My immediate thought here is that you're probably seeing some sort of
electrical problem if the logic levels aren't being hit - normally this
is because both ends of the link are driving simultaneously.  I'd check
the pin mux settings on the SoC, probably in arch/arm, to make sure that
everything on the SoC is in the correct mode then check that the CPU is
configured as a slave (which sounds like the intended configuration).

--OfrWf2Fun5Ae4m0Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRftsCAAoJELSic+t+oim9WkwP/3LMYg636GTRKmRoksz2HWZT
8cd7gsUVUDAWSnu+jxpyBQ6l+rMjwAW/Pj+JUroFaVknhem9Eh5fnV0gg3Y28E9a
VxuA6EfKTR1EgX5OBkxhoQkV6NJ2jy6qEjIHBUfVzOZzOh9DTp4wD6LvBzHCLJPg
x3w/e71ExAOcocsiYaEo6woqconAOska77bGi/npbg6YqkAtXV3sgwDswAOPYB94
vixASVvpUXKagxVIrUmonUb2tGVd1C81NIIGo/11Vdxbw8HBsKLIYksb4IlMTJaH
4Tbbpa4jGnv7NLmQG5lB3ZQ8OTIjzAJYPhV4/vRudBH9oKKqCrpXnHU+hZ7s68v+
5dZ2OPlu8XSpohRQU7bHZEGWRdrXCPx7z49dR8a7p7WJHczDmBMkTMrhjhfaAGnS
HTsuhO+xPdLAz5HUFZskCgeVm0F1CTCVhNJ23k79eVrsaJdF1gCwagNvPempeOY4
wvbvg+mj/MFuwrCltoWhdNMVbncu2AA08Qe9UJp7BdUXL56dhrSoMZTuD0rw8n8R
TkZrNIhN2TkJ+EDLZ6P/wyMYWjRCwrmzmCnO+KqJyCrwv+fa5JSUCodNPlsj6n/m
Y5AAa0yBNYENtHCxK2VeBq2Zj6mT05i3XVzpd7iN7wJvBniBo40CX9bpKCiyspXT
kza6jREYgyRUxP943yZ6
=B0/2
-----END PGP SIGNATURE-----

--OfrWf2Fun5Ae4m0Y--

--===============6115808284342785556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6115808284342785556==--
