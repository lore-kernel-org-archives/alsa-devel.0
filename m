From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/10] ASoC: sun4i-codec: Add support for H3 codec
Date: Tue, 15 Nov 2016 16:23:45 -0600
Message-ID: <20161115222345.44b25usz2i6qeact@rob-hp-laptop>
References: <20161112064648.26779-1-wens@csie.org>
 <20161112064648.26779-9-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161112064648.26779-9-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mylene Josserand <mylene.josserand@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 12, 2016 at 02:46:46PM +0800, Chen-Yu Tsai wrote:
> The codec on the H3 is similar to the one found on the A31. One key
> difference is the analog path controls are routed through the PRCM
> block. This is supported by the sun8i-codec-analog driver, and tied
> into this codec driver with the audio card's aux_dev.
> 
> In addition, the H3 has no HP (headphone) and HBIAS support, and no
> MIC3 input. The FIFO related registers are slightly rearranged.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/sound/sun4i-codec.txt      |  3 +

Acked-by: Rob Herring <robh@kernel.org> 

>  sound/soc/sunxi/sun4i-codec.c                      | 71 ++++++++++++++++++++++
>  2 files changed, 74 insertions(+)
