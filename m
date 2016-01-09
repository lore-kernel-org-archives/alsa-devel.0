From: kernel@martin.sperl.org
Subject: [PATCH 4/5] ARM: bcm2835: I2S: use new register-range and clock framework
Date: Sat,  9 Jan 2016 09:25:56 +0000
Message-ID: <1452331558-2520-5-git-send-email-kernel@martin.sperl.org>
References: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1452331558-2520-1-git-send-email-kernel@martin.sperl.org>
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Remi Pommarel <repk@triplefau.lt>, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Matthias Reichl <hias@horus.com>, lFlorian Meier <florian.meier@koalo.de>
Cc: Martin Sperl <kernel@martin.sperl.org>
List-Id: alsa-devel@alsa-project.org

From: Martin Sperl <kernel@martin.sperl.org>

Since the move to the new clock framework with
commit 94cb7f76caa0b337 ("Switch to using the new clock driver support")
the bcm2835-i2s driver was no longer working.

This patch fixes the address ranges:
* remove the PCM clock register range that is owned by the clockmanager
* fix the length, which did not include the last register of this device

It also adds the required pcm-clock with the corresponding default
clock and rate.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 arch/arm/boot/dts/bcm2835.dtsi |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index aef64de..83d9787 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -120,9 +120,8 @@
 
 		i2s: i2s@7e203000 {
 			compatible = "brcm,bcm2835-i2s";
-			reg = <0x7e203000 0x20>,
-			      <0x7e101098 0x02>;
-
+			reg = <0x7e203000 0x24>;
+			clocks = <&clocks BCM2835_CLOCK_PCM>;
 			dmas = <&dma 2>,
 			       <&dma 3>;
 			dma-names = "tx", "rx";
-- 
1.7.10.4

