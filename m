From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 11/20] OMAP: McBSP: Retain McBSP FCLK
	clockactivity
Date: Tue, 11 Aug 2009 16:05:22 +0300
Message-ID: <1249995931-26015-12-git-send-email-eduardo.valentin__12963.4562334561$1249997908$gmane$org@nokia.com>
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
	<1249995931-26015-11-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249995931-26015-11-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

FCLK may get autogated so that it prevents the McBSP
to work properly. It is the bit 9 that must be set
for maintaining the McBSP FCLK.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
Acked-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    1 +
 arch/arm/plat-omap/mcbsp.c              |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 776ea4d..895f001 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -254,6 +254,7 @@
 #define RDISABLE		0x0001
 
 /********************** McBSP SYSCONFIG bit definitions ********************/
+#define CLOCKACTIVITY(value)	((value)<<8)
 #define SIDLEMODE(value)	((value)<<3)
 #define ENAWAKEUP		0x0004
 #define SOFTRST			0x0002
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 940ef03..e87c887 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -316,8 +316,8 @@ static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
 		u16 syscon;
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
-		syscon |= (ENAWAKEUP | SIDLEMODE(0x02));
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
+		syscon |= (ENAWAKEUP | SIDLEMODE(0x02) | CLOCKACTIVITY(0x02));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, XRDYEN | RRDYEN);
@@ -333,7 +333,7 @@ static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
 		u16 syscon;
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, 0);
-- 
1.6.2.GIT

