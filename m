From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v4 1/3] clk: zte: add i2s clocks for zx296718
Date: Thu,  9 Feb 2017 11:12:56 +0800
Message-ID: <1486609978-18482-1-git-send-email-baoyou.xie@linaro.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, baoyou.xie@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, perex@perex.cz, tiwai@suse.com, shawn.guo@linaro.org, vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, shawnguo@kernel.org, mathieu.poirier@linaro.org, xie.baoyou@zte.com.cn, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn
List-Id: alsa-devel@alsa-project.org

The i2s related clock support is missing from the existing zx296718
clock driver. This patch adds it, so that the upstream ZX I2S driver
can work out.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/clk/zte/clk-zx296718.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index ad5d1df..2f7c668 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -936,6 +936,10 @@ static struct zx_clk_gate audio_gate_clk[] = {
 	GATE(AUDIO_I2S1_WCLK, "i2s1_wclk", "i2s1_wclk_div", AUDIO_I2S1_CLK, 9, CLK_SET_RATE_PARENT, 0),
 	GATE(AUDIO_I2S2_WCLK, "i2s2_wclk", "i2s2_wclk_div", AUDIO_I2S2_CLK, 9, CLK_SET_RATE_PARENT, 0),
 	GATE(AUDIO_I2S3_WCLK, "i2s3_wclk", "i2s3_wclk_div", AUDIO_I2S3_CLK, 9, CLK_SET_RATE_PARENT, 0),
+	GATE(AUDIO_I2S0_PCLK, "i2s0_pclk", "clk49m5", AUDIO_I2S0_CLK, 8, 0, 0),
+	GATE(AUDIO_I2S1_PCLK, "i2s1_pclk", "clk49m5", AUDIO_I2S1_CLK, 8, 0, 0),
+	GATE(AUDIO_I2S2_PCLK, "i2s2_pclk", "clk49m5", AUDIO_I2S2_CLK, 8, 0, 0),
+	GATE(AUDIO_I2S3_PCLK, "i2s3_pclk", "clk49m5", AUDIO_I2S3_CLK, 8, 0, 0),
 	GATE(AUDIO_I2C0_WCLK, "i2c0_wclk", "i2c0_wclk_mux", AUDIO_I2C0_CLK, 9, CLK_SET_RATE_PARENT, 0),
 	GATE(AUDIO_SPDIF0_WCLK, "spdif0_wclk", "spdif0_wclk_div", AUDIO_SPDIF0_CLK, 9, CLK_SET_RATE_PARENT, 0),
 	GATE(AUDIO_SPDIF1_WCLK, "spdif1_wclk", "spdif1_wclk_div", AUDIO_SPDIF1_CLK, 9, CLK_SET_RATE_PARENT, 0),
-- 
2.7.4

