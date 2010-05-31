From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC PATCH 3/5] OMAP3: McBSP: Use the port's
	buffer_size when calculating tx delay
Date: Mon, 31 May 2010 11:03:24 +0300
Message-ID: <1275293006-31594-4-git-send-email-peter.ujfalusi@nokia.com>
References: <1275293006-31594-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 80C9410380E
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 10:04:02 +0200 (CEST)
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

Sicne the platform data's buffer_size now holds the full size
of the FIFO, there is no longer need to handle the ports
differently.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 6462968..f8ffeee 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -575,8 +575,6 @@ u16 omap_mcbsp_get_fifo_size(unsigned int id)
 }
 EXPORT_SYMBOL(omap_mcbsp_get_fifo_size);
 
-#define MCBSP2_FIFO_SIZE	0x500 /* 1024 + 256 locations */
-#define MCBSP1345_FIFO_SIZE	0x80  /* 128 locations */
 /*
  * omap_mcbsp_get_tx_delay returns the number of used slots in the McBSP FIFO
  */
@@ -595,10 +593,7 @@ u16 omap_mcbsp_get_tx_delay(unsigned int id)
 	buffstat = MCBSP_READ(mcbsp, XBUFFSTAT);
 
 	/* Number of slots are different in McBSP ports */
-	if (mcbsp->id == 2)
-		return MCBSP2_FIFO_SIZE - buffstat;
-	else
-		return MCBSP1345_FIFO_SIZE - buffstat;
+	return mcbsp->pdata->buffer_size - buffstat;
 }
 EXPORT_SYMBOL(omap_mcbsp_get_tx_delay);
 
-- 
1.7.1
