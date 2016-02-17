From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: simple-card: Support for selecting system
 clocks by ID
Date: Wed, 17 Feb 2016 12:07:59 +0000
Message-ID: <20160217120759.GO7544@sirena.org.uk>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk>
 <56C2F00C.8080809@ti.com>
 <20160216134233.GN18327@sirena.org.uk>
 <20160216191346.2278.725@quark.deferred.io>
 <56C42BAF.3050900@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qi3SIpffvxS/TM8d"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C42BAF.3050900@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>, linux-clk@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>
List-Id: alsa-devel@alsa-project.org


--qi3SIpffvxS/TM8d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 17, 2016 at 10:13:35AM +0200, Peter Ujfalusi wrote:

> With this change we don't need to write custom machine drivers for setup not
> using sysclk_id == 0.
> I do think this is reasonable change by itself.

> However I do think that the current simple-card is flawed regarding to clock
> selection and the change Jyri and me are proposing is reasonable.

But you define a new ABI to specify it in the process, I'd rather fix
the flaws by using the common clock ABI than extend any device stuff.
If it didn't define a new ABI I'd probably not worry about it but one of
the issues we have with DT is that we do end up making ABIs every time
we put something in DT.

--qi3SIpffvxS/TM8d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxGKeAAoJECTWi3JdVIfQWX0H/2DHTWHHEXQujN/q9jvyMVye
coE0ygd7GYZmtpMwhzH2Sjn2kFnAl9aRpfwckzVm6we9m+GGlv0lPHIga6CyZ86m
B5UgWhaWQ0IA3V7D50kLRIsvihc5H49Extp2l1TUFNspro7vpbGS5fL0PWhoyD1S
aOfe9ifEBnIMIzNs9t095LayVS3HNz+4YUw2mVIbFjsOURiskunGwVEwxgoBSAW7
SnTSaG8DC7/O5RwSJ6wJlp3dWTpKulYSlhl6/F9ZN8aoCzMVV1koIBmR9Jd0FbJG
TULx2jtVzWsn2KaDIKcVLlkPvcrpNTyurYVYS1jbimZFL8r7VFlVhYCCkRzER7M=
=dA2F
-----END PGP SIGNATURE-----

--qi3SIpffvxS/TM8d--
