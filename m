From: Ricardo Neri <ricardo.neri@ti.com>
Subject: [PATCH 3/6] ASoC: OMAP: Add header for HDMI CPU DAI
Date: Thu,  5 May 2011 02:21:50 -0500
Message-ID: <1304580113-24819-4-git-send-email-ricardo.neri@ti.com>
References: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id EF411103973
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 09:21:48 +0200 (CEST)
In-Reply-To: <1304580113-24819-1-git-send-email-ricardo.neri@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, lrg@ti.com
Cc: Ricardo Neri <ricardo.neri@ti.com>
List-Id: alsa-devel@alsa-project.org

This header contains definitions used by the ASoC HDMI CPU DAI.
These are used to define the DMA port as well as the supported
audio sample formats and rates.

Signed-off-by: Ricardo Neri <ricardo.neri@ti.com>
---
 sound/soc/omap/omap-hdmi.h |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)
 create mode 100644 sound/soc/omap/omap-hdmi.h

diff --git a/sound/soc/omap/omap-hdmi.h b/sound/soc/omap/omap-hdmi.h
new file mode 100644
index 0000000..d71a970
--- /dev/null
+++ b/sound/soc/omap/omap-hdmi.h
@@ -0,0 +1,36 @@
+/*
+ * omap-hdmi.h
+ *
+ * Definitions for OMAP ALSA SoC DAI driver for HDMI audio on OMAP4 processors.
+ * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Authors: Jorge Candelaria <jorge.candelaria@gmail.com>
+ *          Ricardo Neri <ricardo.neri@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __OMAP_HDMI_H__
+#define __OMAP_HDMI_H__
+
+#define OMAP_HDMI_AUDIO_DMA_PORT 0x8c
+
+#define OMAP_HDMI_RATES	(SNDRV_PCM_RATE_32000 | \
+				SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
+
+#define OMAP_HDMI_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | \
+				SNDRV_PCM_FMTBIT_S24_LE)
+
+#endif
-- 
1.7.1
