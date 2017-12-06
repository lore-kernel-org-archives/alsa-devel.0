From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 4/9] ASoC: sun8i-codec: Add support for A64
	SoC
Date: Wed, 6 Dec 2017 16:32:05 +0100
Message-ID: <20171206153205.k3l5sofdco3t75mi@flea.lan>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-5-anarsoul@gmail.com>
 <20171205080444.zo2rlusqpjyraqcw@flea.lan>
 <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5892813135288766418=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 9455926704A
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 16:32:23 +0100 (CET)
In-Reply-To: <CA+E=qVdZME2fiMw09NUP4DNCYhk58dqSapCdfBjLrdMq5HFwyg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, arm-linux <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5892813135288766418==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="l5tlqkeu7it5il45"
Content-Disposition: inline


--l5tlqkeu7it5il45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 03:17:39PM -0800, Vasily Khoruzhick wrote:
> On Tue, Dec 5, 2017 at 12:04 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sun, Dec 03, 2017 at 12:41:52PM -0800, Vasily Khoruzhick wrote:
> >> Digital part of audio codec block in the A64 is very similar to what
> >> is used by the A33(sun8i) devices. However, it uses different LRCK
> >> divider.
> >>
> >> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> >
> > What makes it impossible to derive from the sample rate and number of
> > channels?
>=20
> It's BCLK / LRCK ratio as per A64 user manual, so it doesn't depend on
> sample rate. BSP driver always uses a fixed value of 64 here.

Well, it kind of does.

BCLK is sample rate * sample size * channels, and LRCK is running at
the sample rate. So the ratio is the sample size * channels.

Anything deviating from those standard i2s concepts should at least be
documented, with arguments to back them off.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--l5tlqkeu7it5il45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlooDXEACgkQ0rTAlCFN
r3TOow/9Esg1o9m9N86c1SK4YlD6KxztEQjhC0K0A2P2VeludXsjvFh1+7VlLw1n
g0xP9g7xl1tLtMpsvt2fqcbxs6VSjgp4uxvk+VQJY1jbBanWFtRMbRa1+pnQRYV1
5Bjl/kb9PUM1SuEv4+PKGhStl2LD8wwSjnP0H5CSBq12IGV/z8VrzVO++tX8jezz
aO8pKlHLp9BAoP2iZO/Ek8Y8xmw4APG0PYb7jKJtHONOq6oLRXLtpqqOcl01Y8Wd
hLnjDuMJgBhKOjznnZnm7RdPL+etIjkECi1/9XSl3jQ6WVovV85j+bSRNjQ9t2lT
pTby58/FdmR551VmQ4mVZ64DPnQfN75m9BJjZBqv4rIQdBLP3CZh52JoZGElNXuA
W4ibXvLjONJB+ihFCkqRhMWMDlAwJ7Bbh+RPDN4T3/OKRKEoPu6ANKpJ3qwG3FDF
Pi/l5KqjVJo8S8T+kXtor3H5NvsPv5kiBgU6p9EpGa1Lean6fxcLsWtQLtY8YIRo
LkhwPPokR4PxbLC7zYNReAraqlopIFTPurvkZlad8JuwH4w8l3pu4GhBEmMF4OvO
6uDcidyB9k3YJzCElMsghsrKv4mPhtAjG1wKpD0bbTVdQySdMSUdWdJVjpKFJQMD
Ls3I/d9EaSkOTOecJbA1NdIY4KtNGYB/kSVbYD28Ykbu5d4tBUQ=
=Vn+A
-----END PGP SIGNATURE-----

--l5tlqkeu7it5il45--

--===============5892813135288766418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5892813135288766418==--
