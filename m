From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 13/20] OMAP: McBSP: Do not enable wakeups for
	no-idle mode
Date: Thu, 30 Jul 2009 15:49:36 +0300
Message-ID: <1248958183-15015-14-git-send-email-eduardo.valentin__8110.85224054313$1248959214$gmane$org@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-6-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-7-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-8-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-9-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-10-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-11-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-12-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-13-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

When no-idle mode is taken, wakeups need not to be enabled.
Moreover, CLOCKACTIVITY bits are unnecessary with this mode
also.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Acked-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/mcbsp.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 11cfcfe..cb4a455 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -378,16 +378,17 @@ int omap_mcbsp_request(unsigned int id)
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 
 		spin_lock_irq(&mcbsp->lock);
-		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD)
-			syscon |= SIDLEMODE(0x02);
-		else
+		if (mcbsp->dma_op_mode == MCBSP_DMA_MODE_THRESHOLD) {
+			syscon |= (ENAWAKEUP | SIDLEMODE(0x02) |
+					CLOCKACTIVITY(0x02));
+			OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN,
+					WAKEUPEN_ALL);
+		} else {
 			syscon |= SIDLEMODE(0x01);
+		}
 		spin_unlock_irq(&mcbsp->lock);
 
-		syscon |= (ENAWAKEUP | CLOCKACTIVITY(0x02));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
-
-		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
 	}
 #endif
 
-- 
1.6.2.GIT

