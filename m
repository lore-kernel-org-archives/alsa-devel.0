From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5] ASoC: rockchip: Add machine driver for RK3399 GRU
 Boards
Date: Tue, 14 Jun 2016 17:38:10 -0500
Message-ID: <20160614223810.GA7925@rob-hp-laptop>
References: <1465807339-1100-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1465807339-1100-1-git-send-email-zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 13, 2016 at 04:42:18PM +0800, Xing Zheng wrote:
> Because we need to support the multiple codecs (MAX98357A/RT5514/DA7219)
> on the RK3399 GRU boards, this patch can help us to support these codecs.
> 
> Signed-off-by: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v5:
> - fix the build warning for missing I2C/CLKDEV_LOOKUP dependency
> 
> Changes in v4:
> - the compatible name needs to be based on a single reference design,
>   and the name of the board is called "GRU"
> - use one i2sX card "rockchip,cpu = <&i2s0>" instead of array that is
>   based on GRU
> - rename DOC to rockchip,rk3399-gru-sound.txt
> - rename compatible to rockchip,rk3399-gru-sound
> - rename source code to rk3399_gru_sound.c
> 
> Changes in v3:
> - rename DOC to rockchip,rk3399-max98357a-rt5514-da7219.txt
> - rename compatible to rockchip,rk3399-max98357a-rt5514-da7219
> - rename source code to rk3399_max98357a_rt5514_da7219.c
> 
> Changes in v2:
> - use the FS 256 to set mclks of the max98357a and rt5514 danamically
> - add more sample rate for da7219
> 
>  .../bindings/sound/rockchip,rk3399-gru-sound.txt   |   15 +
>  sound/soc/rockchip/Kconfig                         |   11 +
>  sound/soc/rockchip/Makefile                        |    2 +
>  sound/soc/rockchip/rk3399_gru_sound.c              |  339 ++++++++++++++++++++
>  4 files changed, 367 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
>  create mode 100644 sound/soc/rockchip/rk3399_gru_sound.c
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> new file mode 100644
> index 0000000..f19b6c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3399-gru-sound.txt
> @@ -0,0 +1,15 @@
> +ROCKCHIP with MAX98357A/RT5514/DA7219 codecs on GRU boards
> +
> +Required properties:
> +- compatible: "rockchip,rk3399-gru-sound"
> +- rockchip,cpu: The phandle of the Rockchip I2S controller that's
> +  connected to the codecs
> +- rockchip,codec: The phandle of the MAX98357A/RT5514/DA7219 codecs
> +
> +Example:
> +
> +sound {
> +	compatible = "rockchip,rk3399-gru-sound";
> +	rockchip,cpu = <&i2s0>;
> +	rockchip,codec = <&max98357a &rt5514 &da7219>;

These seem fairly standard though a variety of versions in the bindings. 
Can we use audio-codec and audio-cpu (or cpu or audio-dai) here? Mark?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
