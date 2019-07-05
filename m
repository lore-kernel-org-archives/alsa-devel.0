From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH 2/4] drm: bridge: dw-hdmi: Report connector
 status using callback
Date: Fri, 5 Jul 2019 15:31:24 +0800
Message-ID: <CAFv8NwJXbJo=z_NDj+JQHD9LOmnbfM8v_N1uHn4sdBzF-FZQfA@mail.gmail.com>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-3-cychiang@chromium.org> <VI1PR06MB41425D1F24AC653F08AFA463ACF50@VI1PR06MB4142.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR06MB41425D1F24AC653F08AFA463ACF50@VI1PR06MB4142.eurprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Karlman <jonas@kwiboo.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "dianders@chromium.org" <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, David Airlie <airlied@linux.ie>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "tzungbi@chromium.org" <tzungbi@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Andrzej Hajda <a.hajda@samsung.com>, Russell King <rmk+kernel@armlinux.org.uk>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, "dgreid@chromium.org" <dg>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 5, 2019 at 1:45 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2019-07-05 06:26, Cheng-Yi Chiang wrote:
> > Allow codec driver register callback function for plug event.
> >
> > The callback registration flow:
> > dw-hdmi <--- hw-hdmi-i2s-audio <--- hdmi-codec
> >
> > dw-hdmi-i2s-audio implements hook_plugged_cb op
> > so codec driver can register the callback.
> >
> > dw-hdmi implements set_plugged_cb op so platform device can register the
> > callback.
> >
> > When connector plug/unplug event happens, report this event using the
> > callback.
> >
> > Make sure that audio and drm are using the single source of truth for
> > connector status.
>
> I have a similar notification need for making a snd_ctl_notify() call from hdmi-codec when ELD changes,
> see [1] for work in progress patches (part of a dw-hdmi multi-channel lpcm series I am preparing).
>
> Any suggestions on how to handle a ELD change notification?
> Should I use a similar pattern as in this series?

Hi Jonas, I think we are using a very similar pattern.
The difference is that in my series the function is not exposed on hdmi-codec.h.
I think your method makes sense for your case because
dw-hdmi-i2s-audio.c needs to access and update data inside
dw_hdmi_i2s_audio_data,
while in my use case it is only a thin layer setting up the callback
for jack status.

> (I lost track of the hdmi-notifier/drm_audio_component discussion)
>

It was a long discussion.
I think the conclusion was that if we are only talking about
hdmi-codec, then we just need to extend the ops exposed in hdmi-codec
and don't need to use
hdmi-notifier or drm_audio_component.

