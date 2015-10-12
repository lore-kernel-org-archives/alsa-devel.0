From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V2 09/10] ASoC: img: Add binding document for
	SPDIF output controller
Date: Mon, 12 Oct 2015 13:40:36 +0100
Message-ID: <1444653637-14711-10-git-send-email-Damien.Horsley@imgtec.com>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 14409261600
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 14:41:34 +0200 (CEST)
In-Reply-To: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
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

Add binding document for Imagination Technologies SPDIF
ouput controller

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 .../devicetree/bindings/sound/img,spdif-out.txt    | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-out.txt

diff --git a/Documentation/devicetree/bindings/sound/img,spdif-out.txt b/Documentation/devicetree/bindings/sound/img,spdif-out.txt
new file mode 100644
index 0000000..470a519
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,spdif-out.txt
@@ -0,0 +1,44 @@
+Imagination Technologies SPDIF Output Controller
+
+Required Properties:
+
+  - compatible : Compatible list, must contain "img,spdif-out"
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - reg : Offset and length of the register set for the device
+
+  - dmas: Contains an entry for each entry in dma-names.
+
+  - dma-names: Must include the following entry:
+	"tx"
+
+  - clocks : Contains an entry for each entry in clock-names.
+
+  - clock-names : Includes the following entries:
+	"sys"	The system clock
+	"ref"	The reference clock
+
+  - resets: Contains a phandle to the spdif out reset signal
+
+  - reset-names: Contains the reset signal name "rst"
+
+Optional Properties:
+
+  - interrupts : Contains the parallel out interrupt, if present
+
+Example:
+
+spdif_out: spdif-out@18100D00 {
+	compatible = "img,spdif-out";
+	reg = <0x18100D00 0x100>;
+	interrupts = <GIC_SHARED 21 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&mdc 14 0xffffffff 0>;
+	dma-names = "tx";
+	clocks = <&cr_periph SYS_CLK_SPDIF_OUT>,
+		 <&clk_core CLK_SPDIF>;
+	clock-names = "sys", "ref";
+	resets = <&pistachio_reset PISTACHIO_RESET_SPDIF_OUT>;
+	reset-names = "rst";
+	#sound-dai-cells = <0>;
+};
-- 
2.1.4
