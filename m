From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sun4i-codec: fix first delay on Speaker
Date: Wed, 29 May 2019 11:28:24 +0100
Message-ID: <20190529102824.GN2456@sirena.org.uk>
References: <1559040459-16488-1-git-send-email-georgii.staroselskii@emlid.com>
 <CAGb2v64osE5yVdpCxSRfpkaq2TqeUUiLUbr3wZWW1rawuqxW-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7900415209613570430=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAGb2v64osE5yVdpCxSRfpkaq2TqeUUiLUbr3wZWW1rawuqxW-Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Danny Milosavljevic <dannym@scratchpost.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Georgii Staroselskii <georgii.staroselskii@emlid.com>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============7900415209613570430==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sWvRP97dwRHm9fX+"
Content-Disposition: inline


--sWvRP97dwRHm9fX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 29, 2019 at 10:34:25AM +0800, Chen-Yu Tsai wrote:

> I wonder if we shouldn't just keep the amplifier section powered up
> all the time.
> Also it seems not very many codec drivers go all out with DAPM.

Leaving the amplifier powered up all the time is going to burn a lot of
power and make any pop/click issues in the inputs more apparent.

--sWvRP97dwRHm9fX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzuXr0ACgkQJNaLcl1U
h9B/JQgAhiaOXeIOyteRvhqURWW/1spsihg8TeHWBScXmrQX/R0VwELj3hjhy5Ba
W6e7/X6sS/WUY8U+GE1/JWoOGCzGB/wi/Gs6W4E3GmegSu184H2gWwEpVlSjKP3C
fmvTSqommDR+xP/XxOv/oD0oyEkttLMX4psUw+jNjN/1GTNVZSxtX03V+/NM3OIg
tQGvT8LodFWr7zVrU3vrJCtEudoXIXtvYXUD77rulZjpDZqS4O0EJPUfIgA12AQ4
3H9C9Hk4CmcZfvjE0tfDMCcPdlo1RZTyCZVfNpOXgmW6zTHZW7tGhg06gMo1GoWy
Muw0Y5jjzucEaRn//CF6GyeK/xsIXg==
=3Vid
-----END PGP SIGNATURE-----

--sWvRP97dwRHm9fX+--


--===============7900415209613570430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7900415209613570430==--
