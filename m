From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH 2/7] sound: soc: enable Kirkwood driver for
	mvebu platforms
Date: Thu, 30 Jan 2014 18:14:06 +0100
Message-ID: <1391102051-5319-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BC0526556E
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 18:14:15 +0100 (CET)
In-Reply-To: <1391102051-5319-1-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Lior Amsalem <alior@marvell.com>, alsa-devel@alsa-project.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The audio unit found in the Armada 370 SoC is similar to the one used
in the Marvell Kirkwood and Marvell Dove SoCs. Therefore, this commit
allows the Kirkwood audio driver to be built on mvebu platforms, and
adds an additional compatible string to identify the Armada 370
variant of the audio unit.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/devicetree/bindings/sound/mvebu-audio.txt | 1 +
 sound/soc/kirkwood/Kconfig                              | 2 +-
 sound/soc/kirkwood/kirkwood-i2s.c                       | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/mvebu-audio.txt b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
index f0062c5..cb8c07c 100644
--- a/Documentation/devicetree/bindings/sound/mvebu-audio.txt
+++ b/Documentation/devicetree/bindings/sound/mvebu-audio.txt
@@ -5,6 +5,7 @@ Required properties:
 - compatible:
   "marvell,kirkwood-audio" for Kirkwood platforms
   "marvell,dove-audio" for Dove platforms
+  "marvell,armada370-audio" for Armada 370 platforms
 
 - reg: physical base address of the controller and length of memory mapped
   region.
diff --git a/sound/soc/kirkwood/Kconfig b/sound/soc/kirkwood/Kconfig
index 78ed4a4..764a0ef 100644
--- a/sound/soc/kirkwood/Kconfig
+++ b/sound/soc/kirkwood/Kconfig
@@ -1,6 +1,6 @@
 config SND_KIRKWOOD_SOC
 	tristate "SoC Audio for the Marvell Kirkwood and Dove chips"
-	depends on ARCH_KIRKWOOD || ARCH_DOVE || COMPILE_TEST
+	depends on ARCH_KIRKWOOD || ARCH_DOVE || ARCH_MVEBU || COMPILE_TEST
 	help
 	  Say Y or M if you want to add support for codecs attached to
 	  the Kirkwood I2S interface. You will also need to select the
diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 3920a5e..9f84222 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -633,6 +633,7 @@ static int kirkwood_i2s_dev_remove(struct platform_device *pdev)
 static struct of_device_id mvebu_audio_of_match[] = {
 	{ .compatible = "marvell,kirkwood-audio" },
 	{ .compatible = "marvell,dove-audio" },
+	{ .compatible = "marvell,armada370-audio" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mvebu_audio_of_match);
-- 
1.8.3.2
