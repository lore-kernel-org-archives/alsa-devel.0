From: srinivas.kandagatla@linaro.org
Subject: [PATCH v8 02/13] dt-bindings: Add SLIMbus bindings
Date: Thu, 30 Nov 2017 17:41:49 +0000
Message-ID: <20171130174200.6684-3-srinivas.kandagatla@linaro.org>
References: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, vinod.koul@intel.com, arnd@arndb.de, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia@codeaurora.org>

SLIMbus (Serial Low Power Interchip Media Bus) is a specification
developed by MIPI (Mobile Industry Processor Interface) alliance.
SLIMbus is a 2-wire implementation, which is used to communicate with
peripheral components like audio-codec.

This patch adds device tree bindings for the slimbus.

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/slimbus/bus.txt | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt

diff --git a/Documentation/devicetree/bindings/slimbus/bus.txt b/Documentation/devicetree/bindings/slimbus/bus.txt
new file mode 100644
index 000000000000..52fa6426388c
--- /dev/null
+++ b/Documentation/devicetree/bindings/slimbus/bus.txt
@@ -0,0 +1,50 @@
+SLIM(Serial Low Power Interchip Media Bus) bus
+
+SLIMbus is a 2-wire bus, and is used to communicate with peripheral
+components like audio-codec.
+
+Required property for SLIMbus controller node:
+- compatible	- name of SLIMbus controller
+
+Child nodes:
+Every SLIMbus controller node can contain zero or more child nodes
+representing slave devices on the bus. Every SLIMbus slave device is
+uniquely determined by the enumeration address containing 4 fields:
+Manufacturer ID, Product code, Device index, and Instance value for
+the device.
+If child node is not present and it is instantiated after device
+discovery (slave device reporting itself present).
+
+In some cases it may be necessary to describe non-probeable device
+details such as non-standard ways of powering up a device. In
+such cases, child nodes for those devices will be present as
+slaves of the SLIMbus controller, as detailed below.
+
+Required property for SLIMbus child node if it is present:
+- reg		- Should be ('Device index', 'Instance ID') from SLIMbus
+		  Enumeration  Address.
+		  Device Index Uniquely identifies multiple Devices within
+		  a single Component.
+		  Instance ID Is for the cases where multiple Devices of the
+		  same type or Class are attached to the bus.
+
+- compatible	-"slimMID,PID". The textual representation of Manufacturer ID,
+	 	  Product Code, shall be in lower case hexadecimal with leading
+		  zeroes suppressed
+
+SLIMbus example for Qualcomm's slimbus manager component:
+
+	slim@28080000 {
+		compatible = "qcom,apq8064-slim", "qcom,slim";
+		reg = <0x28080000 0x2000>,
+		interrupts = <0 33 0>;
+		clocks = <&lcc SLIMBUS_SRC>, <&lcc AUDIO_SLIMBUS_CLK>;
+		clock-names = "iface", "core";
+		#address-cells = <2>;
+		#size-cell = <0>;
+
+		codec: wcd9310@1,0{
+			compatible = "slim217,60";
+			reg = <1 0>;
+		};
+	};
-- 
2.15.0
