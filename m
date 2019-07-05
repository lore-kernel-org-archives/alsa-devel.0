From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set callback function
 for plug event
Date: Fri, 5 Jul 2019 15:08:37 +0800
Message-ID: <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
References: <20190705042623.129541-1-cychiang@chromium.org> <20190705042623.129541-2-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190705042623.129541-2-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, ALSA development <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> index 7fea496f1f34..26c02abb8eba 100644
> --- a/include/sound/hdmi-codec.h
> +++ b/include/sound/hdmi-codec.h
> @@ -47,6 +47,9 @@ struct hdmi_codec_params {
>         int channels;
>  };
>
> +typedef void (*hdmi_codec_plugged_cb)(struct platform_device *dev,
> +                                     bool plugged);
> +
The callback prototype is "weird" by struct platform_device.  Is it
possible to having snd_soc_component instead of platform_device?

>  struct hdmi_codec_pdata;
>  struct hdmi_codec_ops {
>         /*
> @@ -88,6 +91,13 @@ struct hdmi_codec_ops {
>          */
>         int (*get_dai_id)(struct snd_soc_component *comment,
>                           struct device_node *endpoint);
> +
> +       /*
> +        * Hook callback function to handle connector plug event.
> +        * Optional
> +        */
> +       int (*hook_plugged_cb)(struct device *dev, void *data,
> +                              hdmi_codec_plugged_cb fn);
>  };
The first parameter dev could be removed.  Not used.
