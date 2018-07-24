From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/12] ASoC: dt-bindings: add dt bindings
 for wcd9335 audio codec
Date: Tue, 24 Jul 2018 12:06:02 +0100
Message-ID: <20180724110602.GA2414@sirena.org.uk>
References: <20180723155410.9494-1-srinivas.kandagatla@linaro.org>
 <20180723155410.9494-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0377635192697576546=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 695CD26733D
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2018 13:06:06 +0200 (CEST)
In-Reply-To: <20180723155410.9494-5-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com, vkoul@kernel.org, robh+dt@kernel.org, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============0377635192697576546==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23, 2018 at 04:54:02PM +0100, Srinivas Kandagatla wrote:
> This patch adds bindings for wcd9335 audio codec which can support both SLIMbus
> and I2S/I2C interface.

...

> +Qualcomm WCD9335 Codec is a standalone Hi-Fi audio codec IC,
> +It supports both I2S/I2C and SLIMbus audio interfaces.

This is a standalone audio CODEC but it also has a MFD binding?  I'd
have just expected a single binding for a single device.

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltXCBkACgkQJNaLcl1U
h9DjUQgAhEc7q7FN5HJ0PcoeN33FJ2gHFVad+B5osDVH7AtT2KJYhuyKyooPmCKf
G7AoBrcpFbPac9r0AkPW6EwwjEbNKHKUuZplf+vTX9dpBceUivyjDMXS3oykxt00
EauORHigaj8nADXX/dq8uRuMn5Tv5NGJNfSzWJsw9FPJRsVKzduaT7wbTLiPAbeO
37hN9sO58B1OFPVkQHInWOlhzCsNMFlvtRBR2EDmegxqb4DolDllJza1u+nwWHIm
2hbHe+VgPvy/9LRZ2T2G0kdETrY/oI2L/noucOlLqWbCftHn0b99CY1DkcsYsh8j
sdwGSE68wbIh8lw3V9zA3+brtjpWuA==
=opx9
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--

--===============0377635192697576546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0377635192697576546==--
