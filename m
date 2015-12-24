From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: twl6040,
	fsl: use to_platform_device" to the asoc tree
Date: Thu, 24 Dec 2015 19:43:54 +0000
Message-ID: <E1aCBnm-0000nX-3e@finisterre>
References: <e0497ed266c5f2013268cca6c02fd2b161339c07.1450875641.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D2E2260686
 for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2015 20:44:07 +0100 (CET)
In-Reply-To: <e0497ed266c5f2013268cca6c02fd2b161339c07.1450875641.git.geliangtang@163.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Geliang Tang <geliangtang@163.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: twl6040, fsl: use to_platform_device

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

>From bb18f0976ef8db41f68b66623ce3b8a745adb0b8 Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliangtang@163.com>
Date: Wed, 23 Dec 2015 21:03:39 +0800
Subject: [PATCH] ASoC: twl6040, fsl: use to_platform_device

Use to_platform_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang@163.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/twl6040.c   | 3 +--
 sound/soc/fsl/mpc8610_hpcd.c | 3 +--
 sound/soc/fsl/p1022_ds.c     | 3 +--
 sound/soc/fsl/p1022_rdk.c    | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
index 4cad892..bc3de2e 100644
--- a/sound/soc/codecs/twl6040.c
+++ b/sound/soc/codecs/twl6040.c
@@ -1097,8 +1097,7 @@ static int twl6040_probe(struct snd_soc_codec *codec)
 {
 	struct twl6040_data *priv;
 	struct twl6040 *twl6040 = dev_get_drvdata(codec->dev->parent);
-	struct platform_device *pdev = container_of(codec->dev,
-						   struct platform_device, dev);
+	struct platform_device *pdev = to_platform_device(codec->dev);
 	int ret = 0;
 
 	priv = devm_kzalloc(codec->dev, sizeof(*priv), GFP_KERNEL);
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 6f236f1..ddf49f3 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -189,8 +189,7 @@ static int mpc8610_hpcd_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
 	/* ssi_pdev is the platform device for the SSI node that probed us */
-	struct platform_device *ssi_pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *ssi_pdev = to_platform_device(dev);
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct mpc8610_hpcd_data *machine_data;
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 747aab0..a1f780e 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -199,8 +199,7 @@ static int p1022_ds_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
 	/* ssi_pdev is the platform device for the SSI node that probed us */
-	struct platform_device *ssi_pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *ssi_pdev = to_platform_device(dev);
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct machine_data *mdata;
diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index 1dd49e5..d4d88a8 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -203,8 +203,7 @@ static int p1022_rdk_probe(struct platform_device *pdev)
 {
 	struct device *dev = pdev->dev.parent;
 	/* ssi_pdev is the platform device for the SSI node that probed us */
-	struct platform_device *ssi_pdev =
-		container_of(dev, struct platform_device, dev);
+	struct platform_device *ssi_pdev = to_platform_device(dev);
 	struct device_node *np = ssi_pdev->dev.of_node;
 	struct device_node *codec_np = NULL;
 	struct machine_data *mdata;
-- 
2.6.4
