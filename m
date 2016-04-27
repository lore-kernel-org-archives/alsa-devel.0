From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add TA5720 digital amplifier DT bindings" to the asoc tree
Date: Wed, 27 Apr 2016 17:34:51 +0100
Message-ID: <E1avSQN-0004Mh-Ip@debutante>
References: <1461708957-7616-2-git-send-email-dannenberg@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461708957-7616-2-git-send-email-dannenberg@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add TA5720 digital amplifier DT bindings

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 4e2f17be8f63a6ad9ebd4cdfce627e3dd25d80bb Mon Sep 17 00:00:00 2001
From: Andreas Dannenberg <dannenberg@ti.com>
Date: Tue, 26 Apr 2016 17:15:56 -0500
Subject: [PATCH] ASoC: add TA5720 digital amplifier DT bindings

The Texas Instruments TAS5720L/M device is a high-efficiency mono
Class-D audio power amplifier optimized for high transient power
capability to use the dynamic power headroom of small loudspeakers.
Its digital time division multiplexed (TDM) interface enables up to
16 devices to share the same bus.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/tas5720.txt          | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas5720.txt

diff --git a/Documentation/devicetree/bindings/sound/tas5720.txt b/Documentation/devicetree/bindings/sound/tas5720.txt
new file mode 100644
index 000000000000..806ea7381483
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tas5720.txt
@@ -0,0 +1,25 @@
+Texas Instruments TAS5720 Mono Audio amplifier
+
+The TAS5720 serial control bus communicates through the I2C protocol only. The
+serial bus is also used for periodic codec fault checking/reporting during
+audio playback. For more product information please see the links below:
+
+http://www.ti.com/product/TAS5720L
+http://www.ti.com/product/TAS5720M
+
+Required properties:
+
+- compatible : "ti,tas5720"
+- reg : I2C slave address
+- dvdd-supply : phandle to a 3.3-V supply for the digital circuitry
+- pvdd-supply : phandle to a supply used for the Class-D amp and the analog
+
+Example:
+
+tas5720: tas5720@6c {
+	status = "okay";
+	compatible = "ti,tas5720";
+	reg = <0x6c>;
+	dvdd-supply = <&vdd_3v3_reg>;
+	pvdd-supply = <&amp_supply_reg>;
+};
-- 
2.8.0.rc3
