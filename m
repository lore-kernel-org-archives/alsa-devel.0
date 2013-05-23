From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] MIPS: jz4740: Correct clock gate bit for DMA controller
Date: Thu, 23 May 2013 22:36:22 +0200
Message-ID: <1369341387-19147-2-git-send-email-lars@metafoo.de>
References: <1369341387-19147-1-git-send-email-lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369341387-19147-1-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Maarten ter Huurne <maarten@treewalker.org>, linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

From: Maarten ter Huurne <maarten@treewalker.org>

Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/jz4740/clock.c b/arch/mips/jz4740/clock.c
index 484d38a..1b5f554 100644
--- a/arch/mips/jz4740/clock.c
+++ b/arch/mips/jz4740/clock.c
@@ -687,7 +687,7 @@ static struct clk jz4740_clock_simple_clks[] = {
 	[3] = {
 		.name = "dma",
 		.parent = &jz_clk_high_speed_peripheral.clk,
-		.gate_bit = JZ_CLOCK_GATE_UART0,
+		.gate_bit = JZ_CLOCK_GATE_DMAC,
 		.ops = &jz_clk_simple_ops,
 	},
 	[4] = {
-- 
1.8.2.1
