From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 3/3] ALSA SoC: Add Texas Instruments
	TLV320AIC26	codec driver
Date: Tue, 22 Jul 2008 11:34:43 +0100
Message-ID: <20080722103443.GC2572@rakim.wolfsonmicro.main>
References: <20080722065352.7306.60679.stgit@trillian.secretlab.ca>
	<20080722065403.7306.53226.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BD4124340
	for <alsa-devel@alsa-project.org>;
	Tue, 22 Jul 2008 12:34:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080722065403.7306.53226.stgit@trillian.secretlab.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: timur@freescale.com, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, liam.girdwood@wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 22, 2008 at 12:54:03AM -0600, Grant Likely wrote:

> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

with the same comments about outstanding issues as applied to the CPU
side.

> +static int aic26_hw_params(struct snd_pcm_substream *substream,
> +			   struct snd_pcm_hw_params *params)
> +{

> +	switch (params_rate(params)) {
> +	case 8000:  fsref = 48000; divisor = AIC26_DIV_6; break;

> +	/* Configure PLL */
> +	pval = 1;
> +	jval = (fsref == 44100) ? 7 : 8;
> +	dval = (fsref == 44100) ? 5264 : 1920;

Without having looked at the chip datasheet these parameters probably
all need to depend on the input clock rate and the PLL configuration
should be done in a set_pll() rather than here.

> +#if defined(CONFIG_SND_SOC_OF_SIMPLE)
> +	/* Tell the of_soc helper about this codec */
> +	of_snd_soc_register_codec(&aic26_soc_codec_dev, aic26, &aic26_dai,
> +				  spi->dev.archdata.of_node);
> +#endif

This won't work if the OF_SIMPLE stuff is a module.  There's also a
checkpatch issue which I'll fix up.
