From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 02/20] OMAP: McBSP: Add IRQEN, IRQSTATUS,
	THRESHOLD2 and THRESHOLD1 registers.
Date: Tue, 11 Aug 2009 16:05:13 +0300
Message-ID: <1249995931-26015-3-git-send-email-eduardo.valentin__10977.3821234286$1249997840$gmane$org@nokia.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
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

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 77191c5..51908fb 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -134,6 +134,10 @@
 #define OMAP_MCBSP_REG_XCERG	0x74
 #define OMAP_MCBSP_REG_XCERH	0x78
 #define OMAP_MCBSP_REG_SYSCON	0x8C
+#define OMAP_MCBSP_REG_THRSH2	0x90
+#define OMAP_MCBSP_REG_THRSH1	0x94
+#define OMAP_MCBSP_REG_IRQST	0xA0
+#define OMAP_MCBSP_REG_IRQEN	0xA4
 #define OMAP_MCBSP_REG_XCCR	0xAC
 #define OMAP_MCBSP_REG_RCCR	0xB0
 
-- 
1.6.2.GIT

