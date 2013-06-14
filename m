From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: WM8962: Enable start-up and normal bias
	after reset in runtime resume
Date: Fri, 14 Jun 2013 16:52:20 +0800
Message-ID: <1371199940-29803-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 7950C261A11
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 10:45:28 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The analogue circuits in WM8962 require a mid-rail analogue reference
voltage, VMID, which generator is enabled by STARTUP_BIAS_ENA bit,
while VMID_BUF_ENA bit can enable buffered VMID to avoid audible pops.

Besides, these circuits also need a bias current enabled by BIAS_ENA.

Then set VMID_SEL to 2x5k divider, the fast start-up mode, to power it
up. And let set_bias_level() handle its 2x250k for low power standby
and 2x50k for normal operation.

This patch might be kinda reverting operation against commit 52c0eee3
but after testing with WM8962 CODEC, these configurations during power
up should be essential and soc-core would not do any of them. So the
codec drvier need to handle it.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/codecs/wm8962.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 7a7a056..c63b58e 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3773,6 +3773,17 @@ static int wm8962_runtime_resume(struct device *dev)
 
 	regcache_sync(wm8962->regmap);
 
+	regmap_update_bits(wm8962->regmap, WM8962_ANTI_POP,
+			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA,
+			   WM8962_STARTUP_BIAS_ENA | WM8962_VMID_BUF_ENA);
+
+	/* Bias enable at 2*5k (fast start-up) */
+	regmap_update_bits(wm8962->regmap, WM8962_PWR_MGMT_1,
+			   WM8962_BIAS_ENA | WM8962_VMID_SEL_MASK,
+			   WM8962_BIAS_ENA | 0x180);
+
+	msleep(5);
+
 	return 0;
 }
 
-- 
1.7.1
