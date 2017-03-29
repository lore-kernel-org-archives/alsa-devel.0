From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mediatek: add bindings for wm8960 codec
	machine driver" to the asoc tree
Date: Wed, 29 Mar 2017 12:02:30 +0100
Message-ID: <E1ctBN0-0007Ky-2K@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 60106266EFA
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 13:02:38 +0200 (CEST)
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
To: Ryder Lee <ryder.lee@mediatek.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mediatek: add bindings for wm8960 codec machine driver

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

>From 768abad46df941b6f921f358d3b17e51451b29bd Mon Sep 17 00:00:00 2001
From: Ryder Lee <ryder.lee@mediatek.com>
Date: Wed, 29 Mar 2017 16:59:32 +0800
Subject: [PATCH] ASoC: mediatek: add bindings for wm8960 codec machine driver

add device tree bindings for mt2701-wm8960.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/mt2701-wm8960.txt    | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-wm8960.txt

diff --git a/Documentation/devicetree/bindings/sound/mt2701-wm8960.txt b/Documentation/devicetree/bindings/sound/mt2701-wm8960.txt
new file mode 100644
index 000000000000..809b609ea9d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/mt2701-wm8960.txt
@@ -0,0 +1,24 @@
+MT2701 with WM8960 CODEC
+
+Required properties:
+- compatible: "mediatek,mt2701-wm8960-machine"
+- mediatek,platform: the phandle of MT2701 ASoC platform
+- audio-routing: a list of the connections between audio
+- mediatek,audio-codec: the phandles of wm8960 codec
+- pinctrl-names: Should contain only one value - "default"
+- pinctrl-0: Should specify pin control groups used for this controller.
+
+Example:
+
+	sound:sound {
+		compatible = "mediatek,mt2701-wm8960-machine";
+		mediatek,platform = <&afe>;
+		audio-routing =
+			"Headphone", "HP_L",
+			"Headphone", "HP_R",
+			"LINPUT1", "AMIC",
+			"RINPUT1", "AMIC";
+		mediatek,audio-codec = <&wm8960>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&aud_pins_default>;
+	};
-- 
2.11.0
