From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 03/19] ASoC: mrst_machine: add
	moorestown	machine driver
Date: Wed, 4 May 2011 15:55:17 +0100
Message-ID: <20110504145517.GB7366@opensource.wolfsonmicro.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134509.32443.32365.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 095AE103937
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 16:55:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504134509.32443.32365.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wang Xingchao <xingchao.wang@intel.com>, Koul Vinod <vinod.koul@intel.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, May 04, 2011 at 09:45:09PM +0800, Lu Guanqun wrote:
> This machine driver glues upd9976 codec driver and sst_platform driver.
> 
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>

> +static int mrst_hw_params(struct snd_pcm_substream *substream,
> +			  struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	int ret;
> +
> +	ret = snd_soc_dai_set_fmt(codec_dai,
> +				  SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM);
> +
> +	return ret;
> +}

Should we not be letting know the CPU that the CODEC is master?  Or is
it by default slave?

Thanks,
Dimitris
