From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] slimbus: ngd: dt-bindings: Add slim ngd dt
	bindings
Date: Wed, 16 May 2018 17:51:17 +0100
Message-ID: <20180516165118.16551-2-srinivas.kandagatla@linaro.org>
References: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id A5AC8267332
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 18:54:07 +0200 (CEST)
Received: by mail-wr0-f196.google.com with SMTP id p5-v6so2167348wre.12
 for <alsa-devel@alsa-project.org>; Wed, 16 May 2018 09:54:07 -0700 (PDT)
In-Reply-To: <20180516165118.16551-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, girishm@quicinc.com, linux-arm-msm@vger.kernel.org, broonie@kernel.org, linux-kernel@vger.kernel.org, bgoswami@codeaurora.org, kramasub@codeaurora.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, sdharia@quicinc.com
List-Id: alsa-devel@alsa-project.org

This patch adds bindings for Qualcomm SLIMBus NGD controller found in
all new SoCs starting from B family.
SLIMBus NGD controller is a light-weight driver responsible for
communicating with SLIMBus slaves directly over the bus using messaging
interface and communicating with master component residing on ADSP for
bandwidth and data-channel management

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt

diff --git a/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
new file mode 100644
index 000000000000..c948fb098819
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
@@ -0,0 +1,70 @@
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
+	Definition: must be "qcom,slim-ngd"
+
+- reg:
+	Usage: required
+	Value type: <prop-encoded-array>
+	Definition: must specify the base address and size of the controller
+		    register blocks.
+
+- reg-names:
+	Usage: required
+	Value type: <stringlist>
+	Definition: must be "ctrl"
+
+- qcom,ngd-id
+	Usage: required
+	Value type: <u32>
+	Definition: ngd instance id in the controller
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
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+#size-cells
+	Usage: required
+	Refer to slimbus/bus.txt for details of the common SLIMBus bindings.
+
+= EXAMPLE
+
+slim@91c0000 {
+	compatible = "qcom,slim-ngd";
+	reg = <0x91c0000 0x2C000>;
+	reg-names = "ctrl";
+	interrupts = <0 163 0>;
+	qcom,ngd-id = <1>;
+	dmas =	<&slimbam 3>, <&slimbam 4>;
+	dma-names = "rx", "tx";
+
+	#address-cells = <1>;
+	#size-cells = <1>;
+	codec@1 {
+		compatible = "slim217,1a0";
+		reg  = <1 0>;
+	};
+};
-- 
2.16.2
