From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v3 1/3] clk: zte: add i2s clocks for zx296718
Date: Wed,  8 Feb 2017 11:02:33 +0800
Message-ID: <1486522955-14528-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f45.google.com (mail-pg0-f45.google.com [74.125.83.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 08B9826683E
 for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2017 04:03:55 +0100 (CET)
Received: by mail-pg0-f45.google.com with SMTP id 194so44333217pgd.2
 for <alsa-devel@alsa-project.org>; Tue, 07 Feb 2017 19:03:55 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, baoyou.xie@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, perex@perex.cz, tiwai@suse.com, shawn.guo@linaro.org, vinod.koul@intel.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, mathieu.poirier@linaro.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The i2s related clock support is missing from the existing zx296718
clock driver. This patch adds it, so that the upstream ZX I2S driver
can work out.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/clk/zte/clk-zx296718.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index ad5d1df..f106d40 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -941,6 +941,10 @@ static struct zx_clk_gate audio_gate_clk[] = {
 	GATE(AUDIO_SPDIF1_WCLK, "spdif1_wclk", "spdif1_wclk_div", AUDIO_SPDIF1_CLK, 9, CLK_SET_RATE_PARENT, 0),
 	GATE(AUDIO_TDM_WCLK, "tdm_wclk", "tdm_wclk_div", AUDIO_TDM_CLK, 17, CLK_SET_RATE_PARENT, 0),
 	GATE(AUDIO_TS_PCLK, "tempsensor_pclk", "clk49m5", AUDIO_TS_CLK, 1, 0, 0),
+	GATE(AUDIO_I2S0_PCLK, "i2s0_pclk", "clk49m5", AUDIO_I2S0_CLK, 8, 0, 0),
+	GATE(AUDIO_I2S1_PCLK, "i2s1_pclk", "clk49m5", AUDIO_I2S1_CLK, 8, 0, 0),
+	GATE(AUDIO_I2S2_PCLK, "i2s2_pclk", "clk49m5", AUDIO_I2S2_CLK, 8, 0, 0),
+	GATE(AUDIO_I2S3_PCLK, "i2s3_pclk", "clk49m5", AUDIO_I2S3_CLK, 8, 0, 0),
 };
 
 static struct clk_hw_onecell_data audio_hw_onecell_data = {
-- 
2.7.4
