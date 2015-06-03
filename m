From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: qcom: Remove QCOM dependency from LPASS variants
Date: Wed, 3 Jun 2015 12:06:20 +0100
Message-ID: <20150603110620.GC14071@sirena.org.uk>
References: <1433305717-8691-1-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cC4dCx2W6DcYPM7t"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433305717-8691-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jim Davis <jim.epost@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Kumar Gala <galak@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--cC4dCx2W6DcYPM7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 09:28:37PM -0700, Kenneth Westfield wrote:

> Building with the following config options ...

>  CONFIG_COMPILE_TEST=y
>  # CONFIG_SND_SOC_QCOM is not set
>  CONFIG_SND_SOC_LPASS_IPQ806X=m
>  CONFIG_SND_SOC_STORM=m

> ... causes the following build warning:

It's not obvious to me that the above set of options should be allowed
in the first place - surely the machine drivers depend on SND_SOC_QCOM
so the fix should be to add the missing dependency to the machine
drivers?

--cC4dCx2W6DcYPM7t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbt+rAAoJECTWi3JdVIfQ68AH/2HlNylVpD5LU8/DaJAJjZAO
SFv3VGq0l3kg8vaT3MNKVqUobQ/0UE9im6IRSeUhXocWHSgbA97QmTEoqvWOmJFf
XoXHuR+nptH4QZxJvEOXS5KiqNYSWQfu/qIBMVRx5UL5AWOFbcKESo+uJDGZNx8N
Zl9v4gQRkcWrPp4RByu47b8KeqVyUqfDvUrJ7F1qoScnK4vV+g+uz+NZcJeokY5q
RRDMvKstegkdW0NkpkvFfS/x5kw7LBhCa6GzdA1WB6JeVF6Xtm6IlGS3HH3VGDkI
dO90ZtAB8rWfLtn1Fu/03VWy6GuMExohNkmfLlcRd3IplBLg3QihbiDkY6QQdPo=
=pGwG
-----END PGP SIGNATURE-----

--cC4dCx2W6DcYPM7t--
