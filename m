From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH 2/4] soc-dai: add bitfields for hardware I2S
	formats
Date: Wed,  4 Mar 2009 21:16:58 +0100
Message-ID: <1236197820-21022-2-git-send-email-daniel@caiaq.de>
References: <20090304201505.GE12183@buzzloop.caiaq.de>
	<1236197820-21022-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E5C61103910
	for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2009 21:17:11 +0100 (CET)
In-Reply-To: <1236197820-21022-1-git-send-email-daniel@caiaq.de>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Tim Ruetz <tim@caiaq.de>, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

This patch adds bitfields for I2S serial formats that differ from the
amount of data actually sent on the line. Some codecs (namely the
cs4270) require 64 sysclks being sent during each frame period, even
though the number of acutal data bits might be less.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Liam Girdwood <lrg@kernel.org>
Cc: Tim Ruetz <tim@caiaq.de>
---
 include/sound/soc-dai.h |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 24247f7..83b617f 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -85,10 +85,22 @@ struct snd_pcm_substream;
 #define SND_SOC_DAIFMT_CBM_CFS		(2 << 12) /* codec clk master & frame slave */
 #define SND_SOC_DAIFMT_CBS_CFS		(3 << 12) /* codec clk & frm slave */
 
-#define SND_SOC_DAIFMT_FORMAT_MASK	0x000f
-#define SND_SOC_DAIFMT_CLOCK_MASK	0x00f0
-#define SND_SOC_DAIFMT_INV_MASK		0x0f00
-#define SND_SOC_DAIFMT_MASTER_MASK	0xf000
+/*
+ * DAI hardware frame formats.
+ *
+ * Independently, these bits the define the audio format on the
+ * pysical channel in case it differs from the audio sample the
+ * DAI is configured to
+ */
+#define SND_SOC_DAIFMT_FF_SAMPLE	(0 << 16)
+#define SND_SOC_DAIFMT_FF_I2S_16	(1 << 16)
+#define SND_SOC_DAIFMT_FF_I2S_32	(2 << 16)
+
+#define SND_SOC_DAIFMT_FORMAT_MASK		0x0000f
+#define SND_SOC_DAIFMT_CLOCK_MASK		0x000f0
+#define SND_SOC_DAIFMT_INV_MASK			0x00f00
+#define SND_SOC_DAIFMT_MASTER_MASK		0x0f000
+#define SND_SOC_DAIFMT_FRAME_FORMAT_MASK	0xf0000
 
 /*
  * Master Clock Directions
-- 
1.6.1.3
