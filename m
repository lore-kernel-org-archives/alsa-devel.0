From: srinivas.kandagatla@linaro.org
Subject: [PATCH v4 03/14] mfd: wcd9335: add wcd irq support
Date: Sun, 16 Sep 2018 17:57:16 -0700
Message-ID: <20180917005727.32728-4-srinivas.kandagatla@linaro.org>
References: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917005727.32728-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, robh+dt@kernel.org, broonie@kernel.org
Cc: mark.rutland@arm.com, lgirdwood@gmail.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

WCD9335 supports two lines of irqs INTR1 and INTR2. Multiple interrupts
are muxed via these lines. INTR1 consists of all possible interrupt
sources like: Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA. INTR2 is a
subset of first interrupt sources like MAD, VBAT, and SVA

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/wcd9335-core.c          | 78 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/wcd9335/wcd9335.h | 36 +++++++++++++++++
 2 files changed, 114 insertions(+)

diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
index 81ec0fc..f4266f5 100644
--- a/drivers/mfd/wcd9335-core.c
+++ b/drivers/mfd/wcd9335-core.c
@@ -3,6 +3,7 @@
 
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/wcd9335/registers.h>
@@ -10,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/of_gpio.h>
 #include <linux/of.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -88,12 +90,71 @@ static struct regmap_config wcd9335_interface_regmap_config = {
 
 static struct wcd9335 *wcd_data;
 
