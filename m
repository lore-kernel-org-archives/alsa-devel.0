From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] [PATCH V2] ASoC: SAMSUNG: Add WM8994 PCM
 Machine driver
Date: Mon, 20 Jun 2011 20:59:43 +0100
Message-ID: <4DFFA6AF.4060902@ti.com>
References: <1308558570-26593-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A55CE103814
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 21:59:52 +0200 (CEST)
In-Reply-To: <1308558570-26593-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 20/06/11 09:29, Sangbeom Kim wrote:
> This patch add WM8994 PCM machine driver to support PCM audio
> on SMDKV310, SMDKC210 boards.
> Playback and Capture supports 8kHz sampling rates.
> and It is tested on SMDKV310, SMDKC210.
> 
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> ---
>  sound/soc/samsung/Kconfig          |    8 ++
>  sound/soc/samsung/Makefile         |    2 +
>  sound/soc/samsung/smdk_wm8994pcm.c |  176 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 186 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/samsung/smdk_wm8994pcm.c
> 

Acked-by: Liam Girdwood <lrg@ti.com>

> +
> +static int smdk_wm8994_pcm_hw_params(struct snd_pcm_substream *substream,
> +			      struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
> +	unsigned long mclk_freq;
> +	int rfs, ret;
> +
> +	switch(params_rate(params)) {

Minor issue, there should really be a space after switch. You could send this incrementally.

Thanks

Liam
