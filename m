From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: ASoC: xlnx,
 i2s: Document i2s bindings" to the asoc tree
Date: Thu, 13 Dec 2018 18:11:17 +0000 (GMT)
Message-ID: <20181213181117.D38D311254D1@debutante.sirena.org.uk>
References: <1544207558-72508-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1544207558-72508-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, Michal Simek <michal.simek@xilinx.com>, Vishal Sagar <vsagar@xilinx.com>
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: ASoC: xlnx, i2s: Document i2s bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 644c2dcf2f2ea113602aa24170d3203942d3d140 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Sat, 8 Dec 2018 00:02:36 +0530
Subject: [PATCH] dt-bindings: ASoC: xlnx, i2s: Document i2s bindings

Added documentation for I2S IP core DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
new file mode 100644
index 000000000000..5e7c7d5bb60a
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
2.19.0.rc2
