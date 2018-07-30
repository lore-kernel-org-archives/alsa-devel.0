From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tegra_alc5632: fix device_node
	refcounting" to the asoc tree
Date: Mon, 30 Jul 2018 12:03:30 +0100 (BST)
Message-ID: <20180730110330.9BF2C1124216@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CC852677BA
 for <alsa-devel@alsa-project.org>; Mon, 30 Jul 2018 13:03:31 +0200 (CEST)
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
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Jon Hunter <jonathanh@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tegra_alc5632: fix device_node refcounting

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

>From 4321723648b0abb456f7a9af51bb09a4ec60799d Mon Sep 17 00:00:00 2001
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Date: Sat, 28 Jul 2018 00:06:59 +0300
Subject: [PATCH] ASoC: tegra_alc5632: fix device_node refcounting

tegra_alc5632_probe() increments reference count of device nodes
with of_parse_phandle(), but there is no code decrementing them
in the driver.

The patch adds of_node_put() to tegra_alc5632_remove() and
to error handling paths in the probe.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/tegra/tegra_alc5632.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
index 5197d6b18cb6..98d87801d57a 100644
--- a/sound/soc/tegra/tegra_alc5632.c
+++ b/sound/soc/tegra/tegra_alc5632.c
@@ -190,14 +190,14 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev,
 			"Property 'nvidia,i2s-controller' missing or invalid\n");
 		ret = -EINVAL;
-		goto err;
+		goto err_put_codec_of_node;
 	}
 
 	tegra_alc5632_dai.platform_of_node = tegra_alc5632_dai.cpu_of_node;
 
 	ret = tegra_asoc_utils_init(&alc5632->util_data, &pdev->dev);
 	if (ret)
-		goto err;
+		goto err_put_cpu_of_node;
 
 	ret = snd_soc_register_card(card);
 	if (ret) {
@@ -210,6 +210,13 @@ static int tegra_alc5632_probe(struct platform_device *pdev)
 
 err_fini_utils:
 	tegra_asoc_utils_fini(&alc5632->util_data);
+err_put_cpu_of_node:
+	of_node_put(tegra_alc5632_dai.cpu_of_node);
+	tegra_alc5632_dai.cpu_of_node = NULL;
+	tegra_alc5632_dai.platform_of_node = NULL;
+err_put_codec_of_node:
+	of_node_put(tegra_alc5632_dai.codec_of_node);
+	tegra_alc5632_dai.codec_of_node = NULL;
 err:
 	return ret;
 }
@@ -223,6 +230,12 @@ static int tegra_alc5632_remove(struct platform_device *pdev)
 
 	tegra_asoc_utils_fini(&machine->util_data);
 
+	of_node_put(tegra_alc5632_dai.cpu_of_node);
+	tegra_alc5632_dai.cpu_of_node = NULL;
+	tegra_alc5632_dai.platform_of_node = NULL;
+	of_node_put(tegra_alc5632_dai.codec_of_node);
+	tegra_alc5632_dai.codec_of_node = NULL;
+
 	return 0;
 }
 
-- 
2.18.0
