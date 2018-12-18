From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: sdm845: set jack only for a specific backend
Date: Tue, 18 Dec 2018 15:50:49 +0800
Message-ID: <CAFv8Nw+Ydjbob2z5=eVpL8-OpVSPyDVkCLnPTu_asuwK3rCgmw@mail.gmail.com>
References: <1544781703-9585-1-git-send-email-rohitkr@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544781703-9585-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: plai@codeaurora.org, bgoswami@codeaurora.org, asishb@codeaurora.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Rohit Kumar <rohkumar@qti.qualcomm.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 14, 2018 at 6:02 PM Rohit kumar <rohitkr@codeaurora.org> wrote:
>
> Headset codec is connected over PRIMARY_MI2S interface. Call
> set_jack for codec associated with Primary Mi2s interface.
> Also, set_jack to NULL when jack is freed.
>
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>  sound/soc/qcom/sdm845.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
> index 1db8ef66..6f66a58 100644
> --- a/sound/soc/qcom/sdm845.c
> +++ b/sound/soc/qcom/sdm845.c
> @@ -158,17 +158,24 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
>         return ret;
>  }
>
> +static void sdm845_jack_free(struct snd_jack *jack)
> +{
> +       struct snd_soc_component *component = jack->private_data;
> +
> +       snd_soc_component_set_jack(component, NULL, NULL);
> +}
> +
>  static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
>  {
>         struct snd_soc_component *component;
> -       struct snd_soc_dai_link *dai_link = rtd->dai_link;
>         struct snd_soc_card *card = rtd->card;
> +       struct snd_soc_dai *codec_dai = rtd->codec_dai;
> +       struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
>         struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
> -       int i, rval;
> +       struct snd_jack *jack;
> +       int rval;
>
>         if (!pdata->jack_setup) {
> -               struct snd_jack *jack;
> -
>                 rval = snd_soc_card_jack_new(card, "Headset Jack",
>                                 SND_JACK_HEADSET |
>                                 SND_JACK_HEADPHONE |
> @@ -190,16 +197,22 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
>                 pdata->jack_setup = true;
>         }
>
> -       for (i = 0 ; i < dai_link->num_codecs; i++) {
> -               struct snd_soc_dai *dai = rtd->codec_dais[i];
> +       switch (cpu_dai->id) {
> +       case PRIMARY_MI2S_RX:
> +               jack  = pdata->jack.jack;
> +               component = codec_dai->component;
>
> -               component = dai->component;
> -               rval = snd_soc_component_set_jack(
> -                               component, &pdata->jack, NULL);
> +               jack->private_data = component;
> +               jack->private_free = sdm845_jack_free;
> +               rval = snd_soc_component_set_jack(component,
> +                                                 &pdata->jack, NULL);
>                 if (rval != 0 && rval != -ENOTSUPP) {
>                         dev_warn(card->dev, "Failed to set jack: %d\n", rval);
>                         return rval;
>                 }
> +               break;
> +       default:
> +               break;
>         }
>
>         return 0;
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

Thanks a lot for the fix!

Reviewed-by: Cheng-Yi Chiang <cychiang@chromium.org>
Tested-by: Cheng-Yi Chiang <cychiang@chromium.org>
