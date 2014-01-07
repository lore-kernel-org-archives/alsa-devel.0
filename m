From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: add snd_soc_of_parse_sysclk_id() for dt
Date: Tue, 7 Jan 2014 16:24:47 +0000
Message-ID: <20140107162447.GX31886@sirena.org.uk>
References: <1388648057-28373-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hWgijUzYZxhbjxYM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1388648057-28373-1-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--hWgijUzYZxhbjxYM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2014 at 03:34:17PM +0800, Xiubo Li wrote:
> This patch adds snd_soc_of_parse_sysclk_id() and supports below
> style on dt:
>=20
> sysclk-id =3D <XXX>;
>=20
> It's an optional property, If this property is absent the defualt
> vaule 0 will be returned.

The trick with this is defining what the clock should be.  Drivers would
have to start defining their clock IDs and then at some point we end up
reinventing the common clock API and bindings.  We really ought to be
moving ASoC's clock handling over towards clk but there's issues with
that given that the clock API is not available at all on some platforms
and the common clock API isn't common.  This is rather a larger bit of
work than I expect you want to do right now though...

What's your use case for this - is it possible to make the driver you're
looking at default to a clock that'll work for most systems?  That'd
sidestep the need to say which clock.  Alternatively is the CODEC only
likely to be used with systems supporting common clk in which case doing
the sysclk configuration via the clk API might be the way forwards?

--hWgijUzYZxhbjxYM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzCpLAAoJELSic+t+oim9ik4P/1oAu1w3mzG2SnxtSVkkNzx/
DvcR9IQoQuvyB20Q3QLJbLla9CBW3ihGcWxSD6N5qZ8IElhoT3BPRvS9V6/JiKY2
RJsjyWwor5/Myhm4Sq7gsmNlOah826YgyG5xgoyW4Dke0yJfmpAXBEVNfOjOerLh
AoPao+DaajMIptjxdm5o+dhuPCefNc55hgV6LXd5cJb9KFuhUzrTfE/EVbrvGZUl
hQ1sJYKPefp9BeX7bx4xuhYi4E7ak52F+gxAq9RKEz5OgAVQ0k31Q5t9gz6ko8Cc
JG4OX83FRSBkliRtWyGujV4sTmMfVibwqwoV8d+xNP66szxlF+Ay4N3jZ9MrbvnQ
sTlSMLuCymzqbQWc7XHItbe0y4VaV+/wA6ze0Bf8zJRs4PbBviRI8EJlR1/VrjBo
j482bIhDFImg0f1yoGsoLg0iPu7Jhn+wkpJTnYvL+msxxCw5bo88lQimAltOptgX
r1ZhyLp6NfkXO7e8USTsud+2ateI0fcXMngKNqJWxAfH5HCAac5i3voXGjOfLMmB
xhXFX1W7VuFgVINiJw2gz8dY8W/5TQoUs9CPN5d2JamCir9lD+KXKCC39miaDAqu
Vkwe/VccRdy0XVVzgg5yJBgfZ6vp4GOP0cH9JUyos6GQM+mIPKiBjr02gaizuTjL
LBvOIwGGeuth4zKkW+dP
=YwO5
-----END PGP SIGNATURE-----

--hWgijUzYZxhbjxYM--
