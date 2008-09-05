From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 3/9] ASoC: Blackfin: DMA Driver for AC97
	sound chip
Date: Fri, 5 Sep 2008 13:48:22 +0100
Message-ID: <20080905124821.GG12383@sirena.org.uk>
References: <1220610102-7716-1-git-send-email-cooloney@kernel.org>
	<1220610102-7716-4-git-send-email-cooloney@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id BDC4D103815
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 14:48:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1220610102-7716-4-git-send-email-cooloney@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>
Cc: Cliff Cai <cliff.cai@analog.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 05, 2008 at 06:21:36PM +0800, Bryan Wu wrote:

> +static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
> +{
> +	struct snd_pcm_runtime *runtime = substream->runtime;
> +	int ret;
> +
> +	pr_debug("%s enter\n", __func__);
> +	snd_soc_set_runtime_hwparams(substream, &bf5xx_pcm_hardware);
> +
> +	ret = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> +	if (ret < 0)
> +		goto out;

This change now goes over 80 columns...  I'll fix this up locally.
