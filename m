From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH 01/10] ASoC: img: Add binding document for I2S
	input controller
Date: Wed, 30 Sep 2015 16:08:07 +0100
Message-ID: <1443625696-29296-2-git-send-email-Damien.Horsley@imgtec.com>
References: <1443625696-29296-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 80F922660EE
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 17:10:03 +0200 (CEST)
In-Reply-To: <1443625696-29296-1-git-send-email-Damien.Horsley@imgtec.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

Add a binding document for Imagination Technologies I2S input
controller

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 .../devicetree/bindings/sound/img,i2s-in.txt       | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,i2s-in.txt

diff --git a/Documentation/devicetree/bindings/sound/img,i2s-in.txt b/Documentation/devicetree/bindings/sound/img,i2s-in.txt
new file mode 100644
index 0000000..a9e3c86
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,i2s-in.txt
@@ -0,0 +1,45 @@
+Imagination Technologies I2S Input Controller
+
+Required Properties:
+
+  - compatible : Compatible list, must contain "img,i2s-in"
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - reg : Offset and length of the register set for the device
+
+  - clocks : Contains an entry for each entry in clock-names
+
+  - clock-names : Must include the following entry:
+	"sys"	The system clock
+
+  - dmas: Contains an entry for each entry in dma-names.
+
+  - dma-names: Must include the following entry:
+	"rx"	Single DMA channel used by all active I2S channels
+
+  - img,i2s-channels : Number of I2S channels instantiated in the I2S in block
+
+Optional Properties:
+
+  - interrupts : Contains the I2S in interrupts. Depending on
+	the configuration, there may be no interrupts, one interrupt,
+	or an interrupt per I2S channel
+
+  - resets: Contains a phandle to the I2S in reset signal
+
+  - reset-names: Contains the reset signal name "rst"
+
+Example:
+
+i2s_in: i2s-in@18100800 {
+	compatible = "img,i2s-in";
+	reg = <0x18100800 0x200>;
+	interrupts = <GIC_SHARED 7 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&mdc 30 0xffffffff 0>;
+	dma-names = "rx";
+	clocks = <&cr_periph SYS_CLK_I2S_IN>;
+	clock-names = "sys";
+	img,i2s-channels = <6>;
+	#sound-dai-cells = <0>;
+};
-- 
2.1.4
