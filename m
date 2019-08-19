From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 00/21] ASoC: sun4i-i2s: Number of fixes and TDM Support
Date: Mon, 19 Aug 2019 21:25:07 +0200
Message-ID: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>, lgirdwood@gmail.com, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, codekipper@gmail.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Maxime Ripard <maxime.ripard@bootlin.com>

Hi,

This series aims at fixing a number of issues in the current i2s driver,
mostly related to the i2s master support and the A83t support. It also uses
that occasion to cleanup a few things and simplify the driver. Finally, it
builds on those fixes and cleanups to introduce TDM and DSP formats support.

Let me know what you think,
Maxime

Marcus Cooper (1):
  ASoC: sun4i-i2s: Fix the MCLK and BCLK dividers on newer SoCs

Maxime Ripard (20):
  ASoC: sun4i-i2s: Register regmap and PCM before our component
  ASoC: sun4i-i2s: Switch to devm for PCM register
  ASoC: sun4i-i2s: Replace call to params_channels by local variable
  ASoC: sun4i-i2s: Move the channel configuration to a callback
  ASoC: sun4i-i2s: Move the format configuration to a callback
  ASoC: sun4i-i2s: Rework MCLK divider calculation
  ASoC: sun4i-i2s: Don't use the oversample to calculate BCLK
  ASoC: sun4i-i2s: Use module clock as BCLK parent on newer SoCs
  ASoC: sun4i-i2s: RX and TX counter registers are swapped
  ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
  ASoC: sun4i-i2s: Fix LRCK and BCLK polarity offsets on newer SoCs
  ASoC: sun4i-i2s: Fix the LRCK polarity
  ASoC: sun4i-i2s: Fix WSS and SR fields for the A83t
  ASoC: sun4i-i2s: Fix MCLK Enable bit offset on A83t
  ASoC: sun4i-i2s: Fix the LRCK period on A83t
  ASoC: sun4i-i2s: Remove duplicated quirks structure
  ASoC: sun4i-i2s: Pass the channels number as an argument
  ASoC: sun4i-i2s: Support more channels
  ASoC: sun4i-i2s: Add support for TDM slots
  ASoC: sun4i-i2s: Add support for DSP formats

 sound/soc/sunxi/sun4i-i2s.c | 660 ++++++++++++++++++++-----------------
 1 file changed, 372 insertions(+), 288 deletions(-)

base-commit: d45331b00ddb179e291766617259261c112db872
-- 
git-series 0.9.1
