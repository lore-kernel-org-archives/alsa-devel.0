From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/5] ASoC: qcom: add sdm845 sound card support
Date: Mon, 9 Jul 2018 17:33:26 +0100
Message-ID: <20180709163326.GI16082@sirena.org.uk>
References: <1530870195-13576-1-git-send-email-rohitkr@codeaurora.org>
 <1530870195-13576-4-git-send-email-rohitkr@codeaurora.org>
 <20180709111437.GB16082@sirena.org.uk>
 <b5a3f0e2-d420-603d-f9a0-f93bdbd2619f@linaro.org>
 <20180709124117.GG16082@sirena.org.uk>
 <887331ff-8892-66a7-20bc-0fce447c792f@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gJNQRAHI5jiYqw2y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <887331ff-8892-66a7-20bc-0fce447c792f@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Rohit kumar <rohitkr@codeaurora.org>, lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--gJNQRAHI5jiYqw2y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 09, 2018 at 03:02:11PM +0100, Srinivas Kandagatla wrote:
> On 09/07/18 13:41, Mark Brown wrote:
> > > AFAIU, The issue with that mechanism or EPROBEDEFER is that it works only

> > This is not the case, the card will be unbound at the ASoC level when
> > any of the components are removed and then probed again when they
> > reappear.

> I did try this and It works only for first time! May be am missing
> something!

> snd_soc_component_del_unlocked() unregisters the sound card totally. so for
> the second time (After DSP stop) there is no registered sound card in
> place.. Am not sure how this is supposed to work?

> The reason I think it works for the first time is because of EPROBEDEFER
> from the machine driver.

Ugh, right - we ripped out that code because there's no sensible use
case for it so now we don't keep the cards on a list.  The expectation
is that if someone is going around removing bits of the card they can
probably figure out that they should be removing the card first.

In any case the place to implement this is in the core, there's nothing
special about your cards here.  Either the core should be using the
component framework or the card list should be resurrected and we open
code it.  This isn't something that's unique to your device.

--gJNQRAHI5jiYqw2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltDjlUACgkQJNaLcl1U
h9Dzuwf/d8/yNOtgkhwg3Bv3BDHETSOvAfCUMJtd6SdcTKImYMto5yWnVT74gOte
VNG18sOnmCo5DVWhEZigXVlOPVXiueXfgOUWJvcO5Rokb1u/XuueXsNQKnlRRwkr
unW0xlN3DKpYR+eOVHYvZR5P3WWrMiFS58yjT8QtOTtV4F8P6z7mfRUfIqpiDj5B
YWva+v+2U8ZqhM/hiU6wmh28jXLKfUUH2j2uLMxH0nO/LZBZQ++C4WVhwQYf6oIq
Pxv+CkXvOWAYvpZApXIVuRH4BcsgyERQMgBcV2SOyRdpiz9HX4CgN6nQcJfRbkKG
HhUFLQ9DeN8m+NfuPDe4Yvd3uskATg==
=8mIg
-----END PGP SIGNATURE-----

--gJNQRAHI5jiYqw2y--
