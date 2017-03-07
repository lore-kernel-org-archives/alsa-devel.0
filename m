From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dio2125: add dt-bindings" to the asoc
	tree
Date: Tue, 07 Mar 2017 13:57:29 +0100
Message-ID: <E1clEgD-0004gQ-RC@finisterre>
References: <20170306174451.24406-4-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3C9AB266E52
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:57:40 +0100 (CET)
In-Reply-To: <20170306174451.24406-4-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dio2125: add dt-bindings

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

>From 1e03580b3a7213292fae9a6677edfaa83843fa4e Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 6 Mar 2017 18:44:51 +0100
Subject: [PATCH] ASoC: dio2125: add dt-bindings

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/dioo,dio2125.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/dioo,dio2125.txt

diff --git a/Documentation/devicetree/bindings/sound/dioo,dio2125.txt b/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
new file mode 100644
index 000000000000..63dbfe0f11d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dioo,dio2125.txt
@@ -0,0 +1,12 @@
+DIO2125 Audio Driver
+
+Required properties:
+- compatible : "dioo,dio2125"
+- enable-gpios : the gpio connected to the enable pin of the dio2125
+
+Example:
+
+amp: analog-amplifier {
+	compatible = "dioo,dio2125";
+	enable-gpios = <&gpio GPIOH_3 0>;
+};
-- 
2.11.0
