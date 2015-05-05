From: Bard Liao <bardliao@realtek.com>
Subject: [PATCH 3/3] ASoC: rt5645: add device tree support
Date: Tue, 5 May 2015 21:42:02 +0800
Message-ID: <1430833322-13531-3-git-send-email-bardliao@realtek.com>
References: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id A4CEA261AF7
 for <alsa-devel@alsa-project.org>; Tue,  5 May 2015 15:42:14 +0200 (CEST)
In-Reply-To: <1430833322-13531-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, zhengxing@rock-chips.com, yang.a.fang@intel.com, koro.chen@mediatek.com, john.lin@realtek.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

Modify the RT5645 driver to parse platform data from device tree.
Write a DT binding document to describe those properties.

Signed-off-by: Bard Liao <bardliao@realtek.com>
---
 Documentation/devicetree/bindings/sound/rt5645.txt | 72 ++++++++++++++++++++++
 sound/soc/codecs/rt5645.c                          | 35 +++++++++++
 2 files changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5645.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5645.txt b/Documentation/devicetree/bindings/sound/rt5645.txt
new file mode 100644
index 0000000..f676c22
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5645.txt
@@ -0,0 +1,72 @@
+RT5650/RT5645 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : One of "realtek,rt5645" or "realtek,rt5650".
+
+- reg : The I2C address of the device.
+
+- interrupts : The CODEC's interrupt output.
+
+Optional properties:
+
+- realtek,in2-differential
+  Boolean. Indicate MIC2 input are differential, rather than single-ended.
+
+- realtek,dmic1-data-pin
+  0: dmic1 is not used
+  1: using IN2P pin as dmic1 data pin
+  2: using GPIO6 pin as dmic1 data pin
+  3: using GPIO10 pin as dmic1 data pin
+  4: using GPIO12 pin as dmic1 data pin
+
+- realtek,dmic2-data-pin
+  0: dmic2 is not used
+  1: using IN2N pin as dmic2 data pin
+  2: using GPIO5 pin as dmic2 data pin
+  3: using GPIO11 pin as dmic2 data pin
+
+- realtek,hp-det-gpio : The GPIO that indicate a JD event is triggered.
+
+- realtek,gpio-hp_det-active_high
+  Boolean. Indicate if hp-det-gpio is active high or not.
+
+-- realtek,jd-mode : The JD mode of rt5645/rt5650
+   0 : rt5645/rt5650 JD function is not used
+   1 : Mode-0 (VDD=3.3V), two port jack detection
+   2 : Mode-1 (VDD=3.3V), one port jack detection
+   3 : Mode-2 (VDD=1.8V), one port jack detection
+
+Pins on the device (for linking into audio routes) for RT5645/RT5650:
+
+  * DMIC L1
+  * DMIC R1
+  * DMIC L2
+  * DMIC R2
+  * IN1P
+  * IN1N
+  * IN2P
+  * IN2N
+  * Haptic Generator
+  * HPOL
+  * HPOR
+  * LOUTL
+  * LOUTR
+  * PDM1L
+  * PDM1R
+  * SPOL
+  * SPOR
+
+Example:
+
+codec: rt5650@1a {
+	compatible = "realtek,rt5650";
+	reg = <0x1a>;
+	interrupt-parent = <&gpio>;
+	interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	realtek,dmic-en = "true";
+	realtek,en-jd-func = "true";
+	realtek,jd-mode = <3>;
+};
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index e435680..36e22b6 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3134,6 +3134,37 @@ static struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{ }
 };
 
+static int rt5645_parse_dt(struct rt5645_priv *rt5645, struct device_node *np)
+{
+	rt5645->pdata.in2_diff = of_property_read_bool(np,
+		"realtek,in2-differential");
+	of_property_read_u32(np,
+		"realtek,dmic1-data-pin", &rt5645->pdata.dmic1_data_pin);
+	of_property_read_u32(np,
+		"realtek,dmic2-data-pin", &rt5645->pdata.dmic2_data_pin);
+	rt5645->pdata.hp_det_gpio = of_get_named_gpio(np,
+		"realtek,hp-det-gpio", 0);
+	rt5645->pdata.gpio_hp_det_active_high = of_property_read_bool(np,
+		"realtek,gpio-hp_det-active_high");
+	of_property_read_u32(np,
+		"realtek,jd-mode", &rt5645->pdata.jd_mode);
+	/*
+	 * HP_DET_GPIO is optional (it may be statically tied on the board).
+	 * -ENOENT means that the property doesn't exist, i.e. there is no
+	 * GPIO, so is not an error. Any other error code means the property
+	 * exists, but could not be parsed.
+	 */
+
+	if (!rt5645->pdata.hp_det_gpio)
+			rt5645->pdata.hp_det_gpio = -EINVAL;
+
+	if (!gpio_is_valid(rt5645->pdata.hp_det_gpio) &&
+			(rt5645->pdata.hp_det_gpio != -ENOENT))
+		return rt5645->pdata.hp_det_gpio;
+
+	return 0;
+}
+
 static int rt5645_i2c_probe(struct i2c_client *i2c,
 		    const struct i2c_device_id *id)
 {
@@ -3153,6 +3184,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 
 	if (pdata) {
 		rt5645->pdata = *pdata;
+	} else if (i2c->dev.of_node) {
+		ret = rt5645_parse_dt(rt5645, i2c->dev.of_node);
+		if (ret)
+			return ret;
 	} else {
 		if (dmi_check_system(dmi_platform_intel_braswell)) {
 			rt5645->pdata = *rt5645_pdata;
-- 
1.8.1.1.439.g50a6b54
