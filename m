From: <paul.handrigan@cirrus.com>
Subject: [PATCH v2 2/2] ASoC: cs35l33: Add device tree bindings
	file for cs35l33
Date: Thu, 14 Apr 2016 17:22:04 -0500
Message-ID: <1460672524-27855-2-git-send-email-paul.handrigan@cirrus.com>
References: <1460672524-27855-1-git-send-email-paul.handrigan@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 97EB6260870
 for <alsa-devel@alsa-project.org>; Fri, 15 Apr 2016 00:21:39 +0200 (CEST)
In-Reply-To: <1460672524-27855-1-git-send-email-paul.handrigan@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, brian.austin@cirrus.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, robh+dt@kernel.org, broonie@kernel.org, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

From: Paul Handrigan <Paul.Handrigan@cirrus.com>

Add device tree bindings file for the cs35l33 8V boosted
class D amplifier.

Signed-off-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 .../devicetree/bindings/sound/cs35l33.txt          | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs35l33.txt

diff --git a/Documentation/devicetree/bindings/sound/cs35l33.txt b/Documentation/devicetree/bindings/sound/cs35l33.txt
new file mode 100644
index 0000000..434250c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs35l33.txt
@@ -0,0 +1,69 @@
+CS35L33 Speaker Amplifier
+
+Required properties:
+
+  - compatible : "cirrus,cs35l33"
+
+  - reg : the I2C address of the device for I2C
+
+  - VA-supply, VP-supply : power supplies for the device,
+    as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Optional properties:
+
+  - cirrus,reset-gpios : gpio used to reset the amplifier
+
+  - interrupt-parent : Specifies the phandle of the interrupt controller to
+    which the IRQs from CS35L33 are delivered to.
+ -  interrupts : IRQ line info CS35L33.
+    (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+    for further information relating to interrupt properties)
+
+  - cirrus,boost-ctl : Booster voltage use to supply the amp, if this is not
+    set then the internal 1.0V LDO will supply the amp.
+
+  - cirrus,ramp-rate : On power up, it affects the time from when the power
+    up sequence begins to the time the audio reaches a full-scale output.
+    On power down, it affects the time from when the power-down sequence
+    begins to when the amplifier disables the PWM outputs. If this property
+    is not set then soft ramping will be disabled and ramp time would be
+    20ms. If this property is set to 0,1,2,3 then ramp times would be 40ms,
+    60ms,100ms,175ms respectively for 48KHz sample rate.
+
+  - cirrus,boost-ipk : Booster peak current
+
+  - cirrus,hg-algo : parameters for internal h/g algorithm that controls
+    the amplifier supplies
+
+Example:
+
+cs35l33: cs35l33@40 {
+	compatible = "cirrus,cs35l33";
+	reg = <0x40>;
+
+	VA-supply = <&ldo5_reg>;
+	VP-supply = <&ldo5_reg>;
+
+	interrupt-parent = <&gpio8>;
+	interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+	reset-gpios = <&cs47l91 34 0>;
+
+	ramp-rate = <0x0>;
+	boost-ctl = <0x0>;
+	boost-ipk = <0xE0>;
+
+	hg-algo {
+		mem-depth = <0x3>;
+		release-rate = <0x3>;
+		hd-rm = <0xA>;
+		ldo-thld = <0x1>;
+		ldo-path-disable = <0x0>;
+		ldo-entry-delay=<0x4>;
+		vp-hg-auto;
+		vp-hg=<0xF>;
+		vp-hg-rate=<0x2>;
+		vp-hg-va=<0x0>;
+	};
+};
-- 
1.9.1
