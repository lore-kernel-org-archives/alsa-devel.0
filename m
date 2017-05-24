From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 0/9] Add support for the audio codec on
 Allwinner V3s
Date: Wed, 24 May 2017 16:10:08 +0530
Message-ID: <20170524104008.GA15061@localhost>
References: <20170524100607.29790-1-icenowy@aosc.io>
Reply-To: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDLNNTP63EBBBAWFSXEQKGQEDDQ7VMY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170524100607.29790-1-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Arnd
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Wed, May 24, 2017 at 06:05:58PM +0800, Icenowy Zheng wrote:
> Allwinner V3s features a audio codec with dedicated digital and analog parts,
> like the ones on A23/H3, but much simpler (lack of MIC2, LINE IN and MBIAS).
> 
> Add support for it.
> 
> In order to make the codec usable, DMA support is also added in this series.
> 
> Patch 1 split out MBIAS in analog codec driver.
> 
> Patch 2 prepared a set of objects that have MIC2 and LINEIN stripped out
> for V3s.
> 
> Patch 3/4 adds support for V3s in analog/digital codec.
> 
> Patch 5 add the gate bit as a common quirk of sun6i-dma driver, as V3s also
> needs it.
> 
> Patch 6 really adds support for V3s in DMA engine.
> 
> Patch 7/8/9 adds three parts of device tree: DMA engine, codec support
> and enable the codec for Lichee Pi Zero dock.
> 
> Icenowy Zheng (9):
>   ASoC: sun8i-codec-analog: split out mbias
>   ASoC: sun8i-codec-analog: prepare a mixer control/widget/route set for
>     V3s
>   ASoC: sun8i-codec-analog: add support for V3s SoC
>   ASoC: sun4i-codec: Add support for V3s codec
>   dmaengine: sun6i: make gate bit in sun8i's DMA engines a common quirk
>   dmaengine: sun6i: support V3s SoC variant
>   ARM: dts: sun8i: add DMA engine in V3s DTSI
>   ARM: dts: sun8i: add audio codec support into V3s DTSI
>   ARM: sun8i: v3s: enable audio on Lichee Pi Zero Dock board

And why do we need the cross tree submission?? I have asked before and was
met with silence! [1]

Can you please split it up per subsystem to make it easy for everyone and
clearly spell out dependencies.

[1]: https://www.spinics.net/lists/dmaengine/msg12884.html

-- 
~Vinod
