From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 5/7] ASoC: rockchip: rockchip-max98090: Add node for HDMI
Date: Tue, 9 Jul 2019 14:01:21 -0600
Message-ID: <20190709200121.GA19118@bogus>
References: <20190603043251.226549-1-cychiang@chromium.org>
 <20190603043251.226549-6-cychiang@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190603043251.226549-6-cychiang@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org, dgreid@chromium.org, tzungbi@chromium.org, linux-media@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.inf
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 03, 2019 at 12:32:49PM +0800, Cheng-Yi Chiang wrote:
> Let user specify HDMI node so machine driver can use it to let codec
> driver register callback on correct hdmi-notifier.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  Documentation/devicetree/bindings/sound/rockchip-max98090.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
> index a805aa99ad75..dae57c14864e 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
> +++ b/Documentation/devicetree/bindings/sound/rockchip-max98090.txt
> @@ -7,6 +7,7 @@ Required properties:
>    connected to the CODEC
>  - rockchip,audio-codec: The phandle of the MAX98090 audio codec
>  - rockchip,headset-codec: The phandle of Ext chip for jack detection
> +- rockchip,hdmi: The phandle of HDMI node for HDMI jack detection
>  
>  Example:
>  
> @@ -16,4 +17,5 @@ sound {
>  	rockchip,i2s-controller = <&i2s>;
>  	rockchip,audio-codec = <&max98090>;
>  	rockchip,headset-codec = <&headsetcodec>;
> +	rockchip,hdmi= <&hdmi>;

space                ^

With that,

Acked-by: Rob Herring <robh@kernel.org>

>  };
> -- 
> 2.22.0.rc1.257.g3120a18244-goog
> 
