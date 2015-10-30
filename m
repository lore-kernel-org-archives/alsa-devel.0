From: Simran Rai <ssimran@broadcom.com>
Subject: [PATCH 1/2] dt-bindings: sound: Add DT bindings for Broadcom Cygnus audio
Date: Fri, 30 Oct 2015 11:54:56 -0700
Message-ID: <1446231297-10648-2-git-send-email-ssimran@broadcom.com>
References: <1446231297-10648-1-git-send-email-ssimran@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446231297-10648-1-git-send-email-ssimran@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Simran Rai <ssimran@broadcom.com>, Lori Hikichi <lhikichi@broadcom.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, Arun Parameswaran <arunp@broadcom.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add bindings for audio driver in Broadcom Cygnus.

Signed-off-by: Lori Hikichi <lhikichi@broadcom.com>
Signed-off-by: Simran Rai <ssimran@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
---
 .../bindings/sound/brcm,cygnus-audio.txt           |   63 ++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
new file mode 100644
index 0000000..73cddb3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
@@ -0,0 +1,63 @@
+BROADCOM Cygnus Audio I2S/TDM/SPDIF controller
+
+Required properties:
+	- compatible : "brcm,cygnus-audio"
+	- #address-cells: 32bit valued, 1 cell.
+	- #size-cells:  32bit valued, 0 cell.
+	- reg : Should contain audio registers location and length
+	- reg-names: names of the registers listed in "reg" property
+		Valid names are "aud" and "i2s_in". "aud" contains a
+		set of DMA, I2S_OUT and SPDIF registers. "i2s_in" contains
+		a set of I2S_IN registers.
+	- clocks: PLL and leaf clocks used by audio ports
+	- clock-names: names of 3 leaf clocks used by audio ports
+		Valid names are "ch0_audio", "ch1_audio", "ch2_audio"
+	- interrupts: audio DMA interrupt number
+
+SSP Subnode properties:
+- reg: The index of ssp port interface to use
+	Valid value are 0, 1, 2, or 3 (for spdif)
+- channel-group: Surround sound grouping that controls which channel
+  outputs belong to a group, specifically useful in Multi-channel
+  Interfaces grouping of serial port. In multi-channel stereo, use
+  "2_0", in 3.1 multi-channel grouping, use "3_1" and in 5.1
+  multi-channel grouping, use "5_1".
+
+
+Example:
+	cygnus_audio: audio@180ae000 {
+		compatible = "brcm,cygnus-audio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x180ae000 0xafd>, <0x180aec00 0x1f8>;
+		reg-names = "aud", "i2s_in";
+		clocks = <&audiopll BCM_CYGNUS_AUDIOPLL_CH0>,
+				<&audiopll BCM_CYGNUS_AUDIOPLL_CH1>,
+				<&audiopll BCM_CYGNUS_AUDIOPLL_CH2>;
+		clock-names = "ch0_audio", "ch1_audio", "ch2_audio";
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+
+		ssp0: ssp_port@0 {
+			reg = <0>;
+			channel-group = "2_0"; /* Use 2_0, 3_1, 5_1 */
+			status = "okay";
+		};
+
+		ssp1: ssp_port@1 {
+			reg = <1>;
+			channel-group = "2_0"; /* Use 2_0, 3_1, 5_1 */
+			status = "disabled";
+		};
+
+		ssp2: ssp_port@2 {
+			reg = <2>;
+			channel-group = "2_0"; /* Use 2_0, 3_1, 5_1 */
+			status = "disabled";
+		};
+
+		spdif: spdif_port@3 {
+			reg = <3>;
+			channel-group = "2_0"; /* Use 2_0, 3_1, 5_1 */
+			status = "disabled";
+		};
+	};
-- 
1.7.9.5
