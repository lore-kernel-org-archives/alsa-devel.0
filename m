From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH] ASoC: AMD: Set constraints for DMIC and MAX98357a codec
Date: Mon, 27 Aug 2018 17:01:01 -0600
Message-ID: <CAGS+omDCWFjLKNOfRHQzWNUG4efpC+9Tk=RXDDUDtza7skZ2dA@mail.gmail.com>
References: <1534834520-18397-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1534834520-18397-1-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshu Agrawal <akshu.agrawal@amd.com>
Cc: Alexander.Deucher@amd.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz, tiwai@suse.com, Vijendar.Mukunda@amd.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, weiyongjun1@huawei.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 21, 2018 at 12:55 AM Akshu Agrawal <akshu.agrawal@amd.com> wrote:
>
> We support dual channel, 48Khz. This constraint was set only for
> da7219. It is being extended to DMIC and MAX98357a.
>
> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  sound/soc/amd/acp-da7219-max98357a.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
> index 066d5489..cf2f648 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -162,10 +162,21 @@ static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
>
>  static int cz_max_startup(struct snd_pcm_substream *substream)
>  {
> +       struct snd_pcm_runtime *runtime = substream->runtime;
>         struct snd_soc_pcm_runtime *rtd = substream->private_data;
>         struct snd_soc_card *card = rtd->card;
>         struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
>
> +       /*
> +        * On this platform for PCM device we support stereo
> +        */
> +
> +       runtime->hw.channels_max = DUAL_CHANNEL;
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +                                  &constraints_channels);
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +                                  &constraints_rates);
> +
>         machine->i2s_instance = I2S_BT_INSTANCE;
>         return da7219_clk_enable(substream);
>  }
> @@ -177,20 +188,42 @@ static void cz_max_shutdown(struct snd_pcm_substream *substream)
>
>  static int cz_dmic0_startup(struct snd_pcm_substream *substream)
>  {
> +       struct snd_pcm_runtime *runtime = substream->runtime;
>         struct snd_soc_pcm_runtime *rtd = substream->private_data;
>         struct snd_soc_card *card = rtd->card;
>         struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
>
> +       /*
> +        * On this platform for PCM device we support stereo
> +        */
> +
> +       runtime->hw.channels_max = DUAL_CHANNEL;
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +                                  &constraints_channels);
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +                                  &constraints_rates);
> +
>         machine->i2s_instance = I2S_BT_INSTANCE;
>         return da7219_clk_enable(substream);
>  }
>
>  static int cz_dmic1_startup(struct snd_pcm_substream *substream)
>  {
> +       struct snd_pcm_runtime *runtime = substream->runtime;
>         struct snd_soc_pcm_runtime *rtd = substream->private_data;
>         struct snd_soc_card *card = rtd->card;
>         struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
>
> +       /*
> +        * On this platform for PCM device we support stereo
> +        */
> +
> +       runtime->hw.channels_max = DUAL_CHANNEL;
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
> +                                  &constraints_channels);
> +       snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
> +                                  &constraints_rates);
> +
>         machine->i2s_instance = I2S_SP_INSTANCE;
>         machine->capture_channel = CAP_CHANNEL0;
>         return da7219_clk_enable(substream);
> --
> 1.9.1
>
