From: Simran Rai <simran.rai@broadcom.com>
Subject: [PATCH v7 1/3] ASoC: cygnus: Add DT bindings for Broadcom Cygnus audio
Date: Tue, 17 May 2016 17:01:07 -0700
Message-ID: <1463529669-25022-2-git-send-email-simran.rai@broadcom.com>
References: <1463529669-25022-1-git-send-email-simran.rai@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1463529669-25022-1-git-send-email-simran.rai@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lori Hikichi <lhikichi@broadcom.com>, Simran Rai <simran.rai@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Arun Parameswaran <arunp@broadcom.com>, linux-arm-kernel@lists.infradead.org, Simran Rai <ssimran@broadcom.com>
List-Id: alsa-devel@alsa-project.org

From: Simran Rai <ssimran@broadcom.com>

Add bindings for audio driver in Broadcom Cygnus.

Signed-off-by: Lori Hikichi <lhikichi@broadcom.com>
Signed-off-by: Simran Rai <ssimran@broadcom.com>
Reviewed-by: Ray Jui <rjui@broadcom.com>
Reviewed-by: Scott Branden <sbranden@broadcom.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/sound/brcm,cygnus-audio.txt           | 67 ++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt

diff --git a/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
new file mode 100644
index 0000000..b139e66
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
@@ -0,0 +1,67 @@
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
+	- assigned-clocks: PLL and leaf clocks
+	- assigned-clock-parents: parent clocks of the assigned clocks
+		(usually the PLL)
+	- assigned-clock-rates: List of clock frequencies of the
+		assigned clocks
+	- clock-names: names of 3 leaf clocks used by audio ports
+		Valid names are "ch0_audio", "ch1_audio", "ch2_audio"
+	- interrupts: audio DMA interrupt number
+
+SSP Subnode properties:
+- reg: The index of ssp port interface to use
+	Valid value are 0, 1, 2, or 3 (for spdif)
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
+		assigned-clocks = <&audiopll BCM_CYGNUS_AUDIOPLL>,
+							<&audiopll BCM_CYGNUS_AUDIOPLL_CH0>,
+							<&audiopll BCM_CYGNUS_AUDIOPLL_CH1>,
+							<&audiopll BCM_CYGNUS_AUDIOPLL_CH2>;
+		assigned-clock-parents = <&audiopll BCM_CYGNUS_AUDIOPLL>;
+		assigned-clock-rates = <1769470191>,
+								<0>,
+								<0>,
+								<0>;
+		clock-names = "ch0_audio", "ch1_audio", "ch2_audio";
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+
+		ssp0: ssp_port@0 {
+			reg = <0>;
+			status = "okay";
+		};
+
+		ssp1: ssp_port@1 {
+			reg = <1>;
+			status = "disabled";
+		};
+
+		ssp2: ssp_port@2 {
+			reg = <2>;
+			status = "disabled";
+		};
+
+		spdif: spdif_port@3 {
+			reg = <3>;
+			status = "disabled";
+		};
+	};
-- 
1.9.1
