From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 04/13] ASoC: qcom: remove hardcoded dma channel
Date: Thu, 21 May 2015 21:12:01 +0100
Message-ID: <20150521201201.GH21577@sirena.org.uk>
References: <1431779462-1732-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1431779554-1992-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WVhxcSV8VTJlfoH7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431779554-1992-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Kenneth Westfield <kwestfie@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--WVhxcSV8VTJlfoH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 16, 2015 at 01:32:34PM +0100, Srinivas Kandagatla wrote:
> This patch removes hardcoded dma channel value in lpass driver, Now the
> dma channel allocation happens in the SOC specific layer. This will
> allow different LPASS integrations to use the lpass driver in more
> generic way.

Applied, thanks.

--WVhxcSV8VTJlfoH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXjwRAAoJECTWi3JdVIfQrtUH/0aOd5z5G1Wro8yAqC2w7BRY
21Nu7PYtZjOCiDSxBSKZUxYv1nE1blfxoX44npOuGBukE5340dO9BCChOcMpwsKn
FcTQRJXdg7EPPV9na+o9pw64sLFe+nnRi3Ynv2bZdnSLud64kD7y+6pMUMfzBUj6
xNmtTA7N1j6clsfhZOif87L7SE8Q/+QhirQUQ8Y4SdERDaM5TP93+vd8KT2FluFf
mHS+FP1qnQeoapchAsTUnP/E7fFCWt1X+igxY6Wu8WQUBlPtZcWKgf1mMdKixQsV
ZICsBO52PdGTEtuzXGyaAUZ9MC52JcJdhUXn41ptN4oNNWvSzGGMQAn0sAJYwcg=
=vTiq
-----END PGP SIGNATURE-----

--WVhxcSV8VTJlfoH7--
