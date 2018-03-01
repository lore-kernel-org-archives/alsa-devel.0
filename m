From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel: Remove redundant dev_err() call
	in probe function" to the asoc tree
Date: Thu, 01 Mar 2018 18:06:31 +0000
Message-ID: <E1erSb9-0005kZ-7J@debutante>
References: <20180130110654.GB18123@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 14E9F26798F
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 19:06:39 +0100 (CET)
In-Reply-To: <20180130110654.GB18123@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel: Remove redundant dev_err() call in probe function

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

>From 1f598e6861ab1d3cc46d6eff155c0a0a6736de38 Mon Sep 17 00:00:00 2001
From: Ladislav Michl <ladis@linux-mips.org>
Date: Thu, 1 Mar 2018 14:37:31 +0100
Subject: [PATCH] ASoC: atmel: Remove redundant dev_err() call in probe
 function

There is an error message within devm_ioremap_resource already,
so remove the redundant dev_err() call.

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/atmel/atmel-classd.c | 7 ++-----
 sound/soc/atmel/atmel-pdmic.c  | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/soc/atmel/atmel-classd.c b/sound/soc/atmel/atmel-classd.c
index 27bb55ca07ae..709a13221d79 100644
--- a/sound/soc/atmel/atmel-classd.c
+++ b/sound/soc/atmel/atmel-classd.c
@@ -582,11 +582,8 @@ static int atmel_classd_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	io_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(io_base)) {
-		ret =  PTR_ERR(io_base);
-		dev_err(dev, "failed to remap register memory: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
 
 	dd->phy_base = res->start;
 
diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index 5f72baa5f5c7..53217dfac5fe 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -631,11 +631,8 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	io_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(io_base)) {
-		ret = PTR_ERR(io_base);
-		dev_err(dev, "failed to remap register memory: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
 
 	dd->phy_base = res->start;
 
-- 
2.16.2
