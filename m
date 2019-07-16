From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v4 4/5] ASoC: rockchip_max98090: Add dai_link for HDMI
Date: Tue, 16 Jul 2019 22:14:36 +0800
Message-ID: <CA+Px+wV6RSfv4GL8+EJzXGq2nqzKtH9p23VTo2s30h0To2rQtg@mail.gmail.com>
References: <20190716115725.66558-1-cychiang@chromium.org> <20190716115725.66558-5-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190716115725.66558-5-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>, dgreid@chromium.org, tzungbi@chromium.org, ALSA development <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 16, 2019 at 7:58 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
>
> diff --git a/sound/soc/rockchip/Kconfig b/sound/soc/rockchip/Kconfig
> index b43657e6e655..d610b553ea3b 100644
> --- a/sound/soc/rockchip/Kconfig
> +++ b/sound/soc/rockchip/Kconfig
> @@ -40,9 +40,10 @@ config SND_SOC_ROCKCHIP_MAX98090
>         select SND_SOC_ROCKCHIP_I2S
>         select SND_SOC_MAX98090
>         select SND_SOC_TS3A227E
> +       select SND_SOC_HDMI_CODEC
>         help
>           Say Y or M here if you want to add support for SoC audio on Rockchip
> -         boards using the MAX98090 codec, such as Veyron.
> +         boards using the MAX98090 codec and HDMI codec, such as Veyron.
You should not need to select the option in this patch (but in next
patch), because this patch does not depend on anything from
hdmi-codec.c.
