From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Subject: [PATCH 1/3] dt-bindings: ASoC: xlnx,i2s: Document i2s bindings
Date: Sat, 8 Dec 2018 00:02:36 +0530
Message-ID: <1544207558-72508-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
References: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1544207558-72508-1-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vishal Sagar <vsagar@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Added documentation for I2S IP core DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
---
 .../devicetree/bindings/sound/xlnx,i2s.txt         | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
new file mode 100644
index 0000000..5e7c7d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
@@ -0,0 +1,28 @@
+Device-Tree bindings for Xilinx I2S PL block
+
+The IP supports I2S based playback/capture audio
+
+Required property:
+ - compatible: "xlnx,i2s-transmitter-1.0" for playback and
+	       "xlnx,i2s-receiver-1.0" for capture
+
+Required property common to both I2S playback and capture:
+ - reg: Base address and size of the IP core instance.
+ - xlnx,dwidth: sample data width. Can be any of 16, 24.
+ - xlnx,num-channels: Number of I2S streams. Can be any of 1, 2, 3, 4.
+		      supported channels = 2 * xlnx,num-channels
+
+Example:
+
+	i2s_receiver@a0080000 {
+		compatible = "xlnx,i2s-receiver-1.0";
+		reg = <0x0 0xa0080000 0x0 0x10000>;
+		xlnx,dwidth = <0x18>;
+		xlnx,num-channels = <1>;
+	};
+	i2s_transmitter@a0090000 {
+		compatible = "xlnx,i2s-transmitter-1.0";
+		reg = <0x0 0xa0090000 0x0 0x10000>;
+		xlnx,dwidth = <0x18>;
+		xlnx,num-channels = <1>;
+	};
-- 
2.7.4
