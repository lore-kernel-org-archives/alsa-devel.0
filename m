From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 4/5] slimbus: ngd: dt-bindings: Add slim ngd
	dt bindings
Date: Tue, 19 Jun 2018 17:13:00 +0100
Message-ID: <20180619161301.4556-5-srinivas.kandagatla@linaro.org>
References: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2D4FC266D4C
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 18:13:10 +0200 (CEST)
Received: by mail-wr0-f193.google.com with SMTP id l10-v6so258410wrn.2
 for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2018 09:13:10 -0700 (PDT)
In-Reply-To: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org, kramasub@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org

This patch adds bindings for Qualcomm SLIMBus NGD controller.
SLIMBus NGD controller is a light-weight driver responsible for
communicating with SLIMBus slaves directly over the bus using messaging
interface and communicating with master component residing on ADSP for
bandwidth and data-channel management

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Tested-by: Craig Tatlor <ctatlor97@gmail.com>
Reviewed-by: Vinod Koul <vkoul@kernel.org>
---
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 84 ++++++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
new file mode 100644
index 000000000000..e94a2ad3a710
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
@@ -0,0 +1,84 @@
+Qualcomm SLIMBus Non Generic Device (NGD) Controller binding
+
+SLIMBus NGD controller is a light-weight driver responsible for communicating
+with SLIMBus slaves directly over the bus using messaging interface and
+communicating with master component residing on ADSP for bandwidth and
+data-channel management
+
+Please refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+- compatible:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "qcom,slim-ngd-v<MAJOR>.<MINOR>.<STEP>"
+	must be one of the following.
+	"qcom,slim-ngd-v1.5.0" for MSM8996
+	"qcom,slim-ngd-v2.1.0" for SDM845
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must specify the base address and size of the controller
+		    register space.
+- dmas
+	Usage: required
+	Value type: <array of phandles>
+	Definition: List of rx and tx dma channels
+
+- dma-names
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "rx" and "tx".
+
+- interrupts:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must list controller IRQ.
+
+#address-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Should be 1, reflecting the instance id of ngd.
+
+#size-cells
+	Usage: required
+	Value type: <u32>
+	Definition: Should be 0
+
+= NGD Devices
+Each subnode represents an instance of NGD, must contain the following
+properties:
+
+- reg:
+	Usage: required
+	Value type: <u32>
+	Definition: Should be instance id of ngd.
+
+#address-cells
+	Usage: required
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+#size-cells
+	Usage: required
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+= EXAMPLE
+
+slim@91c0000 {
+	compatible = "qcom,slim-ngd-v1.5.0";
+	reg = <0x91c0000 0x2c000>;
+	interrupts = <0 163 0>;
+	dmas =	<&slimbam 3>, <&slimbam 4>;
+	dma-names = "rx", "tx";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	ngd@1 {
+		reg = <1>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		codec@1 {
+			compatible = "slim217,1a0";
+			reg  = <1 0>;
+		};
+	};
+};
-- 
2.16.2
