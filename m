From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v2] ASoC: WM8962: Enable start-up and normal
	bias after reset in runtime resume
Date: Fri, 14 Jun 2013 19:49:06 +0800
Message-ID: <1371210546-5747-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D7A82651D3
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 13:42:20 +0200 (CEST)
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

This part of bias settings are essential for WM8962 to power up. Without it
"wm8962 0-001a: DC servo timed out" might be prompted due to power-up failure
that happens to FLL if being used.

The driver's also bringing the bias down in the suspend path so it needs to be
powered up in the resume path for symmetry.

According to dapm_pre_sequence_async(), DAPM would call pm_runtime_get_sync()
to let driver finish the bias settings in pm_runtime_resume() before the bias
level being set to STANDBY. So no need to worry about disordered settings for
VMID of WM8962.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
Changelog:
 v1->v2
 * Revised the commit comment to make it clear.

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
