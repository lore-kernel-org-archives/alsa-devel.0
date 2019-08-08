From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Subject: Re: [PATCH] ASoC: Intel: boards: Add Cometlake machine
 driver support
Date: Thu, 8 Aug 2019 10:38:33 -0700
Message-ID: <CAFQqKeXO5XHTrgTvXDRtqPDZZNrb24GB9ps3L=7WYadW0nYuKA@mail.gmail.com>
References: <1565251120-13082-1-git-send-email-mac.chiang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01821F803F3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 19:38:45 +0200 (CEST)
Received: by mail-yb1-xb43.google.com with SMTP id j6so4206979ybm.7
 for <alsa-devel@alsa-project.org>; Thu, 08 Aug 2019 10:38:45 -0700 (PDT)
In-Reply-To: <1565251120-13082-1-git-send-email-mac.chiang@intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Chiang Mac <mac.chiang@intel.com>
Cc: "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Bard Liao <bard.liao@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 8, 2019 at 1:00 AM <mac.chiang@intel.com> wrote:

> From: Mac Chiang <mac.chiang@intel.com>
>
> reuse and add Cometlake support with:
> SSP0 for DA7219 headphone codec
> SSP1 for MAX98357a speaker amp codec
>
> Signed-off-by: Mac Chiang <mac.chiang@intel.com>
> ---
>  sound/soc/intel/boards/Kconfig                    | 15 +++++++++
>  sound/soc/intel/boards/bxt_da7219_max98357a.c     | 37
> ++++++++++++++++++++++-
>  sound/soc/intel/common/soc-acpi-intel-cnl-match.c | 12 ++++++++
>  sound/soc/intel/common/soc-intel-quirks.h         |  5 +++
>  4 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/boards/Kconfig
> b/sound/soc/intel/boards/Kconfig
> index 50bf149..617d63c 100644
> --- a/sound/soc/intel/boards/Kconfig
> +++ b/sound/soc/intel/boards/Kconfig
> @@ -256,6 +256,21 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
>
>  endif ## SND_SOC_INTEL_SKL
>
> +config SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
> +       tristate
> +       select SND_SOC_DA7219
> +       select SND_SOC_MAX98357A
> +       select SND_SOC_DMIC
> +       select SND_SOC_HDAC_HDMI
> +
> +if SND_SOC_SOF_COMETLAKE_LP
> +config SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH
> +       tristate "CML_LP with DA7219 and MAX98357A in I2S Mode"
> +       depends on I2C && ACPI
> +       depends on MFD_INTEL_LPSS || COMPILE_TEST
> +       select SND_SOC_INTEL_DA7219_MAX98357A_GENERIC
> +endif
> +
>  if SND_SOC_INTEL_APL
>
>  config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> index c0d865a..e5941ff 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -24,6 +24,8 @@
>
>  #define BXT_DIALOG_CODEC_DAI   "da7219-hifi"
>  #define BXT_MAXIM_CODEC_DAI    "HiFi"
> +#define MCLK_19M       19200000
> +#define MCLK_24M       24576000
>  #define DUAL_CHANNEL           2
>  #define QUAD_CHANNEL           4
>
> @@ -181,8 +183,13 @@ static int broxton_da7219_codec_init(struct
> snd_soc_pcm_runtime *rtd)
>         struct snd_soc_component *component = rtd->codec_dai->component;
>
>         /* Configure sysclk for codec */
> -       ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK,
> 19200000,
> +#if !IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_LP)
> +       ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK,
> MCLK_19M,
>                                      SND_SOC_CLOCK_IN);
> +#else
> +       ret = snd_soc_dai_set_sysclk(codec_dai, DA7219_CLKSRC_MCLK,
> MCLK_24M,
> +                                    SND_SOC_CLOCK_IN);
> +#endif
>         if (ret) {
>                 dev_err(rtd->dev, "can't set codec sysclk
> configuration\n");
>                 return ret;
> @@ -224,7 +231,11 @@ static int broxton_hdmi_init(struct
> snd_soc_pcm_runtime *rtd)
>         if (!pcm)
>                 return -ENOMEM;
>
> +#if !IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_LP)
>         pcm->device = BXT_DPCM_AUDIO_HDMI1_PB + dai->id;
> +#else
> +       pcm->device = dai->id;
> +#endif
>         pcm->codec_dai = dai;
>
>         list_add_tail(&pcm->head, &ctx->hdmi_pcm_list);
> @@ -683,6 +694,27 @@ static int broxton_audio_probe(struct platform_device
> *pdev)
>                                 broxton_dais[i].cpus->dai_name = "SSP2
> Pin";
>                         }
>                 }
> +       } else if (soc_intel_is_cml()) {
> +               unsigned int i;
> +
> +               broxton_audio_card.name = "cmlda7219max";
> +
> +               for (i = 0; i < ARRAY_SIZE(broxton_dais); i++) {
> +                       /* MAXIM_CODEC is connected to SSP1. */
> +                       if (!strcmp(broxton_dais[i].codecs->dai_name,
> +                                       BXT_MAXIM_CODEC_DAI)) {
> +                               broxton_dais[i].id = 1;
> +                               broxton_dais[i].name = "SSP1-Codec";
> +                               broxton_dais[i].cpus->dai_name = "SSP1
> Pin";
> +                       }
> +                       /* DIALOG_CODEC is connected to SSP0 */
> +                       else if (!strcmp(broxton_dais[i].codecs->dai_name,
> +                                       BXT_DIALOG_CODEC_DAI)) {
> +                               broxton_dais[i].id = 0;
> +                               broxton_dais[i].name = "SSP0-Codec";
> +                               broxton_dais[i].cpus->dai_name = "SSP0
> Pin";
> +                       }
> +               }
>         }
>
Would it be possible to keep the ID's unchanged? Its quite confusing with
so many platforms reusing the machine driver so it would help if the
changes are minimal.
I understand why you want to change the ID's but it would be simpler to
just use the existing ID's in topology I think.

Thanks,
Ranjani
