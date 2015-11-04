From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V3 03/11] ASoC: img: Add binding document for
	I2S output controller
Date: Wed, 4 Nov 2015 14:40:49 +0000
Message-ID: <1446648057-373-4-git-send-email-Damien.Horsley@imgtec.com>
References: <1446648057-373-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 49BDB260522
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 15:41:54 +0100 (CET)
In-Reply-To: <1446648057-373-1-git-send-email-Damien.Horsley@imgtec.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, James Hartley <James.Hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add binding document for Imagination Technologies I2S output
controller

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 .../devicetree/bindings/sound/img,i2s-out.txt      | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-out.txt

diff --git a/Documentation/devicetree/bindings/sound/img,i2s-out.txt b/Documentation/devicetree/bindings/sound/img,i2s-out.txt
new file mode 100644
index 0000000..0159415
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,i2s-out.txt
@@ -0,0 +1,51 @@
+Imagination Technologies I2S Output Controller
+
+Required Properties:
+
+  - compatible : Compatible list, must contain "img,i2s-out"
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - reg : Offset and length of the register set for the device
+
+  - clocks : Contains an entry for each entry in clock-names
+
+  - clock-names : Must include the following entries:
+	"sys"	The system clock
+	"ref"	The reference clock
+
+  - dmas: Contains an entry for each entry in dma-names.
+
+  - dma-names: Must include the following entry:
+	"tx"	Single DMA channel used by all active I2S channels
+
+  - img,i2s-channels : Number of I2S channels instantiated in the I2S out block
+
+  - resets: Contains a phandle to the I2S out reset signal
+
+  - reset-names: Contains the reset signal name "rst"
+
+Optional Properties:
+
+  - interrupts : Contains the I2S out interrupts. Depending on
+	the configuration, there may be no interrupts, one interrupt,
+	or an interrupt per I2S channel. For the case where there is
+	one interrupt per channel, the interrupts should be listed
+	in ascending channel order
+
+Example:
+
+i2s_out: i2s-out@18100A00 {
+	compatible = "img,i2s-out";
+	reg = <0x18100A00 0x200>;
+	interrupts = <GIC_SHARED 13 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&mdc 23 0xffffffff 0>;
+	dma-names = "tx";
+	clocks = <&cr_periph SYS_CLK_I2S_OUT>,
+		 <&clk_core CLK_I2S>;
+	clock-names = "sys", "ref";
+	img,i2s-channels = <6>;
+	resets = <&pistachio_reset PISTACHIO_RESET_I2S_OUT>;
+	reset-names = "rst";
+	#sound-dai-cells = <0>;
+};
-- 
2.1.4
