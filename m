From: srinivas.kandagatla@linaro.org
Subject: [PATCH v7 02/13] dt-bindings: Add SLIMbus bindings
Date: Wed, 15 Nov 2017 14:10:32 +0000
Message-ID: <20171115141043.29202-3-srinivas.kandagatla@linaro.org>
References: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 91FE82675BB
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 15:13:27 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id g141so3282385wmg.2
 for <alsa-devel@alsa-project.org>; Wed, 15 Nov 2017 06:13:27 -0800 (PST)
In-Reply-To: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

From: Sagar Dharia <sdharia@codeaurora.org>

SLIMbus (Serial Low Power Interchip Media Bus) is a specification
developed by MIPI (Mobile Industry Processor Interface) alliance.
SLIMbus is a 2-wire implementation, which is used to communicate with
peripheral components like audio-codec.

This patch adds device tree bindings for the slimbus.

Signed-off-by: Sagar Dharia <sdharia@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/slimbus/bus.txt | 50 +++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt

diff --git a/Documentation/devicetree/bindings/slimbus/bus.txt b/Documentation/devicetree/bindings/slimbus/bus.txt
new file mode 100644
index 000000000000..413b5076858e
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
+slaves of the slimbus-controller, as detailed below.
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
