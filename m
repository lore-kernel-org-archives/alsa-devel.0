From: "Arun KS" <getarunks@gmail.com>
Subject: Re: [PATCH] ASoC: OMAP: Fix DSP DAI format in McBSP
	DAI driver
Date: Wed, 22 Oct 2008 11:32:35 +0530
Message-ID: <dfeb90390810212302q63ac4be2kb7ab107c5fd3f17d@mail.gmail.com>
References: <1224505799-16686-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.228])
	by alsa0.perex.cz (Postfix) with ESMTP id 865E424431
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 08:02:56 +0200 (CEST)
Received: by qb-out-0506.google.com with SMTP id e12so5077316qba.0
	for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2008 23:02:38 -0700 (PDT)
In-Reply-To: <1224505799-16686-1-git-send-email-jarkko.nikula@nokia.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2008 at 5:59 PM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
> Fix word clock length which must equal to one bit clock cycle in DSP mode.
> Surprisingly McBSP is able synchronize into wrong length when it's
> slave but e.g. TLV320AIC33 codec in slave configuration is outputting
> some amount of noise if word clock length is longer than one bit clock
> cycle.
>
> Fix also bit clock and frame sync polarities in DSP mode since they are
> opposite from I2S.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> Cc: Arun KS <arunks@mistralsolutions.com>
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |   24 ++++++++++++++++++++----
>  1 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 0a063a9..853b33a 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -43,6 +43,7 @@
>  struct omap_mcbsp_data {
>        unsigned int                    bus_id;
>        struct omap_mcbsp_reg_cfg       regs;
> +       unsigned int                    fmt;
>        /*
>         * Flags indicating is the bus already activated and configured by
>         * another substream
> @@ -200,6 +201,7 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>        struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
>        struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
>        int dma, bus_id = mcbsp_data->bus_id, id = cpu_dai->id;
> +       int wlen;
>        unsigned long port;
>
>        if (cpu_class_is_omap1()) {
> @@ -244,19 +246,29 @@ static int omap_mcbsp_dai_hw_params(struct snd_pcm_substream *substream,
>        switch (params_format(params)) {
>        case SNDRV_PCM_FORMAT_S16_LE:
>                /* Set word lengths */
> +               wlen = 16;
>                regs->rcr2      |= RWDLEN2(OMAP_MCBSP_WORD_16);
>                regs->rcr1      |= RWDLEN1(OMAP_MCBSP_WORD_16);
>                regs->xcr2      |= XWDLEN2(OMAP_MCBSP_WORD_16);
>                regs->xcr1      |= XWDLEN1(OMAP_MCBSP_WORD_16);
> -               /* Set FS period and length in terms of bit clock periods */
> -               regs->srgr2     |= FPER(16 * 2 - 1);
> -               regs->srgr1     |= FWID(16 - 1);
>                break;
>        default:
>                /* Unsupported PCM format */
>                return -EINVAL;
>        }
>
> +       /* Set FS period and length in terms of bit clock periods */
> +       switch (mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> +       case SND_SOC_DAIFMT_I2S:
> +               regs->srgr2     |= FPER(wlen * 2 - 1);
> +               regs->srgr1     |= FWID(wlen - 1);
> +               break;
> +       case SND_SOC_DAIFMT_DSP_A:
> +               regs->srgr2     |= FPER(wlen * 2 - 1);
> +               regs->srgr1     |= FWID(0);
> +               break;
> +       }
> +
>        omap_mcbsp_config(bus_id, &mcbsp_data->regs);
>        mcbsp_data->configured = 1;
>
> @@ -272,10 +284,12 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  {
>        struct omap_mcbsp_data *mcbsp_data = to_mcbsp(cpu_dai->private_data);
>        struct omap_mcbsp_reg_cfg *regs = &mcbsp_data->regs;
> +       unsigned int temp_fmt = fmt;
>
>        if (mcbsp_data->configured)
>                return 0;
>
> +       mcbsp_data->fmt = fmt;
>        memset(regs, 0, sizeof(*regs));
>        /* Generic McBSP register settings */
>        regs->spcr2     |= XINTM(3) | FREE;
> @@ -293,6 +307,8 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>                /* 0-bit data delay */
>                regs->rcr2      |= RDATDLY(0);
>                regs->xcr2      |= XDATDLY(0);
> +               /* Invert bit clock and FS polarity configuration for DSP_A */
> +               temp_fmt ^= SND_SOC_DAIFMT_IB_IF;
>                break;
>        default:
>                /* Unsupported data format */
> @@ -316,7 +332,7 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>        }
>
>        /* Set bit clock (CLKX/CLKR) and FS polarities */
> -       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
> +       switch (temp_fmt & SND_SOC_DAIFMT_INV_MASK) {
>        case SND_SOC_DAIFMT_NB_NF:
>                /*
>                 * Normal BCLK + FS.
> --
> 1.5.6.5
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
Hi Jarkko,

I can get the audio playback working by applying this patch on
tlvaic23 and osk5912. But capture is having a lot of noise.

diff --git a/sound/soc/codecs/tlv320aic23.c b/sound/soc/codecs/tlv320aic23.c
index 05138d1..327c55a 100644
--- a/sound/soc/codecs/tlv320aic23.c
+++ b/sound/soc/codecs/tlv320aic23.c
@@ -413,6 +413,23 @@ static int tlv320aic23_set_dai_fmt(struct
snd_soc_dai *codec_dai,

        }

+       /* clock inversion */
+       switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+       case SND_SOC_DAIFMT_NB_NF:
+               break;
+       case SND_SOC_DAIFMT_IB_IF:
+               iface_reg |= 0x0010;
+               break;
+       case SND_SOC_DAIFMT_IB_NF:
+               break;
+       case SND_SOC_DAIFMT_NB_IF:
+               iface_reg |= 0x0010;
+               break;
+       default:
+               return -EINVAL;
+       }
+
+
        tlv320aic23_write(codec, TLV320AIC23_DIGT_FMT, iface_reg);

        return 0;

Regards
Arun