> [1] https://github.com/Kwiboo/linux-rockchip/compare/54b40fdd264c7ed96017271eb6524cca4ff755ab...9c17284e8a8657e8b1da53a1c7ff056cbd8ce43c
>
> Best regards,
> Jonas
>
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  .../gpu/drm/bridge/synopsys/dw-hdmi-audio.h   |  3 ++
> >  .../drm/bridge/synopsys/dw-hdmi-i2s-audio.c   | 10 ++++++
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 34 ++++++++++++++++++-
> >  3 files changed, 46 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> > index 63b5756f463b..f523c590984e 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-audio.h
> > @@ -2,6 +2,8 @@
> >  #ifndef DW_HDMI_AUDIO_H
> >  #define DW_HDMI_AUDIO_H
> >
> > +#include <sound/hdmi-codec.h>
> > +
> >  struct dw_hdmi;
> >
> >  struct dw_hdmi_audio_data {
> > @@ -17,6 +19,7 @@ struct dw_hdmi_i2s_audio_data {
> >
> >       void (*write)(struct dw_hdmi *hdmi, u8 val, int offset);
> >       u8 (*read)(struct dw_hdmi *hdmi, int offset);
> > +     int (*set_plugged_cb)(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn);
> >  };
> >
> >  #endif
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > index 5cbb71a866d5..7b93cf05c985 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > @@ -104,10 +104,20 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
> >       return -EINVAL;
> >  }
> >
> > +static int dw_hdmi_i2s_hook_plugged_cb(struct device *dev, void *data,
> > +                                    hdmi_codec_plugged_cb fn)
> > +{
> > +     struct dw_hdmi_i2s_audio_data *audio = data;
> > +     struct dw_hdmi *hdmi = audio->hdmi;
> > +
> > +     return audio->set_plugged_cb(hdmi, fn);
> > +}
> > +
> >  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
> >       .hw_params      = dw_hdmi_i2s_hw_params,
> >       .audio_shutdown = dw_hdmi_i2s_audio_shutdown,
> >       .get_dai_id     = dw_hdmi_i2s_get_dai_id,
> > +     .hook_plugged_cb = dw_hdmi_i2s_hook_plugged_cb,
> >  };
> >
> >  static int snd_dw_hdmi_probe(struct platform_device *pdev)
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index 045b1b13fd0e..c69a399fc7ca 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -26,6 +26,8 @@
> >  #include <drm/drm_probe_helper.h>
> >  #include <drm/bridge/dw_hdmi.h>
> >
> > +#include <sound/hdmi-codec.h>
> > +
> >  #include <uapi/linux/media-bus-format.h>
> >  #include <uapi/linux/videodev2.h>
> >
> > @@ -185,6 +187,9 @@ struct dw_hdmi {
> >       void (*disable_audio)(struct dw_hdmi *hdmi);
> >
> >       struct cec_notifier *cec_notifier;
> > +
> > +     hdmi_codec_plugged_cb plugged_cb;
> > +     enum drm_connector_status last_connector_result;
> >  };
> >
> >  #define HDMI_IH_PHY_STAT0_RX_SENSE \
> > @@ -209,6 +214,17 @@ static inline u8 hdmi_readb(struct dw_hdmi *hdmi, int offset)
> >       return val;
> >  }
> >
> > +static int hdmi_set_plugged_cb(struct dw_hdmi *hdmi, hdmi_codec_plugged_cb fn)
> > +{
> > +     mutex_lock(&hdmi->mutex);
> > +     hdmi->plugged_cb = fn;
> > +     if (hdmi->audio && !IS_ERR(hdmi->audio))
> > +             fn(hdmi->audio,
> > +                hdmi->last_connector_result == connector_status_connected);
> > +     mutex_unlock(&hdmi->mutex);
> > +     return 0;
> > +}
> > +
> >  static void hdmi_modb(struct dw_hdmi *hdmi, u8 data, u8 mask, unsigned reg)
> >  {
> >       regmap_update_bits(hdmi->regm, reg << hdmi->reg_shift, mask, data);
> > @@ -2044,6 +2060,7 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
> >  {
> >       struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
> >                                            connector);
> > +     enum drm_connector_status result;
> >
> >       mutex_lock(&hdmi->mutex);
> >       hdmi->force = DRM_FORCE_UNSPECIFIED;
> > @@ -2051,7 +2068,20 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
> >       dw_hdmi_update_phy_mask(hdmi);
> >       mutex_unlock(&hdmi->mutex);
> >
> > -     return hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> > +     result = hdmi->phy.ops->read_hpd(hdmi, hdmi->phy.data);
> > +
> > +     mutex_lock(&hdmi->mutex);
> > +     if (result != hdmi->last_connector_result) {
> > +             dev_dbg(hdmi->dev, "read_hpd result: %d", result);
> > +             if (hdmi->plugged_cb && hdmi->audio && !IS_ERR(hdmi->audio)) {
> > +                     hdmi->plugged_cb(hdmi->audio,
> > +                                      result == connector_status_connected);
> > +                     hdmi->last_connector_result = result;
> > +             }
> > +     }
> > +     mutex_unlock(&hdmi->mutex);
> > +
> > +     return result;
> >  }
> >
> >  static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
> > @@ -2460,6 +2490,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
> >       hdmi->rxsense = true;
> >       hdmi->phy_mask = (u8)~(HDMI_PHY_HPD | HDMI_PHY_RX_SENSE);
> >       hdmi->mc_clkdis = 0x7f;
> > +     hdmi->last_connector_result = connector_status_disconnected;
> >
> >       mutex_init(&hdmi->mutex);
> >       mutex_init(&hdmi->audio_mutex);
> > @@ -2653,6 +2684,7 @@ __dw_hdmi_probe(struct platform_device *pdev,
> >               audio.hdmi      = hdmi;
> >               audio.write     = hdmi_writeb;
> >               audio.read      = hdmi_readb;
> > +             audio.set_plugged_cb = hdmi_set_plugged_cb;
> >               hdmi->enable_audio = dw_hdmi_i2s_audio_enable;
> >               hdmi->disable_audio = dw_hdmi_i2s_audio_disable;
> >
>
