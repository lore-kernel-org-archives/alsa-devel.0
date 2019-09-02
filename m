From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH] drm: dw-hdmi-i2s: enable audio clock in audio_startup
Date: Mon, 2 Sep 2019 10:06:55 +0800
Message-ID: <CAFv8NwLq-cJqj0MB=rzKuqr3g0n3Y-nHor4w8ntiFXytoHpdLw@mail.gmail.com>
References: <20190829042957.150929-1-cychiang@chromium.org> <HE1PR06MB4011FA45247F186BB83DFF04ACBF0@HE1PR06MB4011.eurprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <HE1PR06MB4011FA45247F186BB83DFF04ACBF0@HE1PR06MB4011.eurprd06.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonas Karlman <jonas@kwiboo.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tzungbi@chromium.org" <tzungbi@chromium.org>, "zhengxing@rock-chips.com" <zhengxing@rock-chips.com>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "a.hajda@samsung.com" <a.hajda@samsung.com>, "airlied@linux.ie" <airlied@linux.ie>, "jeffy.chen@rock-chips.com" <jeffy.chen@rock-chips.com>, "dianders@chromium.org" <dianders@chromium.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "cain.cai@rock-chips.com" <cain.cai@rock-chips.com>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, "eddie.cai@rock-chips.com" <eddie.cai@rock-chips.com>, Laurent.pinchart@ideasonboard.com
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 1, 2019 at 6:04 PM Jonas Karlman <jonas@kwiboo.se> wrote:
>
> On 2019-08-29 06:29, Cheng-Yi Chiang wrote:
> > In the designware databook, the sequence of enabling audio clock and
> > setting format is not clearly specified.
> > Currently, audio clock is enabled in the end of hw_param ops after
> > setting format.
> >
> > On some monitors, there is a possibility that audio does not come out.
> > Fix this by enabling audio clock in audio_startup ops
> > before hw_param ops setting format.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > index 5cbb71a866d5..08b4adbb1ddc 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> > @@ -69,6 +69,14 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
> >       hdmi_write(audio, conf0, HDMI_AUD_CONF0);
> >       hdmi_write(audio, conf1, HDMI_AUD_CONF1);
> >
> > +     return 0;
> > +}
> > +
> > +static int dw_hdmi_i2s_audio_startup(struct device *dev, void *data)
> > +{
> > +     struct dw_hdmi_i2s_audio_data *audio = data;
> > +     struct dw_hdmi *hdmi = audio->hdmi;
> > +
> >       dw_hdmi_audio_enable(hdmi);
> >
> >       return 0;
> > @@ -105,6 +113,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
> >  }
> >
> >  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
> > +     .audio_startup = dw_hdmi_i2s_audio_startup,
>
> A small white space nit, there should be a tab and not space to align the equal sign above.

ACK. Will fix in v2.
>
> Also this patch do not cleanly apply to drm-misc-next or linux-next after
> fc1ca6e01d0a "drm/bridge: dw-hdmi-i2s: add .get_eld support" was merged.

ACK. Will rebase in v2.
>
>
>
>
> This patch does fix an issue I have observed on my Rockchip devices where audio would not always
> came out after switching between audio streams having different rate and channels parameters.
> I used to carry [1] to fix that issue, but this seems like a more sane fix.
>
> [1] https://github.com/Kwiboo/linux-rockchip/commit/4862e4044532b8b480fa3a0faddc197586623808
>
> With above fixed,
>
> Reviewed-by: Jonas Karlman <jonas@kwiboo.se>


Thanks a lot!

>
>
> Regards,
> Jonas
>
> >       .hw_params      = dw_hdmi_i2s_hw_params,
> >       .audio_shutdown = dw_hdmi_i2s_audio_shutdown,
> >       .get_dai_id     = dw_hdmi_i2s_get_dai_id,
>
