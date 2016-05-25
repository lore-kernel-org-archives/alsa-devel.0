From: Rob Herring <robh@kernel.org>
Subject: Re: [RESEND PATCH v2] ASoC: rockchip: Add machine driver for
 MAX98357A/RT5514/DA7219
Date: Wed, 25 May 2016 12:32:46 -0500
Message-ID: <20160525173246.GA5125@rob-hp-laptop>
References: <1464053774-15914-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464053774-15914-1-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, dianders@chromium.org, heiko@sntech.de, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 24, 2016 at 09:36:14AM +0800, Xing Zheng wrote:
> There are multi codec devices on the RK3399 platform, we can use
> this patch support and control these codecs.
> 
> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> ---
> 
> Changes in v2:
> - use the FS 256 to set mclks of the max98357a and rt5514 danamically
> - add more sample rate for da7219
> 
>  .../sound/rockchip-max98357a-rt5514-da7219.txt     |   15 +
>  sound/soc/rockchip/Kconfig                         |   11 +
>  sound/soc/rockchip/Makefile                        |    2 +
>  .../rockchip/rockchip_max98357a_rt5514_da7219.c    |  333 ++++++++++++++++++++
>  4 files changed, 361 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt
>  create mode 100644 sound/soc/rockchip/rockchip_max98357a_rt5514_da7219.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt b/Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt
> new file mode 100644
> index 0000000..5928384
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip-max98357a-rt5514-da7219.txt
> @@ -0,0 +1,15 @@
> +ROCKCHIP with MAX98357A/RT5514/DA7219 codecs
> +
> +Required properties:
> +- compatible: "rockchip,rockchip-sound"

This is generic, but the binding seems to be very specific to only 3 
specific codecs. Listing all 3 codecs seems a bit strange. Perhaps a 
name related to the board name would be better.

> +- rockchip,cpu: The phandle of the Rockchip I2S controller that's
> +  connected to the codecs

What's the size? always 3?

> +- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs

Please make the size and ordering clear.

> +
> +Example:
> +
> +sound {
> +	compatible = "rockchip,rockchip-sound";
> +	rockchip,cpu = <&i2s0 &i2s0 &i2s1>;
> +	rockchip,codec = <&max98357a &headsetcodec &codec>;
> +};
