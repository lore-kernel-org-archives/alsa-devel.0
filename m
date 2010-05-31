From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC PATCH 1/5] OMAP: McBSP: Function to query the
	FIFO size
Date: Mon, 31 May 2010 11:03:22 +0300
Message-ID: <1275293006-31594-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1275293006-31594-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 5066E24156
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 10:03:48 +0200 (CEST)
In-Reply-To: <1275293006-31594-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, linux-oamp@vger.kernel.org
Cc: tony@atomide.com, broonie@opensource.wolfsonmicro.com, eduardo.valentin@nokia.com, ext-eero.nurkkala@nokia.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Users of McBSP can use the omap_mcbsp_get_fifo_size function to query
the size of the McBSP FIFO.
The function will return the FIFO size in words (the HW maximum).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/include/plat/mcbsp.h |    2 ++
 arch/arm/plat-omap/mcbsp.c              |   14 ++++++++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcbsp.h b/arch/arm/plat-omap/include/plat/mcbsp.h
index 1bd7021..e126951 100644
--- a/arch/arm/plat-omap/include/plat/mcbsp.h
+++ b/arch/arm/plat-omap/include/plat/mcbsp.h
@@ -473,6 +473,7 @@ void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
 void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
 u16 omap_mcbsp_get_max_tx_threshold(unsigned int id);
 u16 omap_mcbsp_get_max_rx_threshold(unsigned int id);
+u16 omap_mcbsp_get_fifo_size(unsigned int id);
 u16 omap_mcbsp_get_tx_delay(unsigned int id);
 u16 omap_mcbsp_get_rx_delay(unsigned int id);
 int omap_mcbsp_get_dma_op_mode(unsigned int id);
@@ -483,6 +484,7 @@ static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
 { }
 static inline u16 omap_mcbsp_get_max_tx_threshold(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_max_rx_threshold(unsigned int id) { return 0; }
+static inline u16 omap_mcbsp_get_fifo_size(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_tx_delay(unsigned int id) { return 0; }
 static inline u16 omap_mcbsp_get_rx_delay(unsigned int id) { return 0; }
 static inline int omap_mcbsp_get_dma_op_mode(unsigned int id) { return 0; }
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 4820cab..51d8abf 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -559,6 +559,20 @@ u16 omap_mcbsp_get_max_rx_threshold(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_max_rx_threshold);
 
+u16 omap_mcbsp_get_fifo_size(unsigned int id)
+{
+	struct omap_mcbsp *mcbsp;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return -ENODEV;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+
+	return mcbsp->pdata->buffer_size;
+}
+EXPORT_SYMBOL(omap_mcbsp_get_fifo_size);
+
 #define MCBSP2_FIFO_SIZE	0x500 /* 1024 + 256 locations */
 #define MCBSP1345_FIFO_SIZE	0x80  /* 128 locations */
 /*
-- 
1.7.1
