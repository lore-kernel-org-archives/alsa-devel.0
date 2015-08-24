From: Qais Yousef <qais.yousef@imgtec.com>
Subject: [PATCH 02/10] dt: add img,axd.txt device tree binding document
Date: Mon, 24 Aug 2015 13:39:11 +0100
Message-ID: <1440419959-14315-3-git-send-email-qais.yousef@imgtec.com>
References: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440419959-14315-1-git-send-email-qais.yousef@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Qais Yousef <qais.yousef@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Qais Yousef <qais.yousef@imgtec.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../devicetree/bindings/sound/img,axd.txt          | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,axd.txt

diff --git a/Documentation/devicetree/bindings/sound/img,axd.txt b/Documentation/devicetree/bindings/sound/img,axd.txt
new file mode 100644
index 000000000000..6a8764a79d01
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,axd.txt
@@ -0,0 +1,34 @@
+* AXD Audio Processing IP Binding *
+
+Required properties:
+- compatible: "img,axd"
+- clocks: phandle for the clock that drives AXD.
+- interrupts: the GIC interrupt where AXD is connected
+- gic-irq: it takes two non-zero values, the first one is the host hwirq and
+           the second one is AXD's. Host's hwirq should match the value in
+           interrupts.
+
+Optional properties:
+- vpe: VPE number on which AXD should start. Must be provided if AXD is
+       running as a single VPE along Linux on the same core.
+       It can't be VPE0.
+       The VPE will be offlined before AXD is loaded.
+- inbuf-size: size of shared input buffers area. By default it's 0x7800 bytes.
+- outbuf-size: size of shared output buffers area. By default it's 0x3c000 bytes.
+
+
+Example:
+
+	axdclk: axdclk@400M {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <400000000>;
+	};
+
+	axd {
+		compatible = "img,axd";
+		clocks = <&axdclk>;
+		interrupts = <36 IRQ_TYPE_EDGE_RISING>;
+		gic-irq = <36 37>;
+		vpe = <1>;
+	};
-- 
2.1.0
