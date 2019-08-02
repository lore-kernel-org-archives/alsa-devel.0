From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Date: Fri, 2 Aug 2019 18:27:56 +0100
Message-ID: <20190802172756.GC5387@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
 <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
 <20190730155027.GJ4264@sirena.org.uk>
 <9b47a360-3b62-b968-b8d5-8639dc4b468d@codethink.co.uk>
 <20190801234241.GG5488@sirena.org.uk>
 <472cc4ee-2e80-8b08-d842-79c65df572f3@codethink.co.uk>
 <20190802111036.GB5387@sirena.org.uk>
 <ab0a2d14-90c0-6c28-2c80-351fccd85e68@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2JFBq9zoW8cOFH7v"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ab0a2d14-90c0-6c28-2c80-351fccd85e68@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Liam Girdwood <lgirdwood@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>, Annaliese McDermond <nh6z@nh6z.net>, Takashi Iwai <tiwai@suse.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org


--2JFBq9zoW8cOFH7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2019 at 03:51:09PM +0100, Thomas Preston wrote:
> On 02/08/2019 12:10, Mark Brown wrote:

> > You can use a read only control for the readback, or just have it be
> > triggered by overwriting the readback value.  You can cache the result.

> Keeping the trigger and result together like that would be better I think,
> although the routine isn't supposed to run mid way through playback. If
> we're mid playback the debugfs routine has to turn off AMP_ON, take the
> device back to a known state, run diagnostics, then restore. Which causes
> a gap in the audible sound.

Whatever method is used to do the triggering can always return -EBUSY
when you someone tries to do so during playback.

> >> Kirill Marinushkin mentioned this in the first review [0], it just did=
n't
> >> really sink in until now!

> > You could do that too, yeah.  Depends on what this is diagnosing and if
> > that'd be useful.

> The diagnostic status bits describe situations such as:
> - open load (no speaker connected)
> - short to GND
> - short to VCC
> - etc

> The intention is to test if all the speakers are connected. So, one might=
=20
> have a self test which runs the diagnostic and verifies it outputs:

=2E..

> I think the module parameter method is more appropriate for a
> "Turn-on diagnostic", even though I don't really like grepping dmesg
> for the result. I'll go ahead and implement that unless anyone has a
> particular preference for the kcontrol-trigger.

Right.  It's not ideal for use in production systems for example but
perhaps fine for support techs or whoever.  Up to you anyway.

--2JFBq9zoW8cOFH7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1EcpsACgkQJNaLcl1U
h9APwgf/Q4KWsYkJw+Dyy8wm8pDjOkyVsUY1B9NZLLVp7mVndWT2ywIcipH0hV+Q
DeDX02ZUjkRup/AwNN/Ptwcy4GHnREbe7g6sJPgAtPFtXcuzUCJdUJsLDt4oXl5f
Nk2TjjELzuKqFz1E1zkIl8h1CowLDljJRTgCOp7mOhmT+x6kCjvURDzhkcXYPiib
wj2Rcu4thxX+oVvl7YkOpd0Wv+ZNGyM+8gEpjI22sy2MVjpMLT9SmzMp4OdfgT0h
dRVXoXKFIDT5zDpQEteTsuJdIS+NlBGM6yfKQ1fRu/+2gSh78+c/4dfT79d/h2ui
1ZJ5R45/kE4lb4xqQ2+hfM6IeKQQZQ==
=kN6B
-----END PGP SIGNATURE-----

--2JFBq9zoW8cOFH7v--
