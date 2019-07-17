From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v4 5/5] ASoC: rockchip_max98090: Add HDMI jack support
Date: Wed, 17 Jul 2019 16:13:35 +0800
Message-ID: <CAFv8NwKJ4SEbN34EyS7wA33z9+bCCM2mzQRUBfDLr9Vg5CP9jQ@mail.gmail.com>
References: <20190716115725.66558-1-cychiang@chromium.org> <20190716115725.66558-6-cychiang@chromium.org>
 <CA+Px+wXK9gJKZwzsG8BXh1gmoEyscxtMzB_VCrHz-nenBEL9AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+Px+wXK9gJKZwzsG8BXh1gmoEyscxtMzB_VCrHz-nenBEL9AQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, ALSA development <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 16, 2019 at 10:16 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Tue, Jul 16, 2019 at 7:58 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
> > index c82948e383da..c81c4acda917 100644
> > --- a/sound/soc/rockchip/rockchip_max98090.c
> > +++ b/sound/soc/rockchip/rockchip_max98090.c
> > +static struct snd_soc_jack rk_hdmi_jack;
> > +
> > +static int rk_hdmi_init(struct snd_soc_pcm_runtime *runtime)
> > +{
> > +       struct snd_soc_card *card = runtime->card;
> > +       struct snd_soc_component *component = runtime->codec_dai->component;
> > +       int ret;
> > +
> > +       /* enable jack detection */
> > +       ret = snd_soc_card_jack_new(card, "HDMI Jack", SND_JACK_LINEOUT,
> > +                                   &rk_hdmi_jack, NULL, 0);
> > +       if (ret) {
> > +               dev_err(card->dev, "Can't new HDMI Jack %d\n", ret);
> > +               return ret;
> > +       }
> > +
> > +       return hdmi_codec_set_jack_detect(component, &rk_hdmi_jack);
> > +}
> In the patch, you should select SND_SOC_HDMI_CODEC, because the patch
> uses hdmi_codec_set_jack_detect which depends on hdmi-codec.c.
Thanks! I'll fix in v5.
