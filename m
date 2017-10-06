From: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [Patch v6 5/7] slimbus: qcom: Add runtime-pm support using clock-pause feature
Date: Fri,  6 Oct 2017 17:51:34 +0200
Message-ID: <20171006155136.4682-6-srinivas.kandagatla@linaro.org>
References: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171006155136.4682-1-srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, gong.chen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kheitke-hxvC4TZJLZFWk0Htik3J/w@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

Slimbus HW mandates that clock-pause sequence has to be executed
before disabling relevant interface and core clocks.
Runtime-PM's autosuspend feature is used here to enter/exit low
power mode for Qualcomm's Slimbus controller. Autosuspend feature
enables driver to avoid changing power-modes too frequently since
entering clock-pause is an expensive sequence

Signed-off-by: Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/slimbus/slim-qcom-ctrl.c | 128 +++++++++++++++++++++++++++++++++++++--
 drivers/slimbus/slim-qcom.h      |   1 +
 2 files changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/slimbus/slim-qcom-ctrl.c b/drivers/slimbus/slim-qcom-ctrl.c
index d0574e1..05ba44f 100644
--- a/drivers/slimbus/slim-qcom-ctrl.c
+++ b/drivers/slimbus/slim-qcom-ctrl.c
@@ -21,6 +21,7 @@
 #include <linux/of.h>
 #include <linux/dma-mapping.h>
 #include <linux/slimbus.h>
+#include <linux/pm_runtime.h>
 #include "slim-qcom.h"
 
 #define MSM_SLIM_NAME	"msm_slim_ctrl"
@@ -217,6 +218,30 @@ static irqreturn_t msm_slim_interrupt(int irq, void *d)
 	return ret;
 }
 
+static int msm_clk_pause_wakeup(struct slim_controller *ctrl)
+{
+	struct msm_slim_ctrl *dev = slim_get_ctrldata(ctrl);
+
+	clk_prepare_enable(dev->hclk);
+	clk_prepare_enable(dev->rclk);
+	enable_irq(dev->irq);
+
+	writel_relaxed(1, dev->base + FRM_WAKEUP);
+	/* Make sure framer wakeup write goes through before ISR fires */
+	mb();
+	/**
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
 static int msm_xfer_msg(struct slim_controller *ctrl, struct slim_msg_txn *txn,
 			void *pbuf)
 {
@@ -286,7 +311,6 @@ static int msm_set_laddr(struct slim_controller *ctrl,
 	 */
 	msg.wbuf = buf;
 	msg.num_bytes = 7;
-
 	ret = slim_processtxn(&dev->ctrl, &txn);
 
 	if (ret)
@@ -417,6 +441,8 @@ static int msm_slim_probe(struct platform_device *pdev)
 
 	dev->ctrl.set_laddr = msm_set_laddr;
 	dev->ctrl.xfer_msg = msm_xfer_msg;
+	dev->ctrl.wakeup =  msm_clk_pause_wakeup;
+
 	dev->ctrl.tx.n = MSM_TX_MSGS;
 	dev->ctrl.rx.n = MSM_RX_MSGS;
 	dev->ctrl.tx.sl_sz = SLIM_MSGQ_BUF_LEN;
@@ -532,6 +558,12 @@ static int msm_slim_probe(struct platform_device *pdev)
 	 */
 	mb();
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, MSM_SLIM_AUTOSUSPEND);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
 	dev_dbg(dev->dev, "MSM SB controller is up:ver:0x%x!\n", dev->ver);
 	return 0;
 
@@ -562,14 +594,101 @@ static int msm_slim_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, (ctrl->tx.sl_sz * ctrl->tx.n),
 			  ctrl->tx.base, ctrl->tx.phy);
 
-	disable_irq(dev->irq);
-	clk_disable_unprepare(dev->rclk);
-	clk_disable_unprepare(dev->hclk);
+	pm_runtime_disable(&pdev->dev);
 	slim_del_controller(&dev->ctrl);
 	destroy_workqueue(dev->rxwq);
 	return 0;
 }
 
