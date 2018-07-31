From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/10] ASoC: wcd9335: add CLASS-H
	Controller support
Date: Tue, 31 Jul 2018 18:05:57 +0100
Message-ID: <20180731170557.GK5719@sirena.org.uk>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-6-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8010861535785143805=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 83817267763
 for <alsa-devel@alsa-project.org>; Tue, 31 Jul 2018 19:06:01 +0200 (CEST)
In-Reply-To: <20180727121806.18209-6-srinivas.kandagatla@linaro.org>
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


--===============8010861535785143805==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline


--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 27, 2018 at 01:18:01PM +0100, Srinivas Kandagatla wrote:

> +	res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_0KOHM;
> +	switch (mode) {
> +	case CLS_H_NORMAL:
> +		res_val = WCD9XXX_CLASSH_CTRL_VCL_VREF_FILT_R_50KOHM;
> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
> +		gain = DAC_GAIN_0DB;
> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
> +		break;
> +	case CLS_AB:
> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_NORMAL;
> +		gain = DAC_GAIN_0DB;
> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
> +		break;
> +	case CLS_H_HIFI:
> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_UHQA;
> +		gain = DAC_GAIN_M0P2DB;
> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_50MA;
> +		break;
> +	case CLS_H_LP:
> +		val = WCD9XXX_A_ANA_HPH_PWR_LEVEL_LP;
> +		ipeak = WCD9XXX_CLASSH_CTRL_CCL_1_DELTA_IPEAK_30MA;
> +		break;
> +	};

This is missing a default case for error checking, and you don't need
the semicolon at the end either.

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltglvQACgkQJNaLcl1U
h9DxCgf+MkCcuHxQonSpd9ITGrqpFrCSDOBZjOOepXTvj/tXAGLT9gfM3c/wNTNs
/j2LdASeN5XbRupEgD3WgxRQ3moXq3bwtqeFizFhz8UH1Bq612cVMbqmLNKvpDRw
uEws8494YPyxyXpEz2GgflOXiB5yUs9lSHaGJACZZU9M9BrR3wyeyBRO+1hw2Fk9
ugRL9wmNTz2pNimXaZ9qQSjZ5uaUJphoUuahXdNy+nhIWeESHskVR24vcZEyRiNr
gGOk1miiOwE2M0TO+MY1TuxoXLRQzZ7yDzuERvONQ7+RIy+iZnbFNwKO1+eP0Zzy
/kgca7nvIU19ro8aMU9+MI5WzV04iw==
=R8QF
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--

--===============8010861535785143805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8010861535785143805==--
