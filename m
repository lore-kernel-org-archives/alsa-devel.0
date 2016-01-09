From: kernel@martin.sperl.org
Subject: [PATCH 5/5] dt-bindings: bsm2835: fix bindings documentation to use new clock framework
Date: Sat,  9 Jan 2016 09:25:57 +0000
Message-ID: <1452331558-2520-6-git-send-email-kernel@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Remi Pommarel <repk@triplefau.lt>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, lFlorian Meier <florian.meier@koalo.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
List-Id: alsa-devel@alsa-project.org

From: Martin Sperl <kernel@martin.sperl.org>

The bcm2835-i2s driver has been updated to use the new clock framework
for the bcm2835 SOC.

This patch documents the required changes to the bindings.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
index 65783de..b331f26 100644
--- a/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/brcm,bcm2835-i2s.txt
@@ -4,11 +4,10 @@ Required properties:
 - compatible: "brcm,bcm2835-i2s"
 - reg: A list of base address and size entries:
 	* The first entry should cover the PCM registers
-	* The second entry should cover the PCM clock registers
+- clocks: the (PCM) clock to use
 - dmas: List of DMA controller phandle and DMA request line ordered pairs.
 - dma-names: Identifier string for each DMA request line in the dmas property.
   These strings correspond 1:1 with the ordered pairs in dmas.
-
   One of the DMA channels will be responsible for transmission (should be
   named "tx") and one for reception (should be named "rx").
 
@@ -16,8 +15,8 @@ Example:
 
 bcm2835_i2s: i2s@7e203000 {
 	compatible = "brcm,bcm2835-i2s";
-	reg = <0x7e203000 0x20>,
-	      <0x7e101098 0x02>;
+	reg = <0x7e203000 0x24>;
+	clocks = <&clocks BCM2835_CLOCK_PCM>;
 
 	dmas = <&dma 2>,
 	       <&dma 3>;
-- 
1.7.10.4

