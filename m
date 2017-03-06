From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: es7134: add dt-bindings for the es7134
	dac" to the asoc tree
Date: Mon, 06 Mar 2017 11:46:12 +0100
Message-ID: <E1ckq9c-0002Mq-QV@finisterre>
References: <20170227154724.13724-3-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F935261740
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:46:24 +0100 (CET)
In-Reply-To: <20170227154724.13724-3-jbrunet@baylibre.com>
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
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: es7134: add dt-bindings for the es7134 dac

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

>From 59c15fcd7b8f3e85baba167a3b7c0cbc692ebd90 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 27 Feb 2017 16:47:24 +0100
Subject: [PATCH] ASoC: es7134: add dt-bindings for the es7134 dac

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/everest,es7134.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/everest,es7134.txt

diff --git a/Documentation/devicetree/bindings/sound/everest,es7134.txt b/Documentation/devicetree/bindings/sound/everest,es7134.txt
new file mode 100644
index 000000000000..5495a3cb8b7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/everest,es7134.txt
@@ -0,0 +1,10 @@
+ES7134 i2s DA converter
+
+Required properties:
+- compatible : "everest,es7134" or "everest,es7144"
+
+Example:
+
+i2s_codec: external-codec {
+	compatible = "everest,es7134";
+};
-- 
2.11.0
