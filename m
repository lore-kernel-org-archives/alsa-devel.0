From: srinivas.kandagatla@linaro.org
Subject: [PATCH v7 12/13] slimbus: qcom: Add runtime-pm support using clock-pause
Date: Wed, 15 Nov 2017 14:10:42 +0000
Message-ID: <20171115141043.29202-13-srinivas.kandagatla@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia@codeaurora.org>

Slimbus HW mandates that clock-pause sequence has to be executed
before disabling relevant interface and core clocks.
Runtime-PM's autosuspend feature is used here to enter/exit low
power mode for Qualcomm's Slimbus controller. Autosuspend feature
enables driver to avoid changing power-modes too frequently since
entering clock-pause is an expensive sequence

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ctrl.c | 113 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 3 deletions(-)

diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
index 25c1974f04ec..38340b104db4 100644
--- a/drivers/slimbus/qcom-ctrl.c
+++ b/drivers/slimbus/qcom-ctrl.c
@@ -20,6 +20,7 @@
 #include <linux/clk.h>
 #include <linux/of.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
 #include "slimbus.h"
 
 /* Manager registers */
@@ -71,6 +72,7 @@
 		((l) | ((mt) << 5) | ((mc) << 8) | ((dt) << 15) | ((ad) << 16))
 
 #define SLIM_ROOT_FREQ 24576000
+#define QCOM_SLIM_AUTOSUSPEND 1000
 
 /* MAX message size over control channel */
 #define SLIM_MSGQ_BUF_LEN	40
@@ -295,6 +297,30 @@ static irqreturn_t qcom_slim_interrupt(int irq, void *d)
 	return ret;
 }
 
+static int qcom_clk_pause_wakeup(struct slim_controller *sctrl)
+{
+	struct qcom_slim_ctrl *ctrl = dev_get_drvdata(sctrl->dev);
+
+	clk_prepare_enable(ctrl->hclk);
+	clk_prepare_enable(ctrl->rclk);
+	enable_irq(ctrl->irq);
+
+	writel_relaxed(1, ctrl->base + FRM_WAKEUP);
+	/* Make sure framer wakeup write goes through before ISR fires */
+	mb();
+	/*
+	 * HW Workaround: Currently, slave is reporting lost-sync messages
+	 * after slimbus comes out of clock pause.
+	 * Transaction with slave fail before slave reports that message
+	 * Give some time for that report to come
+	 * Slimbus wakes up in clock gear 10 at 24.576MHz. With each superframe
+	 * being 250 usecs, we wait for 5-10 superframes here to ensure
+	 * we get the message
+	 */
+	usleep_range(1250, 2500);
+	return 0;
+}
+
 void *slim_alloc_txbuf(struct qcom_slim_ctrl *ctrl, struct slim_msg_txn *txn,
 		       struct completion *done)
 {
@@ -540,6 +566,7 @@ static int qcom_slim_probe(struct platform_device *pdev)
 
 	sctrl->set_laddr = qcom_set_laddr;
 	sctrl->xfer_msg = qcom_xfer_msg;
+	sctrl->wakeup =  qcom_clk_pause_wakeup;
 	ctrl->tx.n = QCOM_TX_MSGS;
 	ctrl->tx.sl_sz = SLIM_MSGQ_BUF_LEN;
 	ctrl->rx.n = QCOM_RX_MSGS;
@@ -647,14 +674,93 @@ static int qcom_slim_remove(struct platform_device *pdev)
 {
 	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
 
-	disable_irq(ctrl->irq);
-	clk_disable_unprepare(ctrl->hclk);
-	clk_disable_unprepare(ctrl->rclk);
+	pm_runtime_disable(&pdev->dev);
 	slim_unregister_controller(&ctrl->ctrl);
 	destroy_workqueue(ctrl->rxwq);
 	return 0;
 }
 
+/*
+ * If PM_RUNTIME is not defined, these 2 functions become helper
+ * functions to be called from system suspend/resume.
+ */
+#ifdef CONFIG_PM
+static int qcom_slim_runtime_suspend(struct device *device)
+{
+	struct platform_device *pdev = to_platform_device(device);
+	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
+	int ret;
+
+	dev_dbg(device, "pm_runtime: suspending...\n");
+	ret = slim_ctrl_clk_pause(&ctrl->ctrl, false, SLIM_CLK_UNSPECIFIED);
+	if (ret) {
+		dev_err(device, "clk pause not entered:%d", ret);
+	} else {
+		disable_irq(ctrl->irq);
+		clk_disable_unprepare(ctrl->hclk);
+		clk_disable_unprepare(ctrl->rclk);
+	}
+	return ret;
+}
+
+static int qcom_slim_runtime_resume(struct device *device)
+{
+	struct platform_device *pdev = to_platform_device(device);
+	struct qcom_slim_ctrl *ctrl = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	dev_dbg(device, "pm_runtime: resuming...\n");
+	ret = slim_ctrl_clk_pause(&ctrl->ctrl, true, 0);
+	if (ret)
+		dev_err(device, "clk pause not exited:%d", ret);
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int qcom_slim_suspend(struct device *dev)
+{
+	int ret = 0;
+
+	if (!pm_runtime_enabled(dev) ||
+		(!pm_runtime_suspended(dev))) {
+		dev_dbg(dev, "system suspend");
+		ret = qcom_slim_runtime_suspend(dev);
+	}
+
+	/*
+	 * If the clock pause failed due to active channels, there is
+	 * a possibility that some audio stream is active during suspend.
+	 * (e.g. modem usecase during suspend)
+	 * We dont want to return suspend failure in that case so that
+	 * display and relevant components can still go to suspend.
+	 * If there is some other error, then it should prevent
+	 * system level suspend
+	 */
+	if (ret == -EISCONN)
+		ret = 0;
+
+	return ret;
+}
+
+static int qcom_slim_resume(struct device *dev)
+{
+	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
+		int ret;
+
+		dev_dbg(dev, "system resume");
+		ret = qcom_slim_runtime_resume(dev);
+		if (!ret) {
+			pm_runtime_mark_last_busy(dev);
+			pm_request_autosuspend(dev);
+		}
+		return ret;
+
+	}
+	return 0;
+}
+#endif /* CONFIG_PM_SLEEP */
+
 static const struct dev_pm_ops qcom_slim_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(qcom_slim_suspend, qcom_slim_resume)
 	SET_RUNTIME_PM_OPS(
@@ -676,6 +782,7 @@ static struct platform_driver qcom_slim_driver = {
 	.driver	= {
 		.name = "qcom_slim_ctrl",
 		.of_match_table = qcom_slim_dt_match,
+		.pm = &qcom_slim_dev_pm_ops,
 	},
 };
 module_platform_driver(qcom_slim_driver);
-- 
2.15.0
