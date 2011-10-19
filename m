From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: sgtl5000: Fix define for
	SGTL5000_BIAS_R_MASK
Date: Wed, 19 Oct 2011 10:54:56 +0800
Message-ID: <1318992896.7128.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) by alsa0.perex.cz (Postfix) with ESMTP id 8AA1F24150
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Oct 2011 04:55:10 +0200 (CEST)
Received: by yws29 with SMTP id 29so1371213yws.38
	for <alsa-devel@alsa-project.org>; Tue, 18 Oct 2011 19:55:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Zeng Zhaoming <zhaoming.zeng@freescale.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

According to the datasheet:
CHIP_MIC_CTRL 0x002A

BITS[9:8] BIAS_RESISTOR
        0x0 = Powerd off
        0x1 = 2.0 kohm
        0x2 = 4.0 kohm
        0x3 = 8.0 kohm

Thus SGTL5000_BIAS_R_MASK should be defined as 0x0300 instead of 0x0200.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/codecs/sgtl5000.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.h b/sound/soc/codecs/sgtl5000.h
index eec3ab3..8a9f435 100644
--- a/sound/soc/codecs/sgtl5000.h
+++ b/sound/soc/codecs/sgtl5000.h
@@ -280,7 +280,7 @@
 /*
  * SGTL5000_CHIP_MIC_CTRL
  */
-#define SGTL5000_BIAS_R_MASK			0x0200
+#define SGTL5000_BIAS_R_MASK			0x0300
 #define SGTL5000_BIAS_R_SHIFT			8
 #define SGTL5000_BIAS_R_WIDTH			2
 #define SGTL5000_BIAS_R_off			0x0
-- 
1.7.5.4
