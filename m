From: Paolo Doz <paolo.doz@gmail.com>
Subject: [PATCH 2/4] ASoC: ak5702: register list of ak5702
Date: Mon, 29 Oct 2012 09:44:05 +0100
Message-ID: <CAFsPKCW1kNxeffMxa3j1VOhpenV3fpC3ma-jD0SswbdKBc+uMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BC1B26530E
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 09:44:06 +0100 (CET)
Received: by mail-ee0-f51.google.com with SMTP id d49so1964642eek.38
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 01:44:06 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This header file defines the list and possible values of ak5702 registers.

Signed-off-by: Paolo Doz <paolo.doz@gmail.com>
---
 sound/soc/codecs/ak5702.h |  164
+++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 sound/soc/codecs/ak5702.h

diff --git a/sound/soc/codecs/ak5702.h b/sound/soc/codecs/ak5702.h
new file mode 100644
index 0000000..b214350
--- /dev/null
+++ b/sound/soc/codecs/ak5702.h
@@ -0,0 +1,164 @@
+/*
+ * ak5702.h  --  AK5702 ALSA SoC driver
+ *
+ * Author:      Paolo Doz <paolo.doz@gmail.com>
+ * Copyright:   (C) 2012 Soft In S.r.l.
+ *                  2009 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This code comes from the original Freescale Ak5702 Audio driver
+ */
+
+#ifndef _AK5702_H
+#define _AK5702_H
+
+/* AK5702 register space */
+
+#define AK5702_PM1        0x00
+#define AK5702_PLL1        0x01
+#define AK5702_SIG1        0x02
+#define AK5702_MICG1        0x03
+#define AK5702_FMT1        0x04
+#define AK5702_FS1        0x05
+#define AK5702_CLK1        0x06
+#define AK5702_VOLCTRL1        0x07
+#define AK5702_LVOL1        0x08
+#define AK5702_RVOL1        0x09
+#define AK5702_TIMER1        0x0A
+#define AK5702_ALC11        0x0B
+#define AK5702_ALC12        0x0C
+#define AK5702_MODE11        0x0D
+#define AK5702_MODE12        0x0E
+#define AK5702_MODE13        0x0F
+
+#define AK5702_PM2        0x10
+#define AK5702_PLL2        0x11
+#define AK5702_SIG2        0x12
+#define AK5702_MICG2        0x13
+#define AK5702_FMT2        0x14
+#define AK5702_FS2        0x15
+#define AK5702_CLK2        0x16
+#define AK5702_VOLCTRL2        0x17
+#define AK5702_LVOL2        0x18
+#define AK5702_RVOL2        0x19
+#define AK5702_TIMER2        0x1A
+#define AK5702_ALC21        0x1B
+#define AK5702_ALC22        0x1C
+#define AK5702_MODE21        0x1D
+#define AK5702_MODE22        0x1E
+
+#define AK5702_CACHEREGNUM    0x1F
+
+#define AK5702_POWERDOWN    0x0
+#define AK5702_PM1_PMADAL    0x01
+#define AK5702_PM1_PMADAR    0x02
+#define AK5702_PM1_PMVCM    0x04
+#define AK5702_PM2_PMADBL    0x01
+#define AK5702_PM2_PMADBR    0x02
+
+#define AK5702_PLL1_POWERDOWN    0x0
+#define AK5702_PLL1_POWERUP    0x01
+#define AK5702_PLL1_MASTER    0x02
+#define AK5702_PLL1_SLAVE    0x0
+#define AK5702_PLL1_MODE0    0x0
+#define AK5702_PLL1_MODE2    0x08
+#define AK5702_PLL1_MODE3    0x0C
+#define AK5702_PLL1_MODE4    0x10
+#define AK5702_PLL1_MODE5    0x14
+#define AK5702_PLL1_MODE6    0x18
+#define AK5702_PLL1_MODE7    0x1C
+#define AK5702_PLL1_MODE8    0x20
+#define AK5702_PLL1_MODE9    0x24
+#define AK5702_PLL1_MODE12    0x30
+#define AK5702_PLL1_MODE13    0x34
+#define AK5702_PLL1_MODE14    0x38
+#define AK5702_PLL1_MODE15    0x3C
+#define AK5702_PLL1_11289600    0x10
+#define AK5702_PLL1_12000000    0x24
+#define AK5702_PLL1_12288000    0x14
+#define AK5702_PLL1_19200000    0x20
+
+#define AK5702_FS1_MCKI_MODE0    0x0
+#define AK5702_FS1_MCKI_MODE1    0x01
+#define AK5702_FS1_MCKI_MODE2    0x02
+#define AK5702_FS1_MCKI_MODE3    0x03
+#define AK5702_FS1_MCKI_MODE4    0x04
+#define AK5702_FS1_MCKI_MODE5    0x05
+#define AK5702_FS1_MCKI_MODE6    0x06
+#define AK5702_FS1_MCKI_MODE7    0x07
+#define AK5702_FS1_MCKI_MODE10    0x0A
+#define AK5702_FS1_MCKI_MODE11    0x0B
+#define AK5702_FS1_MCKI_MODE14    0x0E
+#define AK5702_FS1_MCKI_MODE15    0x0F
+
+#define AK5702_FS1_BCLK_MODE0    0x0
+#define AK5702_FS1_BCLK_MODE1    0x04
+#define AK5702_FS1_BCLK_MODE2    0x08
+
+#define AK5702_FS1_SLAVE_1024FS    0x01
+#define AK5702_FS1_SLAVE_512FS    0x02
+#define AK5702_FS1_SLAVE_256FS    0x03
+
+#define AK5702_SIG1_L_LIN1    0x0
+#define AK5702_SIG1_L_LIN2    0x01
+#define AK5702_SIG1_R_RIN1    0x0
+#define AK5702_SIG1_R_RIN2    0x02
+#define AK5702_SIG1_PMMPA    0x10
+#define AK5702_SIG1_L_LIN5    0x20
+#define AK5702_SIG1_R_RIN5    0x40
+#define AK5702_SIG2_L_LIN3    0x0
+#define AK5702_SIG2_L_LIN4    0x01
+#define AK5702_SIG2_R_RIN3    0x0
+#define AK5702_SIG2_R_RIN4    0x02
+#define AK5702_SIG2_PMMPB    0x10
+
+#define AK5702_MICGAIN_0DB    0x0
+
+#define AK5702_FMT1_I2S        0x23
+#define AK5702_FMT1_MSB        0x22
+#define AK5702_FMT1_TDM128    0x60
+#define AK5702_FMT1_TDM256    0xE0
+#define AK5702_FMT2_STEREO    0x20
+#define AK5702_FS1_BCKO_32FS    0x10
+#define AK5702_FS1_BCKO_64FS    0x20
+#define AK5702_CLK1_PS_256FS    0x0
+#define AK5702_CLK1_PS_128FS    0x01
+#define AK5702_CLK1_PS_64FS    0x02
+#define AK5702_CLK1_PS_32FS    0x03
+#define AK5702_VOLCTRL_INDEP    0x0
+#define AK5702_VOLCTRL_DEP    0x01
+#define AK5702_VOL_INIT        0x91
+
+#define AK5702_PLL1_PM_MASK    0x01
+#define AK5702_PLL1_MODE_MASK    0x02
+#define AK5702_PLL1_PLL_MASK    0x3C
+#define AK5702_FS1_BCKO_MASK    0x30
+#define AK5702_FS1_FS_MASK    0x0F
+#define AK5702_CLK1_PS_MASK    0x03
+#define AK5702_FMT1_TDM_MASK    0xC0
+/* clock divider id */
+#define AK5702_BCLK_CLKDIV    0
+#define AK5702_MCLK_CLKDIV    1
+
+/* bit clock div values */
+#define AK5702_BCLK_DIV_32    0
+#define AK5702_BCLK_DIV_64    1
+
+/* m clock div values */
+#define AK5702_MCLK_DIV_32    0
+#define AK5702_MCLK_DIV_64    1
+#define AK5702_MCLK_DIV_128    2
+#define AK5702_MCLK_DIV_256    3
+
+/* PLL master and slave modes */
+#define AK5702_PLL_POWERDOWN    0
+#define AK5702_PLL_MASTER    1
+#define AK5702_PLL_SLAVE    2
+
+extern struct snd_soc_dai_driver ak5702_dai;
+extern struct snd_soc_codec_driver soc_codec_dev_ak5702;
+
+#endif
-- 
1.7.9.5
