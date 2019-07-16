From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v4 2/5] drm: bridge: dw-hdmi: Report connector status
 using callback
Date: Tue, 16 Jul 2019 22:12:35 +0800
Message-ID: <CA+Px+wWuCBvWra8+=szQOrvr3iv2YPMeoHHVtJ1vmaZWEEQ44A@mail.gmail.com>
References: <20190716115725.66558-1-cychiang@chromium.org> <20190716115725.66558-3-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190716115725.66558-3-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>, dgreid@chromium.org, tzungbi@chromium.org, ALSA development <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 16, 2019 at 7:57 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> Change the Kconfig of DRM_DW_HDMI so it selects SND_SOC_HDMI_CODEC.
> This is for the typedef of hdmi_codec_plugged_cb to be used in dw-hdmi.c.
Not sure why you select SND_SOC_HDMI_CODEC in this patch.  To have
definition of hdmi_codec_plugged_cb, include hdmi-codec.h should be
sufficient.

>
> diff --git a/drivers/gpu/drm/bridge/synopsys/Kconfig b/drivers/gpu/drm/bridge/synopsys/Kconfig
> index 21a1be3ced0f..309da052db97 100644
> --- a/drivers/gpu/drm/bridge/synopsys/Kconfig
> +++ b/drivers/gpu/drm/bridge/synopsys/Kconfig
> @@ -4,6 +4,7 @@ config DRM_DW_HDMI
>         select DRM_KMS_HELPER
>         select REGMAP_MMIO
>         select CEC_CORE if CEC_NOTIFIER
> +       select SND_SOC_HDMI_CODEC
So that it is weird to select this option.

>
>  config DRM_DW_HDMI_AHB_AUDIO
>         tristate "Synopsys Designware AHB Audio interface"
> @@ -20,7 +21,6 @@ config DRM_DW_HDMI_I2S_AUDIO
>         tristate "Synopsys Designware I2S Audio interface"
>         depends on SND_SOC
>         depends on DRM_DW_HDMI
> -       select SND_SOC_HDMI_CODEC
Also strange for deselecting the option.  Should be in another commit
for another reason?
