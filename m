From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/4] ASoC: wm8904: Automatically enable FLL
	when selected
Date: Fri, 21 Dec 2018 11:58:31 +0000
Message-ID: <20181221115831.GD4996@sirena.org.uk>
References: <cover.1545249666.git.mirq-linux@rere.qmqm.pl>
 <5353df1d654eae0bbbf26bc1a1d172e611c385db.1545249666.git.mirq-linux@rere.qmqm.pl>
 <20181221115227.GG16508@imbe.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2523030256451064904=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 05D25267A78
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 12:58:35 +0100 (CET)
In-Reply-To: <20181221115227.GG16508@imbe.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.cirrus.com, Takashi Iwai <tiwai@suse.com>, =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
List-Id: alsa-devel@alsa-project.org


--===============2523030256451064904==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vni90+aGYgRvsTuO"
Content-Disposition: inline


--vni90+aGYgRvsTuO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 21, 2018 at 11:52:27AM +0000, Charles Keepax wrote:
> On Wed, Dec 19, 2018 at 09:11:15PM +0100, Micha=C5=82 Miros=C5=82aw wrote:

> > +		if (!wm8904->fll_fout) {
> > +			int ret =3D wm8904_set_fll(component, WM8904_FLL_MCLK, WM8904_FLL_M=
CLK,
> > +						 clk_get_rate(wm8904->mclk), 12288000);
> > +			if (ret)
> > +				return ret;
> > +		}

> What is your thinking on selecting a 12.28MHz clock? Will this
> not cause issues with say 44.1k playback?

The driver just shouldn't be making decisions like this at all, either
generic code or a machine driver should do so.

--vni90+aGYgRvsTuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwc1WYACgkQJNaLcl1U
h9BAaAf+PlpKcduMcse5TSx/0V3V2Q1NaHHyu1KAIUarJyTxDUGrz/YNVaM+KV6+
BBMxvkvu0DryGT780p6xfFqrDGLwDnnUHTCsbfRHcebm2AAg+xsRQJ5Xn/0DeqSh
NK9+LiNzlH0fJWCZZb439uaHBsIpM8j0KnQxYJ/YmZN7719oX8LOvwmPiC+5qu8q
UV1qPwL1DdriD24fQEo7qB0TYPJhq1bmp1022c7AwkKVWDgUGfP1r6hs/GgGQQW6
SHDPWZVmmemiyLE+7UF6w2odGDNh0zr6FNhYVq9TG/9FxnusS84Da0Wk/L+DtbY8
qEAUZr992fqStRus9UYdAejkY+O+kg==
=+/QD
-----END PGP SIGNATURE-----

--vni90+aGYgRvsTuO--

--===============2523030256451064904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2523030256451064904==--
