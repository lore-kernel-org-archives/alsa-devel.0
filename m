From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v3 5/5] FROMLIST: ASoC: rockchip_max98090: Add HDMI jack support
Date: Fri, 12 Jul 2019 18:38:14 +0800
Message-ID: <CAFv8NwKOhAz4B1da5MarXkVfavya6AYsvURa1Tq4LW=_nyZjiw@mail.gmail.com>
References: <20190712100443.221322-1-cychiang@chromium.org> <20190712100443.221322-6-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190712100443.221322-6-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 12, 2019 at 6:06 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> In machine driver, create a jack and let hdmi-codec report jack status.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  sound/soc/rockchip/rockchip_max98090.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
> index c82948e383da..c81c4acda917 100644
> --- a/sound/soc/rockchip/rockchip_max98090.c
> +++ b/sound/soc/rockchip/rockchip_max98090.c
> @@ -134,6 +134,25 @@ enum {
>         DAILINK_HDMI,
>  };
>
> +static struct snd_soc_jack rk_hdmi_jack;
> +
> +static int rk_hdmi_init(struct snd_soc_pcm_runtime *runtime)
> +{
> +       struct snd_soc_card *card = runtime->card;
> +       struct snd_soc_component *component = runtime->codec_dai->component;
> +       int ret;
> +
> +       /* enable jack detection */
> +       ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
> +                                   &rk_hdmi_jack, NULL, 0);
> +       if (ret) {
> +               dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
> +               return ret;
> +       }
> +
> +       return hdmi_codec_set_jack_detect(component, &rk_hdmi_jack);
> +}
> +
>  /* max98090 and HDMI codec dai_link */
>  static struct snd_soc_dai_link rk_dailinks[] = {
>         [DAILINK_MAX98090] = {
> @@ -151,6 +170,7 @@ static struct snd_soc_dai_link rk_dailinks[] = {
>                 .ops = &rk_aif1_ops,
>                 .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
>                         SND_SOC_DAIFMT_CBS_CFS,
> +               .init = rk_hdmi_init,
>                 SND_SOC_DAILINK_REG(hdmi),
>         }
>  };
> --
> 2.22.0.510.g264f2c817a-goog
>

Sorry for the wrong title.
I forgot to remove FROMLIST in the title.
I'll wait for comments on other patches and fix the title in v4.
Thanks!
