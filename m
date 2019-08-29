From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm: dw-hdmi-i2s: enable audio clock in audio_startup
Date: Thu, 29 Aug 2019 15:16:36 -0700
Message-ID: <CAD=FV=Xb_SkUTkVRpOX7B+B0AdT3cOB+JamNyXzq_UQK3mvz1A@mail.gmail.com>
References: <20190829042957.150929-1-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190829042957.150929-1-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, kuninori.morimoto.gx@renesas.com, Sam Ravnborg <sam@ravnborg.org>, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, =?UTF-8?B?6YOR5YW0?= <zhengxing@rock-chips.com>, =?UTF-8?B?6JSh6Im65Lyf?= <cain.cai@rock-chips.com>, Eddie Cai <eddie.cai@rock-chips.com>, =?UTF-8?B?6ZmI5riQ6aOe?= <jeffy.chen@rock-chips.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, dri-devel <dri-devel@lists.fre>
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Aug 28, 2019 at 9:30 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> In the designware databook, the sequence of enabling audio clock and
> setting format is not clearly specified.
> Currently, audio clock is enabled in the end of hw_param ops after
> setting format.
>
> On some monitors, there is a possibility that audio does not come out.
> Fix this by enabling audio clock in audio_startup ops
> before hw_param ops setting format.
>
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> index 5cbb71a866d5..08b4adbb1ddc 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-i2s-audio.c
> @@ -69,6 +69,14 @@ static int dw_hdmi_i2s_hw_params(struct device *dev, void *data,
>         hdmi_write(audio, conf0, HDMI_AUD_CONF0);
>         hdmi_write(audio, conf1, HDMI_AUD_CONF1);
>
> +       return 0;
> +}
> +
> +static int dw_hdmi_i2s_audio_startup(struct device *dev, void *data)
> +{
> +       struct dw_hdmi_i2s_audio_data *audio = data;
> +       struct dw_hdmi *hdmi = audio->hdmi;
> +
>         dw_hdmi_audio_enable(hdmi);
>
>         return 0;
> @@ -105,6 +113,7 @@ static int dw_hdmi_i2s_get_dai_id(struct snd_soc_component *component,
>  }
>
>  static struct hdmi_codec_ops dw_hdmi_i2s_ops = {
> +       .audio_startup = dw_hdmi_i2s_audio_startup,
>         .hw_params      = dw_hdmi_i2s_hw_params,
>         .audio_shutdown = dw_hdmi_i2s_audio_shutdown,
>         .get_dai_id     = dw_hdmi_i2s_get_dai_id,
> --

I am no expert on audio stuff, but this seems sane to me.  If you
happened to spin it for another reason, it might seem slightly nicer
to put the setting of ".audio_startup" adjacent to the setting of
".audio_shutdown" in the struct.

I have tested your patch on Chrome OS 4.19 and it definitely fixes the
problems I saw.  Chrome OS 4.19 is a little different than upstream
and I'm not setup to test HDMI audio directly on upstream, but I did
at least confirm that my problem _wasn't_ magically fixed by any of
these patches that I found upstream (I picked them into my tree and
still saw the problem):

fc1ca6e01d0a drm/bridge: dw-hdmi-i2s: add .get_eld support
43e88f670a5e drm/bridge: dw-hdmi-i2s: enable only the required i2s lanes
46cecde310bb drm/bridge: dw-hdmi-i2s: reset audio fifo before applying
new params
0c6098859176 drm/bridge: dw-hdmi-i2s: set the channel allocation
17a1e555b608 drm/bridge: dw-hdmi-i2s: enable lpcm multi channels
da5f5bc92f49 drm/bridge: dw-hdmi: set channel count in the infoframes
2a2a3d2ff799 drm/bridge: dw-hdmi: move audio channel setup out of ahb
8067f62bccaf drm/bridge: dw-hdmi-i2s: support more i2s format

Thus:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Douglas Anderson <dianders@chromium.org>

-Doug
