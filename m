From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 10/20] OMAP: McBSP: Change wakeup signals
Date: Tue, 11 Aug 2009 16:05:21 +0300
Message-ID: <1249995931-26015-11-git-send-email-eduardo.valentin__23456.6862498925$1249998043$gmane$org@nokia.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-5-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-6-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-7-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-8-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-10-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249995931-26015-10-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eduardo Valentin <eduardo.valentin@nokia.com>

Configure only XRDYEN and RRDYEN wakeup signals
in order to get better power consumption.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    3 ---
 arch/arm/plat-omap/mcbsp.c              |    7 ++-----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 2c5612a..776ea4d 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -273,9 +273,6 @@
 #define REOFEN			0x0004
 #define RFSREN			0x0002
 #define RSYNCERREN		0x0001
-#define WAKEUPEN_ALL		(XEMPTYEOFEN | XRDYEN | XEOFEN | XFSXEN | \
-				 XSYNCERREN | RRDYEN | REOFEN | RFSREN | \
-				 RSYNCERREN)
 
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index a8de72b..940ef03 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -320,7 +320,7 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 		syscon |= (ENAWAKEUP | SIDLEMODE(0x02));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
-		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, XRDYEN | RRDYEN);
 	}
 }
 
@@ -331,15 +331,12 @@ static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 	 */
 	if (cpu_is_omap34xx()) {
 		u16 syscon;
-		u16 wakeupen;
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
 		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
-		wakeupen = OMAP_MCBSP_READ(mcbsp->io_base, WAKEUPEN);
-		wakeupen &= ~WAKEUPEN_ALL;
-		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, wakeupen);
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, 0);
 	}
 }
 #else
-- 
1.6.2.GIT

