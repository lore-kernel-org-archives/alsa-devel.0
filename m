From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 1/2] ASoC: qcom: document apq8016 sbc machine driver
 bindings
Date: Tue, 9 Jun 2015 18:13:13 +0100
Message-ID: <20150609171313.GK14071@sirena.org.uk>
References: <1433854702-23654-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1433854769-23807-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150609165718.GH14071@sirena.org.uk>
 <55771D88.4050603@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K/BmBeHUK5PA/HQO"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55771D88.4050603@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kwestfie@codeaurora.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--K/BmBeHUK5PA/HQO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 06:08:24PM +0100, Srinivas Kandagatla wrote:

> >>>+- external	: flag to indicate if the I2S is connected to external codec

> >not sure I understand why we need a boolean property indicating if an
> >external CODEC is in use - what is the consequence of setting this
> >property?

> As of today, the consequence of setting this flag is to setup correct
> dai_link names.
> Also there are some limitations on which MI2S can be configured to external
> or internal codecs, this flag can be used in future to validate such
> configurations, if required.

That validation sounds like something that the SoC drivers should be
doing if required rather than the machine driver - otherwise every
machine driver using this SoC would have to implement the same
validation.

--K/BmBeHUK5PA/HQO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdx6oAAoJECTWi3JdVIfQX9QH/REvwmwJ/xcRXURnZjuTCoU8
iNOyvtGwFTvAu51FGJPeAnysDRLrhjK0NSA0f0J4/k8t7vEF7TCHciG+JW79NZ1c
ast5jArJ7H9uI7VnTvZ7BgPAQhIcSmEu91j5kSJjS6dmqo5XNUurL5fk+R4TV3n/
bFpfJkquDldcpKeFmkF1ctqSjaNeAptIRZezfdWWdiG1rKhbRieqJh1c0AbjRqpH
eDjNQn3lX6ONhK4wyH5cdvydw4nhOZg/Ubp/osfpmVsJkw6Ry+Qr8Sp8O3ydkGD2
Z3CBycB88CzdYEn/WwtjSRNQlaRMfAhuaYfYWdaRyTshortNhULqQzjarZMe0V0=
=Fxjs
-----END PGP SIGNATURE-----

--K/BmBeHUK5PA/HQO--
