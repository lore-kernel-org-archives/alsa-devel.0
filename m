From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 00/21] ASoC: sun4i-i2s: Number of fixes and TDM Support
Date: Tue, 27 Aug 2019 16:20:24 +0800
Message-ID: <CAGb2v64xOcs3Vi5k3yUwMiUrzZMuJ5vZ3kxp9w1=CQDrkn3cgA@mail.gmail.com>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maxime Ripard <mripard@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Code Kipper <codekipper@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi everyone,

On Tue, Aug 20, 2019 at 3:25 AM Maxime Ripard <mripard@kernel.org> wrote:
>
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> Hi,
>
> This series aims at fixing a number of issues in the current i2s driver,
> mostly related to the i2s master support and the A83t support. It also uses
> that occasion to cleanup a few things and simplify the driver. Finally, it
> builds on those fixes and cleanups to introduce TDM and DSP formats support.
>
> Let me know what you think,
> Maxime
>
> Marcus Cooper (1):
>   ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs
>
> Maxime Ripard (20):
>   ASoC: sun4i-i2s: Register regmap and PCM before our component
>   ASoC: sun4i-i2s: Switch to devm for PCM register
>   ASoC: sun4i-i2s: Replace call to params_channels by local variable
>   ASoC: sun4i-i2s: Move the channel configuration to a callback
>   ASoC: sun4i-i2s: Move the format configuration to a callback
>   ASoC: sun4i-i2s: Rework MCLK divider calculation
>   ASoC: sun4i-i2s: Don't use the oversample to calculate BCLK
>   ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs
>   ASoC: sun4i-i2s: RX and TX counter registers are swapped
>   ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
>   ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs
>   ASoC: sun4i-i2s: Fix the LRCK polarity
>   ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t
>   ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t
>   ASoC: sun4i-i2s: Fix the LRCK period on A83t
>   ASoC: sun4i-i2s: Remove duplicated quirks structure

Unfortunately the patches that "fix" support on the A83T actually break it.
The confusion stems from the user manual not actually documenting the I2S
controller. Instead it documents the TDM controller, which is very similar
or the same as the I2S controller in the H3. The I2S controller that we
actually support in this driver is not the TDM controller, but three other
I2S controllers that are only mentioned in the memory map. Support for this
was done by referencing the BSP kernel, which has separate driver instances
for each controller instance, both I2S and TDM.

Now to remedy this I could send reverts for all the "A83t" patches, and
fixes for all the others that affect the A83t quirks. However the fixes
tags existing in the tree would be wrong and confusing. That might be a
pain for the stable kernel maintainers.

Any suggestions on how to proceed?

Regards
ChenYu

>   ASoC: sun4i-i2s: Pass the channels number as an argument
>   ASoC: sun4i-i2s: Support more channels
>   ASoC: sun4i-i2s: Add support for TDM slots
>   ASoC: sun4i-i2s: Add support for DSP formats
>
>  sound/soc/sunxi/sun4i-i2s.c | 660 ++++++++++++++++++++-----------------
>  1 file changed, 372 insertions(+), 288 deletions(-)
>
> base-commit: d45331b00ddb179e291766617259261c112db872
> --
> git-series 0.9.1
