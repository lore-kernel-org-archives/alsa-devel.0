From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8974: add binding for WM8974 codec"
	to the asoc tree
Date: Fri, 18 Dec 2015 12:15:37 +0000
Message-ID: <E1a9twf-0006Ai-9P@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AEA86266684
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:44 +0100 (CET)
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
To: Mans Rullgard <mans@mansr.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8974: add binding for WM8974 codec

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

>From 47d358bbf22d504a41007e7fbf71b5b4b1b45b79 Mon Sep 17 00:00:00 2001
From: Mans Rullgard <mans@mansr.com>
Date: Wed, 16 Dec 2015 13:55:13 +0000
Subject: [PATCH] ASoC: wm8974: add binding for WM8974 codec

This adds a binding for the Wolfson WM8974 mono audio codec.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/wlf,wm8974.txt | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8974.txt

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8974.txt b/Documentation/devicetree/bindings/sound/wlf,wm8974.txt
new file mode 100644
index 000000000000..01d3a7c83419
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8974.txt
@@ -0,0 +1,15 @@
+WM8974 audio CODEC
+
+This device supports both I2C and SPI (configured with pin strapping
+on the board).
+
+Required properties:
+  - compatible: "wlf,wm8974"
+  - reg: the I2C address or SPI chip select number of the device
+
+Examples:
+
+codec: wm8974@1a {
+	compatible = "wlf,wm8974";
+	reg = <0x1a>;
+};
-- 
2.6.2
