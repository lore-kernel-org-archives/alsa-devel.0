From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 05/20] OMAP: McBSP: Retain McBSP FCLK
	clockactivity
Date: Thu, 30 Jul 2009 15:49:28 +0300
Message-ID: <1248958183-15015-6-git-send-email-eduardo.valentin__42163.0877689042$1248959285$gmane$org@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-4-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-5-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
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
index 57157b4..e3b300c 100644
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
index b64896b..6b39656 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -266,8 +266,8 @@ int omap_mcbsp_request(unsigned int id)
 		u16 syscon;
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
-		syscon |= (ENAWAKEUP | SIDLEMODE(0x02));
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
+		syscon |= (ENAWAKEUP | SIDLEMODE(0x02) | CLOCKACTIVITY(0x02));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
 		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
@@ -331,7 +331,7 @@ void omap_mcbsp_free(unsigned int id)
 		u16 syscon;
 
 		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
-		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03) | CLOCKACTIVITY(0x03));
 		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
 
 		wakeupen = OMAP_MCBSP_READ(mcbsp->io_base, WAKEUPEN);
-- 
1.6.2.GIT

