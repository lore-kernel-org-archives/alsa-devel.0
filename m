From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v3 3/3] ASoC: fsl_sai: Move clock operation to PM runtime
Date: Fri, 26 Apr 2019 15:11:30 +0300
Message-ID: <CAEnQRZCK5dPoD7TunxLsf8EXVb-99Vb0OQnaqa2rmAQu3eyWvw@mail.gmail.com>
References: <20190422190213.30726-1-daniel.baluta@nxp.com> <20190422190213.30726-4-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190422190213.30726-4-daniel.baluta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

This is the only patch in the series that wasn't applied.

On Mon, Apr 22, 2019 at 10:03 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> Turn off/on clocks when device enters suspend/resume. This
> can help saving power.
>
> As a further optimization, we turn off/on mclk only when SAI
> is in master mode because otherwise mclk is externally provided.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  sound/soc/fsl/fsl_sai.c | 54 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 44 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 8623b7f882b9..7fd1a81ec1aa 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -596,15 +596,8 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
>  {
>         struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
>         bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> -       struct device *dev = &sai->pdev->dev;
>         int ret;
>
> -       ret = clk_prepare_enable(sai->bus_clk);
> -       if (ret) {
> -               dev_err(dev, "failed to enable bus clock: %d\n", ret);
> -               return ret;
> -       }
> -
>         regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
>                            FSL_SAI_CR3_TRCE);
>
> @@ -621,8 +614,6 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
>         bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>
>         regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE, 0);
> -
> -       clk_disable_unprepare(sai->bus_clk);
>  }
>
>  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> @@ -932,6 +923,14 @@ static int fsl_sai_runtime_suspend(struct device *dev)
>  {
>         struct fsl_sai *sai = dev_get_drvdata(dev);
>
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[0]]);
> +
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[1]]);
> +
> +       clk_disable_unprepare(sai->bus_clk);
> +
>         regcache_cache_only(sai->regmap, true);
>         regcache_mark_dirty(sai->regmap);
>
> @@ -941,6 +940,25 @@ static int fsl_sai_runtime_suspend(struct device *dev)
>  static int fsl_sai_runtime_resume(struct device *dev)
>  {
>         struct fsl_sai *sai = dev_get_drvdata(dev);
> +       int ret;
> +
> +       ret = clk_prepare_enable(sai->bus_clk);
> +       if (ret) {
> +               dev_err(dev, "failed to enable bus clock: %d\n", ret);
> +               return ret;
> +       }
> +
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK)) {
> +               ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[1]]);
> +               if (ret)
> +                       goto disable_bus_clk;
> +       }
> +
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE)) {
> +               ret = clk_prepare_enable(sai->mclk_clk[sai->mclk_id[0]]);
> +               if (ret)
> +                       goto disable_tx_clk;
> +       }
>
>         regcache_cache_only(sai->regmap, false);
>         regmap_write(sai->regmap, FSL_SAI_TCSR, FSL_SAI_CSR_SR);
> @@ -948,7 +966,23 @@ static int fsl_sai_runtime_resume(struct device *dev)
>         usleep_range(1000, 2000);
>         regmap_write(sai->regmap, FSL_SAI_TCSR, 0);
>         regmap_write(sai->regmap, FSL_SAI_RCSR, 0);
> -       return regcache_sync(sai->regmap);
> +
> +       ret = regcache_sync(sai->regmap);
> +       if (ret)
> +               goto disable_rx_clk;
> +
> +       return 0;
> +
> +disable_rx_clk:
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_CAPTURE))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[0]]);
> +disable_tx_clk:
> +       if (sai->mclk_streams & BIT(SNDRV_PCM_STREAM_PLAYBACK))
> +               clk_disable_unprepare(sai->mclk_clk[sai->mclk_id[1]]);
> +disable_bus_clk:
> +       clk_disable_unprepare(sai->bus_clk);
> +
> +       return ret;
>  }
>  #endif /* CONFIG_PM */
>
> --
> 2.17.1
>
