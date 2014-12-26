From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch V3 06/10] ASoC: ipq806x: Add LPASS CPU DAI driver
Date: Fri, 26 Dec 2014 16:56:04 +0000
Message-ID: <20141226165604.GG17800@sirena.org.uk>
References: <1419439330-2303-1-git-send-email-kwestfie@codeaurora.org>
 <1419439330-2303-7-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5brFvzndHJmu5ZwQ"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419439330-2303-7-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Greg KH <gregkh@linuxfoundation.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Device Tree Mailing List <devicetree@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--5brFvzndHJmu5ZwQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 24, 2014 at 08:42:06AM -0800, Kenneth Westfield wrote:

> +static inline int lpass_lpaif_mi2s_config(struct snd_soc_dai *dai,
> +		unsigned int channels, unsigned int bitwidth)
> +{

This is *really* big for an inline function and doesn't have any obvious
need to be one if the compiler doesn't decide to do it for itself.
Since it only gets called from hw_params() I'm not even sure why it's a
function at all...  Similarly for some of the other functions, there's
no obvious reason to specify inline.

> +static inline void lpass_lpaif_mi2s_playback_start(struct snd_soc_dai *dai)
> +{
> +	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	u32 mi2s_control_offset = LPAIF_MI2S_CTL_OFFSET(LPAIF_I2S_PORT_MI2S);
> +	u32 value;
> +
> +	value = readl(drvdata->base + mi2s_control_offset);
> +	value |= LPAIF_MI2SCTL_SPKEN;
> +	writel(value, drvdata->base + mi2s_control_offset);
> +}

> +static inline void lpass_lpaif_mi2s_playback_stop(struct snd_soc_dai *dai)
> +{

Defining functions for every read/modify/write operation is going to
make it harder to trace through the code and find out what the actual
operations are.  If the functions took parameters that allowed things to
be factored out that'd be one thing but they're not doing that.  Plus...

> +static int lpass_cpu_mi2s_daiops_hw_free(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	lpass_lpaif_mi2s_playback_stop_clear(dai);
> +
> +	return 0;
> +}

...you're only calling most of these functions from one place which
consists only of a call to that function.  This is all just making
things more complicated than they need to be.

> +static int lpass_cpu_mi2s_daiops_prepare(struct snd_pcm_substream *substream,
> +		struct snd_soc_dai *dai)
> +{
> +	lpass_lpaif_mi2s_playback_start(dai);

Why are we not doing this stuff in the trigger opertaion?  All the start
and stop stuff looks like it's in the wrong place.

> +static int lpass_cpu_mi2s_daiops_set_sysclk(struct snd_soc_dai *dai,
> +		int clk_id, unsigned int freq, int dir)
> +{
> +	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +	int ret;
> +
> +	ret = clk_set_rate(drvdata->mi2s_osr_clk, freq);
> +	if (ret) {
> +		dev_err(dai->dev, "%s: error in setting mi2s osr clk: %d\n",
> +				__func__, ret);
> +		return ret;
> +	}

How is this supposed to work - we also set this clock unconditionally in
hw_params()?

> +static int lpass_cpu_mi2s_dai_probe(struct snd_soc_dai *dai)
> +{
> +	struct lpass_mi2s_data *drvdata = snd_soc_dai_get_drvdata(dai);
> +
> +	drvdata->mi2s_osr_clk = devm_clk_get(dai->dev, "mi2s_osr_clk");
> +	if (IS_ERR(drvdata->mi2s_osr_clk)) {
> +		dev_err(dai->dev, "%s: Error in getting mi2s_osr_clk\n",
> +				__func__);
> +		return PTR_ERR(drvdata->mi2s_osr_clk);
> +	}
> +
> +	drvdata->mi2s_bit_clk = devm_clk_get(dai->dev, "mi2s_bit_clk");
> +	if (IS_ERR(drvdata->mi2s_bit_clk)) {
> +		dev_err(dai->dev, "%s: Error in getting mi2s_bit_clk\n",
> +				__func__);
> +		return PTR_ERR(drvdata->mi2s_bit_clk);
> +	}

Why are we acquiring these at the DAI level?

--5brFvzndHJmu5ZwQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUnZMjAAoJECTWi3JdVIfQ+PEH/15jMUsSqQ8dg/QUHiZZDl1R
7qVxWBTbl4+bRphPhCSJgiRf0YODW9xa+uDIOG+JorDlgdiyj2+7xp4LfDQGOx0t
m440cx1MvcjD4N/Xs3zCCLI7B9YHJ6M+sC8mSNiwgLLENwb+Ilz5wo3UkvqyWN27
uZadigcvjxVdMdPPjofO+GoXCQ3nThAnxguJW+FmVpeBwDOaXr4zDd66HXMgAncd
6fo4eeQ/RuFSUfLHpC2wLUBBh6DTvco/BTWJjDBKNqWxYTldo734eyVHVDIEVq5+
ahOsN91lwBV7MuGOBSHSh/Hl512zBYh0+0fHZGA5IjvbH1B+Q+y5qzK/mxeWACU=
=O290
-----END PGP SIGNATURE-----

--5brFvzndHJmu5ZwQ--
