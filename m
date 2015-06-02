From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: wm5100: remove bitwise operations involving
 GPIO level value
Date: Tue, 2 Jun 2015 21:36:31 +0100
Message-ID: <20150602203631.GV14071@sirena.org.uk>
References: <1433200031-6748-1-git-send-email-vz@mleia.com>
 <1433200158-6890-5-git-send-email-vz@mleia.com>
 <20150602194558.GI14071@sirena.org.uk>
 <556E10CD.3090301@mleia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wAzLpv+i5/B57lit"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <556E10CD.3090301@mleia.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Axel Lin <axel.lin@ingics.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--wAzLpv+i5/B57lit
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2015 at 11:23:41PM +0300, Vladimir Zapolskiy wrote:
> On 02.06.2015 22:45, Mark Brown wrote:
> > On Tue, Jun 02, 2015 at 02:09:16AM +0300, Vladimir Zapolskiy wrote:

> >> +	unsigned int val =3D 0;
> >> +
> >> +	if (value)
> >> +		val =3D 0x1 << WM5100_GP1_LVL_SHIFT;

> > Write this as an if/else so the reader doesn't have to wonder why you've
> > missed the handling of the false case. =20

> the only objection I have is that the resulting code will be two lines
> longer. If you think this code is not clear enough (is "val" vs. "value"
> misleading?), I'll change the rest of my patches, which contain the same
> logic structure, please let me know.

Especially after the unrelated style change thing earlier on (which
meant I was reading things more carefully than usual) it'd be good to
make things as clear as possible - you're right that the val vs value
thing isn't helping either. =20

Like I say I am a bit surprised that the int/bool conversion doesn't do
the right thing without any code changes other than the type of the
parameter but ICBW, I didn't actually check.

--wAzLpv+i5/B57lit
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbhPOAAoJECTWi3JdVIfQQ1oH/j7+lvjdSZhxCIiUo0W5N8JM
6D95KmZcJVOpV+6enWiaMt7ffut1+lUQoJ2mnpeJLV30IACOyJ/HdaXHbKXrHJ4g
ygzsjH7vXb7bnX1U/tP1rJPaoT/cD6HtBwBihU+PPWobgusrtDceDpGNAzoT9RxM
td0J9+5TNF21+oSIWvoHhUGXkvRAKS8c9wOxG/tXPPCch6Ixnq3vHSt9HRPFSfMP
9nB5IDlRYUkQ1Mlv5zm6fupWyX/Zhv8fuybzkYrzhIHPQHYiYT96bKOBrBQrKp0n
pig17ge5BL7MuqZOvKUQtFRe9NGaCrLaZqi8pmUXou9jWJxuWJ6gS6/lQQ8IqZA=
=4VOs
-----END PGP SIGNATURE-----

--wAzLpv+i5/B57lit--
