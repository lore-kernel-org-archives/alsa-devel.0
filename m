From: Naresh Medisetty <naresh@ti.com>
Subject: [PATCH 4/9] ARM: DaVinci: ASoC: Adds ALSA PCM
	interface for the TI DM646X processor
Date: Mon, 16 Mar 2009 08:03:44 -0400
Message-ID: <1237205024-30135-1-git-send-email-naresh@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 47F84103804
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 13:20:59 +0100 (CET)
Received: from dflp53.itg.ti.com ([128.247.5.6])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2GCKqUg020973
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 07:20:57 -0500
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
Cc: davinci-linux-open-source@linux.davincidsp.com, Naresh Medisetty <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Adds ALSA PCM interface for the TI DM646X processor

Signed-off-by: Naresh Medisetty <naresh@ti.com>
---
This patch applies on the ASoC tree available at http://opensource.wolfsonmicro.com/cgi-bin/gitweb.cgi?p=linux-2.6-asoc.git;a=commit;h=168776ef58d38503f8ac4f8a7eb1039137208032.

 sound/soc/davinci/davinci-pcm.h |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.h b/sound/soc/davinci/davinci-pcm.h
index 62cb4eb..c7d8711 100644
--- a/sound/soc/davinci/davinci-pcm.h
+++ b/sound/soc/davinci/davinci-pcm.h
@@ -12,16 +12,30 @@
 #ifndef _DAVINCI_PCM_H
 #define _DAVINCI_PCM_H
 
+#include <mach/edma.h>
+
 struct davinci_pcm_dma_params {
-	char *name;		/* stream identifier */
-	int channel;		/* sync dma channel ID */
-	dma_addr_t dma_addr;	/* device physical address for DMA */
-	unsigned int data_type;	/* xfer data type */
+	char *name;			/* stream identifier */
+	int channel;			/* sync dma channel ID */
+	dma_addr_t dma_addr;		/* device physical address for DMA */
+	unsigned int data_type;		/* xfer data type */
+	enum dma_event_q eventq_no;	/* event queue number */
 };
 
 struct evm_snd_platform_data {
+	char *clk_name;
 	int tx_dma_ch;
 	int rx_dma_ch;
+	u32 tx_dma_offset;
+	u32 rx_dma_offset;
+	enum dma_event_q eventq_no;	/* event queue number */
+	unsigned int codec_fmt;
+
+	/* McASP specific fields */
+	int tdm_slots;
+	u8 op_mode;
+	u8 num_serializer;
+	u8 *serial_dir;
 };
 
 extern struct snd_soc_platform davinci_soc_platform;
-- 
1.5.6
