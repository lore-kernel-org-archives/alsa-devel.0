From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ads117x: Add device tree compatible
	string" to the asoc tree
Date: Sat, 05 Mar 2016 21:24:42 +0900
Message-ID: <E1acBGE-0003E1-7Q@finisterre>
References: <1454686334-9668-3-git-send-email-florian.vaussard@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E45972608B4
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:24:55 +0100 (CET)
In-Reply-To: <1454686334-9668-3-git-send-email-florian.vaussard@heig-vd.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Florian Vaussard <florian.vaussard@heig-vd.ch>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ads117x: Add device tree compatible string

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

>From 4f2bf0ace0f96cc693002e1bbde967fa2356bc43 Mon Sep 17 00:00:00 2001
From: Florian Vaussard <florian.vaussard@gmail.com>
Date: Fri, 5 Feb 2016 16:32:14 +0100
Subject: [PATCH] ASoC: ads117x: Add device tree compatible string

This patch adds the necessary device tree compatible string to allow DT
probing.

Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ads117x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/ads117x.c b/sound/soc/codecs/ads117x.c
index 1222282e93c3..c5be1bdc2c9a 100644
--- a/sound/soc/codecs/ads117x.c
+++ b/sound/soc/codecs/ads117x.c
@@ -20,6 +20,8 @@
 #include <sound/initval.h>
 #include <sound/soc.h>
 
+#include <linux/of.h>
+
 #define ADS117X_RATES (SNDRV_PCM_RATE_8000_48000)
 #define ADS117X_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
 
@@ -75,9 +77,19 @@ static int ads117x_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static const struct of_device_id ads117x_dt_ids[] = {
+	{ .compatible = "ti,ads1174" },
+	{ .compatible = "ti,ads1178" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ads117x_dt_ids);
+#endif
+
 static struct platform_driver ads117x_codec_driver = {
 	.driver = {
 			.name = "ads117x-codec",
+			.of_match_table = of_match_ptr(ads117x_dt_ids),
 	},
 
 	.probe = ads117x_probe,
-- 
2.7.0
