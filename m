From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCH 03/20] OMAP: McBSP: Change wakeup signals
Date: Thu, 30 Jul 2009 15:49:26 +0300
Message-ID: <1248958183-15015-4-git-send-email-eduardo.valentin__29318.9021562741$1248959257$gmane$org@nokia.com>
References: <1248958183-15015-1-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-2-git-send-email-eduardo.valentin@nokia.com>
	<1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1248958183-15015-3-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

Configure only XRDYEN and RRDYEN wakeup signals
in order to get better power consumption.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 758ad5c..89d1bea 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -264,9 +264,7 @@
 #define REOFEN			0x0004
 #define RFSREN			0x0002
 #define RSYNCERREN		0x0001
-#define WAKEUPEN_ALL		(XEMPTYEOFEN | XRDYEN | XEOFEN | XFSXEN | \
-				 XSYNCERREN | RRDYEN | REOFEN | RFSREN | \
-				 RSYNCERREN)
+#define WAKEUPEN_ALL		(XRDYEN | RRDYEN)
 
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
-- 
1.6.2.GIT

