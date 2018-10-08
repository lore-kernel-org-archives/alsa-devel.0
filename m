From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add device tree documentation file for
	wm8782 stereo DAC" to the asoc tree
Date: Mon,  8 Oct 2018 14:57:13 +0100 (BST)
Message-ID: <20181008135713.02F531122339@debutante.sirena.org.uk>
References: <20181003193436.5281-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0626E26778A
 for <alsa-devel@alsa-project.org>; Mon,  8 Oct 2018 15:57:17 +0200 (CEST)
In-Reply-To: <20181003193436.5281-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: tiwai@suse.de, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add device tree documentation file for wm8782 stereo DAC

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

>From cc65fb650c682e3b43d50202a0f01da7dc11e647 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Wed, 3 Oct 2018 21:34:35 +0200
Subject: [PATCH] ASoC: Add device tree documentation file for wm8782 stereo
 DAC

Add a device tree documentation file for the wm8782 stereo DAC to describe
the regulator handles.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/wm8782.txt        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wm8782.txt

diff --git a/Documentation/devicetree/bindings/sound/wm8782.txt b/Documentation/devicetree/bindings/sound/wm8782.txt
new file mode 100644
index 000000000000..256cdec6ec4d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wm8782.txt
@@ -0,0 +1,17 @@
+WM8782 stereo ADC
+
+This device does not have any control interface or reset pins.
+
+Required properties:
+
+ - compatible  : "wlf,wm8782"
+ - Vdda-supply : phandle to a regulator for the analog power supply (2.7V - 5.5V)
+ - Vdd-supply  : phandle to a regulator for the digital power supply (2.7V - 3.6V)
+
+Example:
+
+wm8782: stereo-adc {
+	compatible = "wlf,wm8782";
+	Vdda-supply = <&vdda_supply>;
+	Vdd-supply = <&vdd_supply>;
+};
-- 
2.19.0.rc2
