From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 3/4] ASoC: rockchip_max98090: Add dai_link for HDMI
Date: Sat, 6 Jul 2019 17:58:52 +0800
Message-ID: <CAFv8NwKBA_=R2YsgU+dvr_G5fUCNiVL-TOKL=26rK2m_qbrcbw@mail.gmail.com>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-4-cychiang@chromium.org>
 <CA+Px+wXVghbk8k0WE5TEsGRQXx26K0-=h3O7cje-F1phwBGrbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+Px+wXVghbk8k0WE5TEsGRQXx26K0-=h3O7cje-F1phwBGrbQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>, tzungbi@chromium.org, linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Andrzej Hajda <a.hajda@samsung.com>, Russell King <rmk+kernel@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, linux-rockchip@lists.infradead.org, Dylan Reid <dgreid@chromium.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 5, 2019 at 3:10 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> > diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
> > index c5fc24675a33..195309d1225a 100644
> > --- a/sound/soc/rockchip/rockchip_max98090.c
> > +++ b/sound/soc/rockchip/rockchip_max98090.c
> >  static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
> > @@ -92,38 +95,59 @@ static int rk_aif1_hw_params(struct snd_pcm_substream *substream,
> >
> >         ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
> >                                      SND_SOC_CLOCK_OUT);
> > -       if (ret < 0) {
> > -               dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
> > +       if (ret && ret != -ENOTSUPP) {
> > +               dev_err(cpu_dai->dev, "Can't set cpu dai clock %d\n", ret);
I should remove this change because cpu dai should support sysclk ops.

> >                 return ret;
> >         }
> >
> >         ret = snd_soc_dai_set_sysclk(codec_dai, 0, mclk,
> >                                      SND_SOC_CLOCK_IN);
> > -       if (ret < 0) {
> > -               dev_err(codec_dai->dev, "Can't set codec clock %d\n", ret);
> > +       if (ret && ret != -ENOTSUPP) {
> > +               dev_err(codec_dai->dev, "Can't set codec dai clock %d\n", ret);
> >                 return ret;
> >         }
> Does it imply: it is acceptable even if they are "not supported"?
Thank you for this good catch.
Here machine driver has the knowledge of deciding whether it is
expected to see the ops is not supported.
For HDMI path using hdmi-codec driver, it is expected to see -ENOTSUPP.
But it is not expected for codec DAI of max98090.
I should distinguish them.

>
>
> >
> > -       return ret;
> > +       return 0;
> >  }
> >
> >  static const struct snd_soc_ops rk_aif1_ops = {
> >         .hw_params = rk_aif1_hw_params,
> >  };
> >
> > -SND_SOC_DAILINK_DEFS(hifi,
> > +SND_SOC_DAILINK_DEFS(analog,
> >         DAILINK_COMP_ARRAY(COMP_EMPTY()),
> >         DAILINK_COMP_ARRAY(COMP_CODEC(NULL, "HiFi")),
> >         DAILINK_COMP_ARRAY(COMP_EMPTY()));
> >
> > -static struct snd_soc_dai_link rk_dailink = {
> > -       .name = "max98090",
> > -       .stream_name = "Audio",
> > -       .ops = &rk_aif1_ops,
> > -       /* set max98090 as slave */
> > -       .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > -               SND_SOC_DAIFMT_CBS_CFS,
> > -       SND_SOC_DAILINK_REG(hifi),
> > +SND_SOC_DAILINK_DEFS(hdmi,
> > +       DAILINK_COMP_ARRAY(COMP_EMPTY()),
> > +       DAILINK_COMP_ARRAY(COMP_CODEC("hdmi-audio-codec.3.auto", "i2s-hifi")),
> > +       DAILINK_COMP_ARRAY(COMP_EMPTY()));
> > +
> > +enum {
> > +       DAILINK_MAX98090,
> > +       DAILINK_HDMI,
> > +};
> > +
> > +/* max98090 and HDMI codec dai_link */
> > +static struct snd_soc_dai_link rk_dailinks[] = {
> > +       [DAILINK_MAX98090] = {
> > +               .name = "max98090",
> > +               .stream_name = "Analog",
> > +               .ops = &rk_aif1_ops,
> > +               /* set max98090 as slave */
> > +               .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > +                       SND_SOC_DAIFMT_CBS_CFS,
> > +               SND_SOC_DAILINK_REG(analog),
> > +       },
> > +       [DAILINK_HDMI] = {
> > +               .name = "HDMI",
> > +               .stream_name = "HDMI",
> > +               .ops = &rk_aif1_ops,
> > +               .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> > +                       SND_SOC_DAIFMT_CBS_CFS,
> > +               SND_SOC_DAILINK_REG(hdmi),
> > +       }
> >  };
> >
> >  static int rk_98090_headset_init(struct snd_soc_component *component);
> > @@ -136,8 +160,8 @@ static struct snd_soc_aux_dev rk_98090_headset_dev = {
> >  static struct snd_soc_card snd_soc_card_rk = {
> >         .name = "ROCKCHIP-I2S",
> >         .owner = THIS_MODULE,
> > -       .dai_link = &rk_dailink,
> > -       .num_links = 1,
> > +       .dai_link = rk_dailinks,
> > +       .num_links = ARRAY_SIZE(rk_dailinks),
> >         .aux_dev = &rk_98090_headset_dev,
> >         .num_aux_devs = 1,
> >         .dapm_widgets = rk_dapm_widgets,
> > @@ -173,27 +197,48 @@ static int snd_rk_mc_probe(struct platform_device *pdev)
> >         int ret = 0;
> >         struct snd_soc_card *card = &snd_soc_card_rk;
> >         struct device_node *np = pdev->dev.of_node;
> > +       struct device_node *np_analog;
> > +       struct device_node *np_cpu;
> > +       struct of_phandle_args args;
> >
> >         /* register the soc card */
> >         card->dev = &pdev->dev;
> >
> > -       rk_dailink.codecs->of_node = of_parse_phandle(np,
> > -                       "rockchip,audio-codec", 0);
> > -       if (!rk_dailink.codecs->of_node) {
> > +       np_analog = of_parse_phandle(np, "rockchip,audio-codec", 0);
> > +       if (!np_analog) {
> >                 dev_err(&pdev->dev,
> >                         "Property 'rockchip,audio-codec' missing or invalid\n");
> >                 return -EINVAL;
> >         }
> > +       rk_dailinks[DAILINK_MAX98090].codecs->of_node = np_analog;
> > +
> > +       ret = of_parse_phandle_with_fixed_args(np, "rockchip,audio-codec",
> > +                                              0, 0, &args);
> > +       if (ret) {
> > +               dev_err(&pdev->dev,
> > +                       "Unable to parse property 'rockchip,audio-codec'\n");
> > +               return ret;
> > +       }
> > +
> > +       ret = snd_soc_get_dai_name(
> > +                       &args, &rk_dailinks[DAILINK_MAX98090].codecs->dai_name);
> > +       if (ret) {
> > +               dev_err(&pdev->dev, "Unable to get codec dai_name\n");
> > +               return ret;
> > +       }
> > +
> > +       np_cpu = of_parse_phandle(np, "rockchip,i2s-controller", 0);
> >
> > -       rk_dailink.cpus->of_node = of_parse_phandle(np,
> > -                       "rockchip,i2s-controller", 0);
> > -       if (!rk_dailink.cpus->of_node) {
> > +       if (!np_cpu) {
> >                 dev_err(&pdev->dev,
> >                         "Property 'rockchip,i2s-controller' missing or invalid\n");
> >                 return -EINVAL;
> >         }
> >
> > -       rk_dailink.platforms->of_node = rk_dailink.cpus->of_node;
> > +       rk_dailinks[DAILINK_MAX98090].cpus->of_node = np_cpu;
> > +       rk_dailinks[DAILINK_MAX98090].platforms->of_node = np_cpu;
> > +       rk_dailinks[DAILINK_HDMI].cpus->of_node = np_cpu;
> > +       rk_dailinks[DAILINK_HDMI].platforms->of_node = np_cpu;
> >
> >         rk_98090_headset_dev.codec_of_node = of_parse_phandle(np,
> >                         "rockchip,headset-codec", 0);
> > --
> > 2.22.0.410.gd8fdbe21b5-goog
> >