+static const struct regmap_irq wcd9335_irqs[] = {
+	/* INTR_REG 0 */
+	REGMAP_IRQ_REG(WCD9335_IRQ_SLIMBUS, 0, BIT(0)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_FLL_LOCK_LOSS, 0, BIT(1)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_HPH_PA_OCPL_FAULT, 0, BIT(2)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_HPH_PA_OCPR_FAULT, 0, BIT(3)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_EAR_PA_OCP_FAULT, 0, BIT(4)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_HPH_PA_CNPL_COMPLETE, 0, BIT(5)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_HPH_PA_CNPR_COMPLETE, 0, BIT(6)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_EAR_PA_CNP_COMPLETE, 0, BIT(7)),
+	/* INTR_REG 1 */
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_SW_DET, 1, BIT(0)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_ELECT_INS_REM_DET, 1, BIT(1)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_BUTTON_PRESS_DET, 1, BIT(2)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_BUTTON_RELEASE_DET, 1, BIT(3)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MBHC_ELECT_INS_REM_LEG_DET, 1, BIT(4)),
+	/* INTR_REG 2 */
+	REGMAP_IRQ_REG(WCD9335_IRQ_LINE_PA1_CNP_COMPLETE, 2, BIT(0)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_LINE_PA2_CNP_COMPLETE, 2, BIT(1)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_LINE_PA3_CNP_COMPLETE, 2, BIT(2)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_LINE_PA4_CNP_COMPLETE, 2, BIT(3)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_SOUNDWIRE, 2, BIT(4)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_VDD_DIG_RAMP_COMPLETE, 2, BIT(5)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_RCO_ERROR, 2, BIT(6)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_SVA_ERROR, 2, BIT(7)),
+	/* INTR_REG 3 */
+	REGMAP_IRQ_REG(WCD9335_IRQ_MAD_AUDIO, 3, BIT(0)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MAD_BEACON, 3, BIT(1)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_MAD_ULTRASOUND, 3, BIT(2)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_VBAT_ATTACK, 3, BIT(3)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_VBAT_RESTORE, 3, BIT(4)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_SVA_OUTBOX1, 3, BIT(5)),
+	REGMAP_IRQ_REG(WCD9335_IRQ_SVA_OUTBOX2, 3, BIT(6)),
+};
+
+static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
+	.name = "wcd9335_pin1_irq",
+	.status_base = WCD9335_INTR_PIN1_STATUS0,
+	.mask_base = WCD9335_INTR_PIN1_MASK0,
+	.ack_base = WCD9335_INTR_PIN1_CLEAR0,
+	.type_base = WCD9335_INTR_LEVEL0,
+	.num_regs = 4,
+	.irqs = wcd9335_irqs,
+	.num_irqs = ARRAY_SIZE(wcd9335_irqs),
+};
+
 static int wcd9335_parse_resources(struct wcd9335 *ddata)
 {
 	struct device *dev = ddata->dev;
 	struct device_node *np = dev->of_node;
 	int ret;
 
+	/*
+	 * INTR1 consists of all possible interrupt sources Ear OCP,
+	 * HPH OCP, MBHC, MAD, VBAT, and SVA
+	 * INTR2 is a subset of first interrupt sources MAD, VBAT, and SVA
+	 */
+	ddata->irq = of_irq_get_byname(ddata->dev->of_node, "intr1");
+	if (ddata->irq < 0) {
+		if (ddata->irq != -EPROBE_DEFER)
+			dev_err(ddata->dev, "Unable to configure IRQ\n");
+
+		return ddata->irq;
+	}
+
 	ddata->reset_gpio = of_get_named_gpio(np,	"reset-gpios", 0);
 	if (ddata->reset_gpio < 0) {
 		dev_err(dev, "Reset GPIO missing from DT\n");
@@ -185,6 +246,19 @@ static int wcd9335_bring_up(struct wcd9335 *ddata)
 	return 0;
 }
 
+static int wcd9335_irq_init(struct wcd9335 *ddata)
+{
+	int ret;
+
+	ret = devm_regmap_add_irq_chip(ddata->dev, ddata->regmap, ddata->irq,
+				 IRQF_TRIGGER_HIGH, 0,
+				 &wcd9335_regmap_irq1_chip, &ddata->irq_data);
+	if (ret)
+		dev_err(ddata->dev, "Failed to register IRQ chip: %d\n", ret);
+
+	return ret;
+}
+
 static int wcd9335_slim_status(struct slim_device *sdev,
 			       enum slim_device_status status)
 {
@@ -283,6 +357,10 @@ static int wcd9335_slim_probe(struct slim_device *slim)
 		return ret;
 	}
 
+	ret = wcd9335_irq_init(ddata);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
diff --git a/include/linux/mfd/wcd9335/wcd9335.h b/include/linux/mfd/wcd9335/wcd9335.h
index f5ccacf..38e85e2 100644
--- a/include/linux/mfd/wcd9335/wcd9335.h
+++ b/include/linux/mfd/wcd9335/wcd9335.h
@@ -10,6 +10,38 @@
 #define WCD9335_VERSION_2_0     2
 #define WCD9335_MAX_SUPPLY	5
 
+#define	WCD9335_IRQ_SLIMBUS			0
+#define	WCD9335_IRQ_FLL_LOCK_LOSS		1
+#define	WCD9335_IRQ_HPH_PA_OCPL_FAULT		2
+#define	WCD9335_IRQ_HPH_PA_OCPR_FAULT		3
+#define	WCD9335_IRQ_EAR_PA_OCP_FAULT		4
+#define	WCD9335_IRQ_HPH_PA_CNPL_COMPLETE	5
+#define	WCD9335_IRQ_HPH_PA_CNPR_COMPLETE	6
+#define	WCD9335_IRQ_EAR_PA_CNP_COMPLETE		7
+#define	WCD9335_IRQ_MBHC_SW_DET			8
+#define	WCD9335_IRQ_MBHC_ELECT_INS_REM_DET	9
+#define	WCD9335_IRQ_MBHC_BUTTON_PRESS_DET	10
+#define	WCD9335_IRQ_MBHC_BUTTON_RELEASE_DET	11
+#define	WCD9335_IRQ_MBHC_ELECT_INS_REM_LEG_DET	12
+#define	WCD9335_IRQ_RESERVED_0			13
+#define	WCD9335_IRQ_RESERVED_1			14
+#define	WCD9335_IRQ_RESERVED_2			15
+#define	WCD9335_IRQ_LINE_PA1_CNP_COMPLETE	16
+#define	WCD9335_IRQ_LINE_PA2_CNP_COMPLETE	17
+#define	WCD9335_IRQ_LINE_PA3_CNP_COMPLETE	18
+#define	WCD9335_IRQ_LINE_PA4_CNP_COMPLETE	19
+#define	WCD9335_IRQ_SOUNDWIRE			20
+#define	WCD9335_IRQ_VDD_DIG_RAMP_COMPLETE	21
+#define	WCD9335_IRQ_RCO_ERROR			22
+#define	WCD9335_IRQ_SVA_ERROR			23
+#define	WCD9335_IRQ_MAD_AUDIO			24
+#define	WCD9335_IRQ_MAD_BEACON			25
+#define	WCD9335_IRQ_MAD_ULTRASOUND		26
+#define	WCD9335_IRQ_VBAT_ATTACK			27
+#define	WCD9335_IRQ_VBAT_RESTORE		28
+#define	WCD9335_IRQ_SVA_OUTBOX1			29
+#define	WCD9335_IRQ_SVA_OUTBOX2			30
+
 enum wcd_interface_type {
 	WCD9335_INTERFACE_TYPE_SLIMBUS = 1,
 	WCD9335_INTERFACE_TYPE_I2C,
@@ -18,6 +50,7 @@ enum wcd_interface_type {
 /**
  * struct wcd9335 - wcd9335 device handle.
  * @version: Version of codec chip
+ * @irq: interrupt number
  * @reset_gpio: rest gpio
  * @intf_type: Interface type, which can be SLIMBUS or I2C
  * @dev: wcd9335 evice instance
@@ -26,10 +59,12 @@ enum wcd_interface_type {
  * @slim_interface_dev: wcd9335 slim interface device handle
  * @regmap: wcd9335 slim device regmap
  * @interface_dev_regmap: wcd9335 interface device regmap.
+ * @irq_data: IRQ chip data.
  * @supplies: voltage supplies required for wcd9335
  */
 struct wcd9335 {
 	int version;
+	int irq;
 	int reset_gpio;
 	enum wcd_interface_type intf_type;
 	struct device *dev;
@@ -39,6 +74,7 @@ struct wcd9335 {
 	struct slim_device *slim_interface_dev;
 	struct regmap *regmap;
 	struct regmap *interface_dev_regmap;
+	struct regmap_irq_chip_data *irq_data;
 	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
 };
 
-- 
2.9.3
