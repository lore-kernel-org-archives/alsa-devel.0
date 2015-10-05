From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sun4i-codec: Rework and fix headphone routing
Date: Mon, 5 Oct 2015 15:21:11 +0100
Message-ID: <20151005142111.GR12635@sirena.org.uk>
References: <1443965896-6205-1-git-send-email-maxime.ripard@free-electrons.com>
 <20151005094435.GI12635@sirena.org.uk>
 <20151005102550.GI2696@lukather>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="G23JYFG0d77Z6i/3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151005102550.GI2696@lukather>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Emilio Lopez <emilio@elopez.com.ar>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--G23JYFG0d77Z6i/3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 05, 2015 at 12:25:50PM +0200, Maxime Ripard wrote:
> On Mon, Oct 05, 2015 at 10:44:35AM +0100, Mark Brown wrote:
> > On Sun, Oct 04, 2015 at 03:38:16PM +0200, Maxime Ripard wrote:

> > > Most of the boards have their headphone jack directly connected to the
> > > matching pins of the SoCs. Since most of the time we will have the same
> > > routing path, it makes sense to put that in the driver, and only have a
> > > property describing whether that route is enabled or not.

> > What is the value in having just a dumb jack with no detection
> > configured?  It doesn't actually do anything...

> Well, it's how it's wired on most boards. The jack is directly
> connected to the SoC, without any detection mechanism, not even a
> GPIO, so we can only assume it's always there if we want it to work
> properly.

Sure, but what is the point of representing this in the driver?

> > > It also fixes the following warning messages that were seen so far:
> > > sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> > > sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Left -> direct -> Headphone Jack
> > > sun4i-codec 1c22c00.codec: ASoC: no sink widget found for Headphone Jack
> > > sun4i-codec 1c22c00.codec: ASoC: Failed to add route HP Right -> direct -> Headphone Jack

> > Why are these routes being added separately to adding the jack?  Just
> > remove the broken routes.

> I'm not sure I understand here. The former DT bindings example was
> adding this route, which was broken because of the missing output
> widget for the headphone jack.

If those warnings are being seen whatever added the routes is buggy
as-is.

> My patch here adds both if the DT says that the headphone jack is
> actually used on that board, so it should fix both issues: no broken
> route, and no missing widgets. right?

It's not really a scalable binding - it's a boolean for this one
configuration, even adding a GPIO for detection isn't going to fit in
terribly neatly.  I'm trying to figure out if we even need a binding
here.

--G23JYFG0d77Z6i/3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEodRAAoJECTWi3JdVIfQq7MH/0sEWpENsYyVRIiXsdy19V7X
61s5Ch01YY7rfQLiRas0PbXoIsqkzuefb62D9Eax+d6XciuXD+xtuLeR/M+hfuTr
U2Ih4+DC8OIsuSIOuX4hOaXcjubpWRaC3YIG21M/Qy4nJSa0mZUpDGi9vSfSrkWh
nwMYEcdBKhzDO/qA+qBwyInuG/A1ZxXpl/nwaAQL//KEOQEvWaQS/R4DVR5eiiz+
a71rPkWbi8hnRFoPNxmEVKkoQF4V10zu5aU/fUQLGzO2eRODuAiByZGNH4Jrqbts
Y3kAJajhiAhSLp0uKfWEoZkOpU6G/Ckpi66aEaj5qoNXwpp6VDSyZ8cWhPs/jTQ=
=xG0Y
-----END PGP SIGNATURE-----

--G23JYFG0d77Z6i/3--
