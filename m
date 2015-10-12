From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH V2 07/10] ASoC: img: Add binding document for
	SPDIF input controller
Date: Mon, 12 Oct 2015 13:40:34 +0100
Message-ID: <1444653637-14711-8-git-send-email-Damien.Horsley@imgtec.com>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 5285C261564
 for <alsa-devel@alsa-project.org>; Mon, 12 Oct 2015 14:41:33 +0200 (CEST)
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
input controller

Signed-off-by: Damien.Horsley <Damien.Horsley@imgtec.com>
---
 .../devicetree/bindings/sound/img,spdif-in.txt     | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,spdif-in.txt

diff --git a/Documentation/devicetree/bindings/sound/img,spdif-in.txt b/Documentation/devicetree/bindings/sound/img,spdif-in.txt
new file mode 100644
index 0000000..aab9a81
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/img,spdif-in.txt
@@ -0,0 +1,41 @@
+Imagination Technologies SPDIF Input Controller
+
+Required Properties:
+
+  - compatible : Compatible list, must contain "img,spdif-in"
+
+  - #sound-dai-cells : Must be equal to 0
+
+  - reg : Offset and length of the register set for the device
+
+  - dmas: Contains an entry for each entry in dma-names.
+
+  - dma-names: Must include the following entry:
+	"rx"
+
+  - clocks : Contains an entry for each entry in clock-names
+
+  - clock-names : Includes the following entries:
+	"sys"	The system clock
+
+Optional Properties:
+
+  - resets: Should contain a phandle to the spdif in reset signal, if any
+
+  - reset-names: Should contain the reset signal name "rst", if a
+	reset phandle is given
+
+  - interrupts : Contains the spdif in interrupt, if present
+
+Example:
+
+spdif_in: spdif-in@18100E00 {
+	compatible = "img,spdif-in";
+	reg = <0x18100E00 0x100>;
+	interrupts = <GIC_SHARED 20 IRQ_TYPE_LEVEL_HIGH>;
+	dmas = <&mdc 15 0xffffffff 0>;
+	dma-names = "rx";
+	clocks = <&cr_periph SYS_CLK_SPDIF_IN>;
+	clock-names = "sys";
+	#sound-dai-cells = <0>;
+};
-- 
2.1.4
