From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv6][ 1/4] ASoC: eukrea-tlv320: Add DT support.
Date: Thu, 24 Oct 2013 11:01:55 +0100
Message-ID: <20131024100155.GI31415@sirena.org.uk>
References: <1382519766-17359-1-git-send-email-denis@eukrea.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4797689717641743872=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1382519766-17359-1-git-send-email-denis@eukrea.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Denis Carikli <denis@eukrea.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4797689717641743872==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Content-Disposition: inline


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 23, 2013 at 11:16:03AM +0200, Denis Carikli wrote:

> +	/* fsl_ssi lacks the set_fmt ops. */
> +	if (!priv->of) {
> +		ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> +					  SND_SOC_DAIFMT_NB_NF |
> +					  SND_SOC_DAIFMT_CBM_CFM);
> +		if (ret) {
> +			dev_err(cpu_dai->dev,
> +				"Failed to set the cpu dai format\n");
> +			return ret;
> +		}

This is unrelated to OF support, whatever version of the DAI does have
the operation might be used on an ACPI system for example.  What would
be better would be to check the return value for -ENOTSUPP and ignore
that while still passing on other errors.  The same thing applies to the
other ops that aren't supported.

>  	if (ret) {
> -		pr_err("%s: failed set codec dai format\n", __func__);
> +		dev_err(cpu_dai->dev,
> +			"Failed to set the codec dai format.\n");
>  		return ret;

This is a useful cleanup but should be done in a separate patch.

> +	/* fsl_ssi lacks the set_sysclk ops */
> +	if (!priv->of) {
> +		snd_soc_dai_set_tdm_slot(cpu_dai, 0xffffffc, 0xffffffc, 2, 0);

This is nothing to do with sysclk, but that's just a minor point about
the grouping and commenting.

> @@ -80,7 +97,6 @@ static struct snd_soc_dai_link eukrea_tlv320_dai = {
>  	.name		= "tlv320aic23",
>  	.stream_name	= "TLV320AIC23",
>  	.codec_dai_name	= "tlv320aic23-hifi",
> -	.platform_name	= "imx-ssi.0",

Does this not break existing users?

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaPAQAAoJELSic+t+oim9xw4P/iLHi4LNB0L3jo17vNd0dWRE
IJhxzjzZzlAdXNIWqh2sgzk0wToJJ5OCRAql6LR8dJFLPBtV1P4YSD0sr5FRMYm5
esqhUbfQkHMfG1ujLOTaodDdAdHpNt7oxxO9zZ7otEnXdHaQfJ5XSjX/UH78tsIN
dT/Fwj3xwJSFGpEO/9az5BlLtWr38ZmgjTMNbEkgFegSPBsbchbU+U2WoMTj01yn
Y07kwf/NVhMPrjh6SeY8DkaIA/af0KL0FV0Hg+2x/wC9oc///CIg2jItBPqTULxl
KbTIOgujk7WlZ5oLtVJ7ohyNUM+lFJVRm5ZpiZM4wQYbyvNbbuhrJqlMqrULxlc6
qMI/MooHTrvp3ag4iud0/qkw/Xrg4p+9PkuUxb/of9+e7y0f4d6i6VCRB9kdCMtO
35D8VL8AJIqrrn3Dq2vJGImQiFgTWUYnFbfv7JolU/cvu5Pnd5RLOEWpv1iEMCfu
USZ2CHezwSZToE4Q7YlSKi6AmY7MUi0orfNBDeKAOoRQPRlIr9Wd63Pxf1Qt30Gh
Bp10WZI7hEO5JdObgA6ve1MNLMN0e4CbakNCgncx5ekF/esL3jhUQ5nlpoBCqWeF
rFOsiXF6AQ3SZWYdqrpTI5TyRvp8ir+cstwHDRDU24KK4/Agfw/Wf9kCXC301y/Z
p4r7Q0acp92xhk6wQhKb
=/9jg
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--


--===============4797689717641743872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4797689717641743872==--
