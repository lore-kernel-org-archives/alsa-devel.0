From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set callback function
 for plug event
Date: Tue, 9 Jul 2019 19:55:29 +0800
Message-ID: <CAFv8NwLos-XcB9K8315vmmfKn+z0XaBph3QxSwrmqhfYqoju2Q@mail.gmail.com>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-2-cychiang@chromium.org> <3d5755cf-34e9-44f7-3b03-6bdfca84ff95@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3d5755cf-34e9-44f7-3b03-6bdfca84ff95@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 9, 2019 at 7:47 PM Cezary Rojewski
<cezary.rojewski@intel.com> wrote:
>
> On 2019-07-05 06:26, Cheng-Yi Chiang wrote:
> > +static void hdmi_codec_jack_report(struct hdmi_codec_priv *hcp,
> > +                                unsigned int jack_status)
> > +{
> > +     if (!hcp->jack)
> > +             return;
> > +
> > +     if (jack_status != hcp->jack_status) {
> > +             snd_soc_jack_report(hcp->jack, jack_status, SND_JACK_LINEOUT);
> > +             hcp->jack_status = jack_status;
> > +     }
> > +}
>
> Single "if" statement instead? The first "if" does not even cover all
> cases - if the secondary check fails, you'll "return;" too.
>
ACK.
I will fix in v2.
> > +/**
> > + * hdmi_codec_set_jack_detect - register HDMI plugged callback
> > + * @component: the hdmi-codec instance
> > + * @jack: ASoC jack to report (dis)connection events on
> > + */
> > +int hdmi_codec_set_jack_detect(struct snd_soc_component *component,
> > +                            struct snd_soc_jack *jack)
> > +{
> > +     struct hdmi_codec_priv *hcp = snd_soc_component_get_drvdata(component);
> > +     int ret;
> > +
> > +     if (hcp->hcd.ops->hook_plugged_cb) {
> > +             hcp->jack = jack;
> > +             ret = hcp->hcd.ops->hook_plugged_cb(component->dev->parent,
> > +                                                 hcp->hcd.data,
> > +                                                 plugged_cb);
> > +             if (ret) {
> > +                     hcp->jack = NULL;
> > +                     return ret;
> > +             }
> > +             return 0;
> > +     }
> > +     return -EOPNOTSUPP;
> > +}
> > +EXPORT_SYMBOL_GPL(hdmi_codec_set_jack_detect);
>
> int ret = -EOPNOTSUPP;
> (...)
>
> return ret;
>
> In consequence, you can reduce the number of "return(s)" and also remove
> the redundant parenthesis for the if-statement used to set jack to NULL.
>
> Czarek
ACK
will fix in v2.

Thanks a lot for the review!
