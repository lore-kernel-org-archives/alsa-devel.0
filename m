From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv2 09/20] OMAP: McBSP: Wakeups utilized
Date: Tue, 11 Aug 2009 16:05:20 +0300
Message-ID: <1249995931-26015-10-git-send-email-eduardo.valentin__44022.2037061632$1249998129$gmane$org@nokia.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-5-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-6-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-7-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-8-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
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

This patch enables the smart idle mode while
McBPS is being utilized. Once it's done,
force idle mode is taken instead. Apart of it,
it also configures what signals will wake mcbsp up.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |   17 +++++++++++
 arch/arm/plat-omap/mcbsp.c              |   46 +++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index 9b2b03e..2c5612a 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -138,6 +138,7 @@
 #define OMAP_MCBSP_REG_THRSH1	0x94
 #define OMAP_MCBSP_REG_IRQST	0xA0
 #define OMAP_MCBSP_REG_IRQEN	0xA4
+#define OMAP_MCBSP_REG_WAKEUPEN	0xA8
 #define OMAP_MCBSP_REG_XCCR	0xAC
 #define OMAP_MCBSP_REG_RCCR	0xB0
 
@@ -253,6 +254,8 @@
 #define RDISABLE		0x0001
 
 /********************** McBSP SYSCONFIG bit definitions ********************/
+#define SIDLEMODE(value)	((value)<<3)
+#define ENAWAKEUP		0x0004
 #define SOFTRST			0x0002
 
 /********************** McBSP DMA operating modes **************************/
@@ -260,6 +263,20 @@
 #define MCBSP_DMA_MODE_THRESHOLD	1
 #define MCBSP_DMA_MODE_FRAME		2
 
+/********************** McBSP WAKEUPEN bit definitions *********************/
+#define XEMPTYEOFEN		0x4000
+#define XRDYEN			0x0400
+#define XEOFEN			0x0200
+#define XFSXEN			0x0100
+#define XSYNCERREN		0x0080
+#define RRDYEN			0x0008
+#define REOFEN			0x0004
+#define RFSREN			0x0002
+#define RSYNCERREN		0x0001
+#define WAKEUPEN_ALL		(XEMPTYEOFEN | XRDYEN | XEOFEN | XFSXEN | \
+				 XSYNCERREN | RRDYEN | REOFEN | RFSREN | \
+				 RSYNCERREN)
+
 /* we don't do multichannel for now */
 struct omap_mcbsp_reg_cfg {
 	u16 spcr2;
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 23c1b1c..a8de72b 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -305,6 +305,46 @@ int omap_mcbsp_get_dma_op_mode(unsigned int id)
 	return dma_op_mode;
 }
 EXPORT_SYMBOL(omap_mcbsp_get_dma_op_mode);
+
+static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp)
+{
+	/*
+	 * Enable wakup behavior, smart idle and all wakeups
+	 * REVISIT: some wakeups may be unnecessary
+	 */
+	if (cpu_is_omap34xx()) {
+		u16 syscon;
+
+		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		syscon |= (ENAWAKEUP | SIDLEMODE(0x02));
+		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, WAKEUPEN_ALL);
+	}
+}
+
+static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp)
+{
+	/*
+	 * Disable wakup behavior, smart idle and all wakeups
+	 */
+	if (cpu_is_omap34xx()) {
+		u16 syscon;
+		u16 wakeupen;
+
+		syscon = OMAP_MCBSP_READ(mcbsp->io_base, SYSCON);
+		syscon &= ~(ENAWAKEUP | SIDLEMODE(0x03));
+		OMAP_MCBSP_WRITE(mcbsp->io_base, SYSCON, syscon);
+
+		wakeupen = OMAP_MCBSP_READ(mcbsp->io_base, WAKEUPEN);
+		wakeupen &= ~WAKEUPEN_ALL;
+		OMAP_MCBSP_WRITE(mcbsp->io_base, WAKEUPEN, wakeupen);
+	}
+}
+#else
+static inline void omap34xx_mcbsp_request(struct omap_mcbsp *mcbsp) {}
+static inline void omap34xx_mcbsp_free(struct omap_mcbsp *mcbsp) {}
 #endif
 
 /*
@@ -366,6 +406,9 @@ int omap_mcbsp_request(unsigned int id)
 	clk_enable(mcbsp->iclk);
 	clk_enable(mcbsp->fclk);
 
+	/* Do procedure specific to omap34xx arch, if applicable */
+	omap34xx_mcbsp_request(mcbsp);
+
 	/*
 	 * Make sure that transmitter, receiver and sample-rate generator are
 	 * not running before activating IRQs.
@@ -414,6 +457,9 @@ void omap_mcbsp_free(unsigned int id)
 	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
 		mcbsp->pdata->ops->free(id);
 
+	/* Do procedure specific to omap34xx arch, if applicable */
+	omap34xx_mcbsp_free(mcbsp);
+
 	clk_disable(mcbsp->fclk);
 	clk_disable(mcbsp->iclk);
 
-- 
1.6.2.GIT

