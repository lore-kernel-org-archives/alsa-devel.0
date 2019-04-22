From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/3 v3] ASoC: fsl_sai: Move clock operation
 to PM runtime
Date: Mon, 22 Apr 2019 14:25:59 +0300
Message-ID: <CAEnQRZBrpD=mG7JmSFYVarv05hHHgApEDYNu9x2GLHO1NEvRiw@mail.gmail.com>
References: <20190421193853.10188-1-daniel.baluta@nxp.com> <20190421193853.10188-4-daniel.baluta@nxp.com>
 <1555931172.31656.6.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555931172.31656.6.camel@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "timur@kernel.org" <timur@kernel.org>, "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>, "festevam@gmail.com" <festevam@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tiwai@suse.com" <tiwai@suse.com>, "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 22, 2019 at 2:07 PM Viorel Suman <viorel.suman@nxp.com> wrote:
>
> Hi Daniel,
>
> On Du, 2019-04-21 at 19:39 +0000, Daniel Baluta wrote:
> > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> >
> > Turn off/on clocks when device enters suspend/resume. This
> > can help saving power.
> >
> > As a further optimization, we turn off/on mclk only when SAI
> > is in master mode because otherwise mclk is externally provided.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 60 ++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 50 insertions(+), 10 deletions(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 8623b7f882b9..13a462360ed3 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -596,15 +596,8 @@ static int fsl_sai_startup(struct snd_pcm_substream *substream,
> >  {
> >       struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> >       bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> > -     struct device *dev = &sai->pdev->dev;
> >       int ret;
> >
> > -     ret = clk_prepare_enable(sai->bus_clk);
> > -     if (ret) {
> > -             dev_err(dev, "failed to enable bus clock: %d\n", ret);
> > -             return ret;
> > -     }
> > -
> >       regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE,
> >                          FSL_SAI_CR3_TRCE);
> >
> > @@ -621,8 +614,6 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
> >       bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> >
> >       regmap_update_bits(sai->regmap, FSL_SAI_xCR3(tx), FSL_SAI_CR3_TRCE, 0);
> > -
> > -     clk_disable_unprepare(sai->bus_clk);
> >  }
> >
> >  static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
> > @@ -932,6 +923,16 @@ static int fsl_sai_runtime_suspend(struct device *dev)
> >  {
> >       struct fsl_sai *sai = dev_get_drvdata(dev);
> >
> > +     if (!sai->is_slave_mode) {
> This check is redundant as the bits in sai->mclk_streams are set/unset for master
> mode only, please check fsl_sai_hw_params and fsl_sai_hw_free functions.

Hi Viorel,

I think you make a very good point here. Will fix and send v3.

Thanks!
