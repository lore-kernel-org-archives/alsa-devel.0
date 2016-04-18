From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 4/4] ASoC: simple-card: Support for
 selecting system clocks by ID
Date: Mon, 18 Apr 2016 17:29:10 +0100
Message-ID: <20160418162910.GG3217@sirena.org.uk>
References: <1455545495-20292-1-git-send-email-peter.ujfalusi@ti.com>
 <1455545495-20292-5-git-send-email-peter.ujfalusi@ti.com>
 <20160215152635.GN18988@sirena.org.uk>
 <56C2F00C.8080809@ti.com>
 <20160216134233.GN18327@sirena.org.uk>
 <20160216191346.2278.725@quark.deferred.io>
 <56C42BAF.3050900@ti.com>
 <20160217120759.GO7544@sirena.org.uk>
 <56C4CF8B.5010005@ti.com>
 <5715025C.7070108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2eauhx3HRLXw1WRo"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5715025C.7070108@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>, linux-clk@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--2eauhx3HRLXw1WRo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2016 at 06:50:52PM +0300, Peter Ujfalusi wrote:
> On 02/17/2016 09:52 PM, Peter Ujfalusi wrote:

> > On the other hand this ABI is backwards compatible since if it is missing it
> > will default to the configuration we right now have regarding to sysclk_dir
> > and sysclk_id.

> > I will look at the CCF implementation for McASP first then for aic3x.

> The first issue with converting the McASP to use CCF internally for clock
> selection, muxing and rate configuration is that the daVinci platform does not
> use CCF at all. Given that the davinci-mcasp driver is used by daVinci, we
> need to have non CCF way supported in ASoC...

Well, at least long term we do need daVinci converting to CCF - this is
going to continue to cause problems, devices not part of the SoC can and
do contain clocks and are going to end up being supported via the clock
API.

--2eauhx3HRLXw1WRo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFQtVAAoJECTWi3JdVIfQCP0H/jzMeGZiZHjkX2f73h6IPk11
x2yU1dk86AlxJRt82amwmGM/BKjbba6k0M+f9AAG358b91j4mVE2Zu6n/Z9eACYM
KK4oIhb9v6wYe2R4wo1nO2jVLGzWO+tOwd/ppWm2MX+METGLTDLJHQHKdhDP1v3v
5uYvPNcZ6ZVaYH3qVeT3RSWIIQ9jKMdD4vTYnmmwWfX7HgfXbyhIYlppoG65rp1f
OwZ3DBG+Su1R7RfdgGtUvhyyteCH13dQUmERosmKyXiq+4oZl65HwYut0QRAalRZ
3seOfdQrdKIN6H4CPqwZTxD5rK5fusnAelx8VNlXEG+Q8Ofe+0xDADcxvAAYmZE=
=VVzg
-----END PGP SIGNATURE-----

--2eauhx3HRLXw1WRo--
