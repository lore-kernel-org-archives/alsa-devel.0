From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 16/16] ASoC: Ux500: Add machine-driver
Date: Tue, 13 Mar 2012 23:03:54 +0000
Message-ID: <20120313230353.GN3177@opensource.wolfsonmicro.com>
References: <1331651503-16917-2-git-send-email-ola.o.lilja@stericsson.com>
	<1331651503-16917-17-git-send-email-ola.o.lilja@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7861935410018601727=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5D47D1041C0
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 00:03:58 +0100 (CET)
In-Reply-To: <1331651503-16917-17-git-send-email-ola.o.lilja@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============7861935410018601727==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dp9QYJgVRVEW2bsm"
Content-Disposition: inline


--dp9QYJgVRVEW2bsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 13, 2012 at 04:11:43PM +0100, Ola Lilja wrote:

> +config SND_SOC_UX500_AB8500
> +	bool "Codec/Machine - AB8500 (MSA)"

Wny non-modular?

> +	depends on SND_SOC_UX500_MSP_I2S && SND_SOC_UX500_PLATFORM && AB8500_CORE && AB8500_GPADC

Word wrapping and this should select pretty much all of this with the
possible exception of the MFD core.

> +ifdef CONFIG_SND_SOC_UX500_AB8500
> +snd-soc-ux500-machine-objs += ux500_ab8500.o
> +endif

Again, why are you doing this non-idiomatic stuff?

> +/* Create dummy devices for platform drivers */

> +static struct platform_device ux500_pcm = {
> +		.name = "ux500-pcm",
> +		.id = 0,
> +		.dev = {
> +			.platform_data = NULL,
> +		},
> +};

The SoC or CPU side drivers should be taking care of stuff like this.

> +/* Define the whole U8500 soundcard, linking platform to the codec-drivers  */
> +struct snd_soc_dai_link u8500_dai_links[] = {
> +	#ifdef CONFIG_SND_SOC_UX500_AB8500

What's this ifdef doing...?  It looks very, very suspicous.

> +	{
> +	.name = "ab8500_0",

Your indentation is also fairly broken here.

> +	pdev = platform_device_alloc("soc-audio", -1);
> +	if (!pdev)
> +		return -ENOMEM;

No, probe using the normal device model and register using
snd_soc_register_card().

> +++ b/sound/soc/ux500/ux500_ab8500.c

The fact that you've got multiple files for a machine driver is
worrying...

> +/* ANC States */
> +static const char * const enum_anc_state[] = {
> +	"Unconfigured",
> +	"Apply FIR and IIR",
> +	"FIR and IIR are configured",
> +	"Apply FIR",
> +	"FIR is configured",
> +	"Apply IIR",
> +	"IIR is configured"
> +};

Why is this not part of the CODEC driver?  What makes this machine
specific?

> +/* Regulators */
> +enum regulator_idx {
> +	REGULATOR_AUDIO,
> +	REGULATOR_DMIC,
> +	REGULATOR_AMIC1,
> +	REGULATOR_AMIC2
> +};
> +static struct regulator_bulk_data reg_info[4] = {
> +	{	.consumer = NULL, .supply = "V-AUD"	},
> +	{	.consumer = NULL, .supply = "V-DMIC"	},
> +	{	.consumer = NULL, .supply = "V-AMIC1"	},
> +	{	.consumer = NULL, .supply = "V-AMIC2"	}
> +};
> +static bool reg_enabled[4] =  {
> +	false,
> +	false,
> +	false,
> +	false
> +};
> +static int reg_claim[4];
> +enum amic_idx { AMIC_1A, AMIC_1B, AMIC_2 };
> +struct amic_conf {
> +	enum regulator_idx reg_id;
> +	bool enabled;
> +	char *name;

I have no idea what this code is intended to do but it looks *extremely*
confused, it's especially surprising given that your CODEC makes no use
of regulators even for basic power.

> +static int enable_regulator(struct device *dev, enum regulator_idx idx)
> +{

You appear to be defining some sort of subsystem on top of the regulator
API here but I'm not sure what it's intended to do or why you're doing
it...

> +static const struct snd_soc_dapm_widget ux500_ab8500_dapm_widgets[] = {
> +	SND_SOC_DAPM_SUPPLY("AUDIO Regulator",
> +			SND_SOC_NOPM, 0, 0, dapm_audioreg_event,
> +			SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),

DAPM has native support for regulator supplies.

> +	/* Enable gpio.1-clock (needed by DSP in burst mode) */
> +	ret = clk_enable(clk_ptr_gpio1);
> +	if (ret) {
> +		dev_err(dev, "%s: ERROR: clk_enable(gpio.1) failed (ret = %d)!",
> +			__func__, ret);
> +		return ret;
> +	}

Why can't the DSP figure out that it needs to enable the clock?

--dp9QYJgVRVEW2bsm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPX9I4AAoJEBus8iNuMP3dcvEQAI9cfaF26h6sg5E4xLRs9YNZ
Gqor8uNne9Rgv1WtIrcNMcLupqht+KHu/r0V2B5kORkP/CMbCY7RkaRd9xXI4zQb
Yq6U4O0Mac8b6F5HCRO0K+gv6lg+CGDq1c28hQo/ncsAb+XtpFS8ZAQVUM2vTXet
fP6Vj7s51zqVF2r+lZZ8I70qtMWVF7NLTr1mjq8boqP7XOmKuYkDa7EKRsNmVAt1
IRxOBgf9+edv2Pu2/kUvG2eq38NXA/JAhbh8ZYBYbPifjcChDeu3D8vQ6jQIeThH
zX8a+1FP9/CKFQ9DKuT3E04cv6OWVSocYL5sU7Hyk+NDay3UkbFsXh4FOdIBdHVT
wqC5oHg2YDa0zjtQ1YCj/I4nkVEIDISYlETkoJFVAmda9F+HHQajfGsGAfh2sq2q
WkUBeU3tjweCeIojkcBxibfasV1L3V1ZNouEtHRvheDVPHnZM5NjABBlp4CdZO1o
x25mlQCJFx0/Y2Ag7/B7GWP9WlCQB3vTbL0mmLeax+ED9knly8FcgVWOOI+wxYO8
urahOHa8CuxOFY5rmcG6UX+QshxSKC/LfgS+5bb8MUpckaukuu4O4CJdFwTyuGuQ
+2rG7Sp4jz5PnIIm/m/O/YSYYHzKKPTA4svKNyvxJFjzCWjVWXpSTQjLiIe6CH41
hb7BPOnCHGCNUSxet18K
=by9T
-----END PGP SIGNATURE-----

--dp9QYJgVRVEW2bsm--

--===============7861935410018601727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7861935410018601727==--
