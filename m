From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5616: add devicetree document for
	rt5616" to the asoc tree
Date: Wed, 23 Dec 2015 00:09:02 +0000
Message-ID: <E1aBWzG-0007NI-1h@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ABF58265E14
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2015 01:09:07 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caesar Wang <wxt@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5616: add devicetree document for rt5616

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

>From 27af4e488c6a2a8c4b6102e777c29fff467a3895 Mon Sep 17 00:00:00 2001
From: Caesar Wang <wxt@rock-chips.com>
Date: Tue, 22 Dec 2015 13:45:03 +0800
Subject: [PATCH] ASoC: rt5616: add devicetree document for rt5616

Add the description for rt5616 codec.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rt5616.txt | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/rt5616.txt

diff --git a/Documentation/devicetree/bindings/sound/rt5616.txt b/Documentation/devicetree/bindings/sound/rt5616.txt
new file mode 100644
index 000000000000..efc48c65198d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/rt5616.txt
@@ -0,0 +1,26 @@
+RT5616 audio CODEC
+
+This device supports I2C only.
+
+Required properties:
+
+- compatible : "realtek,rt5616".
+
+- reg : The I2C address of the device.
+
+Pins on the device (for linking into audio routes) for RT5616:
+
+  * IN1P
+  * IN2P
+  * IN2N
+  * LOUTL
+  * LOUTR
+  * HPOL
+  * HPOR
+
+Example:
+
+codec: rt5616@1b {
+	compatible = "realtek,rt5616";
+	reg = <0x1b>;
+};
-- 
2.6.2
