From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8782: add device-tree matching table"
	to the asoc tree
Date: Tue, 22 May 2018 11:58:57 +0100
Message-ID: <E1fL50L-0000SN-NE@debutante>
References: <20180521215450.30557-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 0EC40267660
 for <alsa-devel@alsa-project.org>; Tue, 22 May 2018 12:58:59 +0200 (CEST)
In-Reply-To: <20180521215450.30557-1-daniel@zonque.org>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8782: add device-tree matching table

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

>From 9e2a87746757690fe951f06b0f336329f4a1f767 Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Mon, 21 May 2018 23:54:49 +0200
Subject: [PATCH] ASoC: wm8782: add device-tree matching table

This is needed when the codec is instanciated from from a device tree.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8782.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/wm8782.c b/sound/soc/codecs/wm8782.c
index 7949703f3d04..317db9a149a7 100644
--- a/sound/soc/codecs/wm8782.c
+++ b/sound/soc/codecs/wm8782.c
@@ -67,9 +67,18 @@ static int wm8782_probe(struct platform_device *pdev)
 			&soc_component_dev_wm8782, &wm8782_dai, 1);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id wm8782_of_match[] = {
+	{ .compatible = "wlf,wm8782", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, wm8782_of_match);
+#endif
+
 static struct platform_driver wm8782_codec_driver = {
 	.driver = {
 		.name = "wm8782",
+		.of_match_table = of_match_ptr(wm8782_of_match),
 	},
 	.probe = wm8782_probe,
 };
-- 
2.17.0
