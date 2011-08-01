From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH 1/1] ASoC: sgtl5000: add one missed cache reg
Date: Mon, 1 Aug 2011 19:41:18 +0800
Message-ID: <1312198878-13453-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) by alsa0.perex.cz (Postfix) with ESMTP id 312C324549
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Aug 2011 13:34:27 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: s.hauer@pengutronix.de, broonie@opensource.wolfsonmicro.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org, w.sang@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Signed-off-by: Zeng Zhaoming <zhaoming.zeng@freescale.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/codecs/sgtl5000.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 76258f2..5a0d8e4 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -49,6 +49,7 @@ static const u16 sgtl5000_regs[SGTL5000_MAX_REG_OFFSET >> 1] =  {
 	0x0000, /* 0x0016, reserved */
 	0x0000, /* 0x0018, reserved */
 	0x0000, /* 0x001A, reserved */
+	0x0000, /* 0x001C, reserved */
 	0x0000, /* 0x001E, reserved */
 	0x0000, /* 0x0020, CHIP_ANA_ADC_CTRL */
 	0x1818, /* 0x0022, CHIP_ANA_HP_CTRL */
-- 
1.7.0.4
