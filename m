From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 0/4] ASoC: sun4i-i2s: Number of fixes and TDM Support
Date: Wed, 21 Aug 2019 15:06:52 +0200
Message-ID: <cover.6022d5fe61fb8a11565a71bee24d5280b0259c63.1566392800.git-series.maxime.ripard@bootlin.com>
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

Changes from v1:
  - Removed patches applied
  - Refactor a bit the call to sun4i_i2s_set_clk_rate
  - Fix build issue
  - Add an extra patch to cleanup sun4i_i2s_hw_params

Maxime Ripard (4):
  ASoC: sun4i-i2s: Use the physical / slot width for the clocks
  ASoC: sun4i-i2s: Use the actual format width instead of an hardcoded one
  ASoC: sun4i-i2s: Replace call to params_width by local variable
  ASoC: sun4i-i2s: Add support for DSP formats

 sound/soc/sunxi/sun4i-i2s.c | 58 ++++++++++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 15 deletions(-)

base-commit: 137befe19f310400a8b20fd8a4ce8c4141aafde0
-- 
git-series 0.9.1