+/**
+ * If PM_RUNTIME is not defined, these 2 functions become helper
+ * functions to be called from system suspend/resume.
+ */
+#ifdef CONFIG_PM
+static int msm_slim_runtime_suspend(struct device *device)
+{
+	struct platform_device *pdev = to_platform_device(device);
+	struct msm_slim_ctrl *dev = platform_get_drvdata(pdev);
+	int ret;
+
+	dev_dbg(device, "pm_runtime: suspending...\n");
+	ret = slim_ctrl_clk_pause(&dev->ctrl, false, SLIM_CLK_UNSPECIFIED);
+	if (ret) {
+		dev_err(device, "clk pause not entered:%d", ret);
+	} else {
+		disable_irq(dev->irq);
+		clk_disable_unprepare(dev->hclk);
+		clk_disable_unprepare(dev->rclk);
+	}
+	return ret;
+}
+
+static int msm_slim_runtime_resume(struct device *device)
+{
+	struct platform_device *pdev = to_platform_device(device);
+	struct msm_slim_ctrl *dev = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	dev_dbg(device, "pm_runtime: resuming...\n");
+	ret = slim_ctrl_clk_pause(&dev->ctrl, true, 0);
+	if (ret)
+		dev_err(device, "clk pause not exited:%d", ret);
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM_SLEEP
+static int msm_slim_suspend(struct device *dev)
+{
+	int ret = 0;
+
+	if (!pm_runtime_enabled(dev) ||
+		(!pm_runtime_suspended(dev))) {
+		dev_dbg(dev, "system suspend");
+		ret = msm_slim_runtime_suspend(dev);
+	}
+	if (ret == -EISCONN) {
+	/**
+	 * If the clock pause failed due to active channels, there is
+	 * a possibility that some audio stream is active during suspend.
+	 * (e.g. modem usecase during suspend)
+	 * We dont want to return suspend failure in that case so that
+	 * display and relevant components can still go to suspend.
+	 * If there is some other error, then it should prevent
+	 * system level suspend
+	 */
+		ret = 0;
+	}
+	return ret;
+}
+
+static int msm_slim_resume(struct device *dev)
+{
+	if (!pm_runtime_enabled(dev) || !pm_runtime_suspended(dev)) {
+		int ret;
+
+		dev_dbg(dev, "system resume");
+		ret = msm_slim_runtime_resume(dev);
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
+static const struct dev_pm_ops msm_slim_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(msm_slim_suspend, msm_slim_resume)
+	SET_RUNTIME_PM_OPS(
+			   msm_slim_runtime_suspend,
+			   msm_slim_runtime_resume,
+			   NULL
+	)
+};
+
 static const struct of_device_id msm_slim_dt_match[] = {
 	{
 		.compatible = "qcom,slim",
@@ -584,6 +703,7 @@ static struct platform_driver msm_slim_driver = {
 		.name = MSM_SLIM_NAME,
 		.owner = THIS_MODULE,
 		.of_match_table = msm_slim_dt_match,
+		.pm = &msm_slim_dev_pm_ops,
 	},
 };
 module_platform_driver(msm_slim_driver);
diff --git a/drivers/slimbus/slim-qcom.h b/drivers/slimbus/slim-qcom.h
index 0ad59c3..8b1d649 100644
--- a/drivers/slimbus/slim-qcom.h
+++ b/drivers/slimbus/slim-qcom.h
@@ -23,6 +23,7 @@
 		((l) | ((mt) << 5) | ((mc) << 8) | ((dt) << 15) | ((ad) << 16))
 
 #define SLIM_ROOT_FREQ 24576000
+#define MSM_SLIM_AUTOSUSPEND 1000
 
 /* MAX message size over control channel */
 #define SLIM_MSGQ_BUF_LEN	40
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
