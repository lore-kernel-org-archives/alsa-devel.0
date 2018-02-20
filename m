From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add DT bindings documentation for
	max9759 amplifier" to the asoc tree
Date: Tue, 20 Feb 2018 12:08:50 +0000
Message-ID: <E1eo6j4-00035p-Ci@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 497AA267505
 for <alsa-devel@alsa-project.org>; Tue, 20 Feb 2018 13:08:51 +0100 (CET)
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
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add DT bindings documentation for max9759 amplifier

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

>From 01182d6529ae499bb73129f4766b45c2ae8e700b Mon Sep 17 00:00:00 2001
From: Neil Armstrong <narmstrong@baylibre.com>
Date: Mon, 19 Feb 2018 14:45:57 +0100
Subject: [PATCH] ASoC: Add DT bindings documentation for max9759 amplifier

This patch adds DT bindings documentation for Maxim MAX9759
speaker amplifier.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/maxim,max9759.txt        | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/maxim,max9759.txt

diff --git a/Documentation/devicetree/bindings/sound/maxim,max9759.txt b/Documentation/devicetree/bindings/sound/maxim,max9759.txt
new file mode 100644
index 000000000000..737a996374d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/maxim,max9759.txt
@@ -0,0 +1,18 @@
+Maxim MAX9759 Speaker Amplifier
+===============================
+
+Required properties:
+- compatible : "maxim,max9759"
+- shutdown-gpios : the gpio connected to the shutdown pin
+- mute-gpios : the gpio connected to the mute pin
+- gain-gpios : the 2 gpios connected to the g1 and g2 pins
+
+Example:
+
+max9759: analog-amplifier {
+	compatible = "maxim,max9759";
+	shutdown-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
+	mute-gpios = <&gpio3 19 GPIO_ACTIVE_LOW>;
+	gain-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>,
+		     <&gpio3 25 GPIO_ACTIVE_LOW>;
+};
-- 
2.16.1
