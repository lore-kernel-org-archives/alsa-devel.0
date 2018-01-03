From: srinivas.kandagatla@linaro.org
Subject: [PATCH] slimbus: qcom: add HAS_IOMEM dependency
Date: Wed,  3 Jan 2018 09:32:04 +0000
Message-ID: <20180103093204.24166-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: sdharia@codeaurora.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Below build failure was reported on UML,
ERROR: "devm_ioremap_resource" [drivers/slimbus/slim-qcom-ctrl.ko] undefined!
ERROR: "__ioread32_copy" [drivers/slimbus/slim-qcom-ctrl.ko] undefined!
ERROR: "__iowrite32_copy" [drivers/slimbus/slim-qcom-ctrl.ko] undefined!
ERROR: "devm_ioremap" [drivers/slimbus/slim-qcom-ctrl.ko] undefined!

This patch fixes it by making qcom slimbus depend on HAS_IOMEM, as
these are only defined when HAS_IOMEM is selected.

Reported-by: Thomas Meyer <thomas@m3y3r.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/slimbus/Kconfig b/drivers/slimbus/Kconfig
index 78bdd4808282..1a632fad597e 100644
--- a/drivers/slimbus/Kconfig
+++ b/drivers/slimbus/Kconfig
@@ -16,6 +16,7 @@ if SLIMBUS
 config SLIM_QCOM_CTRL
 	tristate "Qualcomm SLIMbus Manager Component"
 	depends on SLIMBUS
+	depends on HAS_IOMEM
 	help
 	  Select driver if Qualcomm's SLIMbus Manager Component is
 	  programmed using Linux kernel.
-- 
2.15.0
