From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Date: Fri, 2 Aug 2019 12:10:36 +0100
Message-ID: <20190802111036.GB5387@sirena.org.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
 <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
 <20190730155027.GJ4264@sirena.org.uk>
 <9b47a360-3b62-b968-b8d5-8639dc4b468d@codethink.co.uk>
 <20190801234241.GG5488@sirena.org.uk>
 <472cc4ee-2e80-8b08-d842-79c65df572f3@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <472cc4ee-2e80-8b08-d842-79c65df572f3@codethink.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Preston <thomas.preston@codethink.co.uk>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Liam Girdwood <lgirdwood@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>, Annaliese McDermond <nh6z@nh6z.net>, Takashi Iwai <tiwai@suse.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2019 at 09:32:17AM +0100, Thomas Preston wrote:
> On 02/08/2019 00:42, Mark Brown wrote:

> > Yes, that's definitely doable - we've got some other drivers with
> > similar things like calibration triggers exposed that way.

> One problem with using a kcontrol as a trigger for the turn-on diagnostic
> is that the diagnostic routine has a "return value".

You can use a read only control for the readback, or just have it be
triggered by overwriting the readback value.  You can cache the result.

> Hm, maybe a better idea is to have the turn on diagnostic only run on
> device probe (as its name suggests!), and print something to dmesg:

> 	modprobe tda7802 turn_on_diagnostic=1

> 	tda7802-codec i2c-TDA7802:00: Turn on diagnostic 04 04 04 04

> Kirill Marinushkin mentioned this in the first review [0], it just didn't
> really sink in until now!

You could do that too, yeah.  Depends on what this is diagnosing and if
that'd be useful.

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1EGiwACgkQJNaLcl1U
h9Bs6Qf9FgalB0i5dzB7naDLU8yYdeZfY+teIQZhSWv5GUBav5I3hs3vkMQRCu3b
B85CYaqrGqhe/TTBEPeZq6hlAzt91By0DWQ8oYiz9t3Vf9rqAxCe5M9OzKrN/GfS
veomBXXDd4B79HHPW9mGDHsNoflXkdJbyWsx9P6ZvCRs8mc6JtrRssDje474uNqs
fC3oWklOove1G7CStDQ/8QfK8XblO2FZlBzL0H0YbSuUy74Xz8Ioimd2WX1Yvm3L
DPdOR4I6s0MvP1lhgIpTYSXki4plZ3EdwSatWi4VmVmBMVGK1rDmiXhWzBkWheJf
915A2FSIMuUS5Z+2sIRaANFl7lHKVw==
=GrVc
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
