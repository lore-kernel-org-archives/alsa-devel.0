From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 01/10] ASoC: sunxi: Add bindings for A23/A33/H3 codec's
 analog path controls
Date: Tue, 15 Nov 2016 16:22:19 -0600
Message-ID: <20161115222219.aw6clwnadx6cy6ox@rob-hp-laptop>
References: <20161112064648.26779-1-wens@csie.org>
 <20161112064648.26779-2-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161112064648.26779-2-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Mylene Josserand <mylene.josserand@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 12, 2016 at 02:46:39PM +0800, Chen-Yu Tsai wrote:
> The internal codec on A23/A33/H3 is split into 2 parts. The
> analog path controls are routed through an embedded custom register
> bus accessed through the PRCM block.
> 
> The SoCs share a common set of inputs, outputs, and audio paths.
> The following table lists the differences.
> 
>     ----------------------------------------
>     | Feature \ SoC |  A23  |  A33  |  H3  |
>     ----------------------------------------
>     | Headphone     |   v   |   v   |      |
>     ----------------------------------------
>     | Line Out      |       |       |  v   |
>     ----------------------------------------
>     | Phone In/Out  |   v   |   v   |      |
>     ----------------------------------------
> 
> Add a binding for this hardware.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  .../devicetree/bindings/sound/sun8i-codec-analog.txt     | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/sun8i-codec-analog.txt

Acked-by: Rob Herring <robh@kernel.org> 
