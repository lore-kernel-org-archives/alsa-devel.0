From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: [PATCHv5 04/20] OMAP: McBSP: Add transmit/receive
	threshold handler
Date: Thu, 20 Aug 2009 16:18:10 +0300
Message-ID: <1250774306-7581-4-git-send-email-eduardo.valentin__32587.1766116054$1250775288$gmane$org@nokia.com>
References: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1250774306-7581-1-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, Linux-OMAP <linux-omap@vger.kernel.org>, ALSA-Devel <alsa-devel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Eduardo Valentin <eduardo.valentin@nokia.com>

This patch adds a way to handle transmit/receive threshold.
It export to mcbsp users a callback registration procedure.

Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
---
 arch/arm/plat-omap/include/mach/mcbsp.h |    9 +++++
 arch/arm/plat-omap/mcbsp.c              |   50 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h b/arch/arm/plat-omap/include/mach/mcbsp.h
index ceaf9ee..2544aa5 100644
--- a/arch/arm/plat-omap/include/mach/mcbsp.h
+++ b/arch/arm/plat-omap/include/mach/mcbsp.h
@@ -389,6 +389,15 @@ int omap_mcbsp_init(void);
 void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
 					int size);
 void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg * config);
+#ifdef CONFIG_ARCH_OMAP34XX
+void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold);
+void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold);
+#else
+static inline void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
+{ }
+static inline void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
+{ }
+#endif
 int omap_mcbsp_request(unsigned int id);
 void omap_mcbsp_free(unsigned int id);
 void omap_mcbsp_start(unsigned int id, int tx, int rx);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e9dd703..081f2ea 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -198,6 +198,56 @@ void omap_mcbsp_config(unsigned int id, const struct omap_mcbsp_reg_cfg *config)
 }
 EXPORT_SYMBOL(omap_mcbsp_config);
 
+#ifdef CONFIG_ARCH_OMAP34XX
+/*
+ * omap_mcbsp_set_tx_threshold configures how to deal
+ * with transmit threshold. the threshold value and handler can be
+ * configure in here.
+ */
+void omap_mcbsp_set_tx_threshold(unsigned int id, u16 threshold)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+
+	OMAP_MCBSP_WRITE(io_base, THRSH2, threshold);
+}
+EXPORT_SYMBOL(omap_mcbsp_set_tx_threshold);
+
+/*
+ * omap_mcbsp_set_rx_threshold configures how to deal
+ * with receive threshold. the threshold value and handler can be
+ * configure in here.
+ */
+void omap_mcbsp_set_rx_threshold(unsigned int id, u16 threshold)
+{
+	struct omap_mcbsp *mcbsp;
+	void __iomem *io_base;
+
+	if (!cpu_is_omap34xx())
+		return;
+
+	if (!omap_mcbsp_check_valid_id(id)) {
+		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
+		return;
+	}
+	mcbsp = id_to_mcbsp_ptr(id);
+	io_base = mcbsp->io_base;
+
+	OMAP_MCBSP_WRITE(io_base, THRSH1, threshold);
+}
+EXPORT_SYMBOL(omap_mcbsp_set_rx_threshold);
+#endif
+
 /*
  * We can choose between IRQ based or polled IO.
  * This needs to be called before omap_mcbsp_request().
-- 
1.6.2.GIT

