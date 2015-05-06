From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 7/8] ASoC: wm8998: Initial WM8998 codec driver
Date: Wed, 6 May 2015 13:34:55 +0100
Message-ID: <20150506123455.GR22845@sirena.org.uk>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1430493319-23808-8-git-send-email-rf@opensource.wolfsonmicro.com>
 <20150504113943.GB15510@sirena.org.uk>
 <20150505092411.GA15549@opensource.wolfsonmicro.com>
 <20150505105327.GZ22845@sirena.org.uk>
 <20150505133129.GA26101@opensource.wolfsonmicro.com>
 <20150505215934.GH15510@sirena.org.uk>
 <20150506092405.GA17710@opensource.wolfsonmicro.com>
 <20150506114849.GM22845@sirena.org.uk>
 <20150506122153.GA29266@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U1Fr+mZHKwKJ1EEe"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150506122153.GA29266@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--U1Fr+mZHKwKJ1EEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 06, 2015 at 01:21:53PM +0100, Richard Fitzgerald wrote:
> On Wed, May 06, 2015 at 12:48:49PM +0100, Mark Brown wrote:

> > >     'IN1L Mux' = 'B'
> > >     'IN1R Mux' = 'B'

> > > It's much more readably obvious that both channels are set the same
> > > rather than

> > Right, but as I said on the initial version in the case where you care
> > the user probably shouldn't have the ability to set them independently
> > in the first place.

> They don't. In this version I've got a custom put so that in the
> configuration where they must both change together changing one will force
> the other to the same state.

OK, so it's not something you need to check then!

--U1Fr+mZHKwKJ1EEe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSgpuAAoJECTWi3JdVIfQlUsH/jlYTzlj3DF9Vcnt+SrTfglO
HrAbC3BQmNrB/SVuhmPv/k4fe0I15aCf51LAFRik8faUmK0tmOBDRxhv83TPnkbj
hmtifjzhL1obwFC8ljF4FFdHZXOeYw6XF/uv3EuhjbduNPOTYCGed8gLrCHNOHyE
ZEYdK1YDSsI3KkE3zVx+b9rr9NLCJIRHcxv+hr0Uhf/h+dERn4IpjWjepb9lsrr+
GaljmBnFKdmk6/f5ZrfMU33rOpsWMjWMtX9oYMEvGABH/dk7s58q/GpQBb36Z+fm
rE6CL+MA9xUy+aPp9Ojb1l+dIKgL+JnmP67Vz9fbwZhtK8XspjH/oMjoG5Nwcps=
=o6jY
-----END PGP SIGNATURE-----

--U1Fr+mZHKwKJ1EEe--
