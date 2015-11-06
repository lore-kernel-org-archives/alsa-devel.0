From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: da7218: Add bindings documentation for DA7218
 audio codec
Date: Fri, 6 Nov 2015 10:30:32 +0000
Message-ID: <20151106103032.GY18409@sirena.org.uk>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <b7132781a4a41a20549e13b1835bb7f808f6be82.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <20151105145856.GM18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460C91F@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="B7FF+pnjRCrp0ISR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460C91F@SW-EX-MBX01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--B7FF+pnjRCrp0ISR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 05, 2015 at 05:59:29PM +0000, Opensource [Adam Thomson] wrote:
> On November 05, 2015 14:59, Mark Brown wrote:

> > > +- dlg,ldo-lvl : Required internal LDO voltage (mV) level
> > > +	[<1050>, <1100>, <1200>, <1400>]

> > Why would this ever be anything other than the minimum voltage, and
> > might we not want to vary it at runtime?

> Normally you are correct and you'll want minimum voltage for the digital engine
> but there may be the possibility for certain platform scenarios that to meet
> timings a higher voltage is required. Would prefer to leave this in in case it
> is required in the future. As a side, the default setting is the lowest voltage,
> if this binding is not provided.

That doesn't make a huge degree of sense - your non-specific "certain
platform scenarios" are almost certainly going to be DVFS things where
you need to boost the voltage of the LDO when the device needs to
operate at particularly high frequencies in which case the driver really
ought to just manage the voltage appropriately as required (ideally only
boosting it at the times where the extra load exists).

Unless you can be more specific about what the intended use is this just
doesn't seem like something we should be specifying in DT.

> > These look like DSP coefficients which I would therefore expect to be
> > configurable at runtime via a binary control rather than specified in
> > the DT - why are they in the DT?

> The expectation was these would be set once and left for a platform, which is
> why I added them to the DT. However there's no reason they couldn't be moved
> to binary control. Having looked at other codecs, I assume SND_SOC_BYTES* would
> be the preferred method for setting this kind of data?

Yes.

--B7FF+pnjRCrp0ISR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPIFHAAoJECTWi3JdVIfQt08H/0WkndFHZtEZogwh1UBOZbkX
J7HuBti0sirozDtkzAc/rq2Su8x/yEjtnFMGFieBzT0vaHJtN3AW2g1R+PKw2Hxg
gAfaFEZ4diZX4SPS7SPPQuDPi7tGt9leJ3u3bpKMsFMthaj2UUOgKJp+2246D2QM
uUITga79ecLlPorHVacB5rBrU+0dkIbPVE0dN4E+MdOHT4x1q5B2yL6yzALT3hIx
AFTcnQ65Cvs5wo2dHgryvcaK7YdKzeLOn6ZGJhu8Ce528tK7Uw3zD9jc4fMtGJpi
8znVeLsNKX/C7cBoP6Ngk/PvLA82IDK75tJOyl/a0263fx+v7AbXkbSYN+BjMi0=
=y5Uc
-----END PGP SIGNATURE-----

--B7FF+pnjRCrp0ISR--
