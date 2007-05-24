From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: [RFC] [PATCH 2/2] ASoC sound support for
	SMDK2440	boards: board driver
Date: Thu, 24 May 2007 18:17:13 +0100
Message-ID: <1180027033.28539.56.camel@a10072.wolfsonmicro.main>
References: <5b7270f40705240738s69b9b68aw516de14889466cfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id B5EA724431
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 19:17:14 +0200 (CEST)
In-Reply-To: <5b7270f40705240738s69b9b68aw516de14889466cfb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Zoltan Devai <zdevai@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-05-24 at 16:38 +0200, Zoltan Devai wrote:

> +
> +static int smdk2440_hw_params(struct snd_pcm_substream *substream,
> +					struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
> +	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
> +	unsigned int clk = 0;
> +	unsigned int div = 0;
> +	int ret = 0;
> +
> +	switch (params_rate(params)) {
> +		case 11025:
> +			div = 16;
> +			clk = 4233600;
> +			break;
> +		case 22050:
> +			div = 8;
> +			clk = 8467200;
> +			break;
> +		case 44100:
> +			div = 4;
> +			clk = 16934400;
> +			break;
> +		default:
> +			return -EINVAL;
> +	}
> +

case keyword should start on same column as the switch.

e.g.

	switch (x) {
	case y: 
		do_that();

Cheers

Liam
