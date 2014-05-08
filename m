From: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Subject: Re: [PATCH v2 0/9] DT instantiation of sound on T5325
Date: Thu, 8 May 2014 19:37:48 +0200
Message-ID: <20140508173748.GK27377@lunn.ch>
References: <1399141819-23924-1-git-send-email-andrew@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1399141819-23924-1-git-send-email-andrew-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux ARM <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Sat, May 03, 2014 at 08:30:10PM +0200, Andrew Lunn wrote:
> This patchset uses DT to instantiate sound on the T5325. It adds a DT
> binding to the codec, then removes the platform device for the codec
> and adds a DT node. simple-card is extended to support mlck_fs. The
> platform device for the audio device is then replaced with a DT node.
> Lastly, two _defconfig's are updated to build the needed modules.

Hi Folks

The ARM mvebu maintainer is happy with these patches. Does anybody
have any comments on the sound/soc parts? Mark, will you take the
alc5623 and simple-card patches?

Thanks
	Andrew

> 
> Andrew Lunn (9):
>   ASoC: alc5623: Add device tree binding
>   ARM: Kirkwood: Remove platform driver for codec
>   ARM: Kirkwood: Add node for audio codec
>   ARM: Kirkwood: DT: Add missing #sound-dai-cells property
>   ASoC: simple-card: Support setting mclk via a fixed factor
>   ARM: Kirkwood: t5325: Remove platform device to instantiate audio
>   ARM: Kirkwood: t5325: Use simple card to instantiate audio
>   ARM: mvebu_v5_defconfig: Enable sound modules needed for t5325
>   ARM: multi_v5_defconfig: Enable sound modules needed for t5325
> 
>  .../devicetree/bindings/sound/alc5623.txt          | 25 +++++++++++++
>  .../devicetree/bindings/sound/simple-card.txt      |  2 ++
>  arch/arm/boot/dts/kirkwood-t5325.dts               | 33 +++++++++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi                    |  1 +
>  arch/arm/configs/multi_v5_defconfig                |  3 +-
>  arch/arm/configs/mvebu_v5_defconfig                |  3 +-
>  arch/arm/mach-mvebu/Kconfig                        |  7 ----
>  arch/arm/mach-mvebu/Makefile                       |  1 -
>  arch/arm/mach-mvebu/board-t5325.c                  | 41 ----------------------
>  arch/arm/mach-mvebu/board.h                        |  6 ----
>  arch/arm/mach-mvebu/kirkwood.c                     |  3 --
>  sound/soc/codecs/Kconfig                           |  2 +-
>  sound/soc/codecs/alc5623.c                         | 20 +++++++++++
>  sound/soc/generic/simple-card.c                    | 28 +++++++++++++++
>  14 files changed, 114 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/alc5623.txt
>  delete mode 100644 arch/arm/mach-mvebu/board-t5325.c
> 
> -- 
> 2.0.0.rc0
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
