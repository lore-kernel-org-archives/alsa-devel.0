From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] ASoC: pxa add Marvell
	Littleton	platform audio support
Date: Thu, 4 Jun 2009 13:42:49 +0100
Message-ID: <20090604124249.GD11496@sirena.org.uk>
References: <f17812d70906030535m4aa841cep77beb1a4362b4adf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 7C5B610393A
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 14:42:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f17812d70906030535m4aa841cep77beb1a4362b4adf@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Paul Shen <bshen9@marvell.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 03, 2009 at 08:35:23PM +0800, Eric Miao wrote:

Sorry, missed a couple of things earlier:

> +static const char *hifi_mode_select[] = {
> +	"HIFI 64FS LEFT_J, SSP CLK Master FRM Master",
> +	"HIFI 64FS I2S ,   SSP CLK Master FRM Master",
> +	"HIFI 32FS LEFT_J, SSP CLK Master FRM Master",
> +	"HIFI 32FS I2S ,   SSP CLK Master FRM Master",
> +};
> +
> +static const struct soc_enum littleton_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(4, hifi_mode_select),
> +};

BTW, for this control you really should add a comment explaining that
this is for test purposes only and that normal systems would not wish to
expose this control to applications but should just pick a suitable
configuration.

> +static int littleton_hifi_hw_params(struct snd_pcm_substream *substream,
> +				    struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
> +	struct ssp_clk_div *clkdiv;
> +	struct clk *clk_pout;
> +	int format;
> +
> +	clk_pout = clk_get(NULL, "CLK_POUT");
> +	if (IS_ERR(clk_pout)) {
> +		pr_err("failed to get POUT clock\n");
> +		return PTR_ERR(clk_pout);
> +	}
> +
> +	clk_enable(clk_pout);

At the minute clk_put is never released.

hw_params() can be repeatedly called while the stream is open,
especially by OSS emulation.  You should acquire the clock once at
driver startup time and probably move the enable and disable to
startup() and shutdown().
