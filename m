From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sh: siu: replace platform to component"
	to the asoc tree
Date: Mon, 12 Feb 2018 12:30:55 +0000
Message-ID: <E1elDG3-0003JD-7k@debutante>
References: <87wp5jj5u1.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 363FE267672
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:30:59 +0100 (CET)
In-Reply-To: <87wp5jj5u1.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sh: siu: replace platform to component

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

>From be3eabe99803b2526f8829b7c7225763f0703b1f Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:43:45 +0000
Subject: [PATCH] ASoC: sh: siu: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/siu.h     |  2 +-
 sound/soc/sh/siu_dai.c | 10 +---------
 sound/soc/sh/siu_pcm.c |  9 ++++++---
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
index 83c3430ad797..6088d627c0e4 100644
--- a/sound/soc/sh/siu.h
+++ b/sound/soc/sh/siu.h
@@ -183,7 +183,7 @@ static inline u32 siu_read32(u32 __iomem *addr)
 #define SIU_BRGBSEL	(0x108 / sizeof(u32))
 #define SIU_BRRB	(0x10c / sizeof(u32))
 
-extern struct snd_soc_platform_driver siu_platform;
+extern struct snd_soc_component_driver siu_component;
 extern struct siu_info *siu_i2s_data;
 
 int siu_init_port(int port, struct siu_port **port_info, struct snd_card *card);
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
index 160502947da2..ee2211635e92 100644
--- a/sound/soc/sh/siu_dai.c
+++ b/sound/soc/sh/siu_dai.c
@@ -727,10 +727,6 @@ static struct snd_soc_dai_driver siu_i2s_dai = {
 	.ops = &siu_dai_ops,
 };
 
-static const struct snd_soc_component_driver siu_i2s_component = {
-	.name		= "siu-i2s",
-};
-
 static int siu_probe(struct platform_device *pdev)
 {
 	const struct firmware *fw_entry;
@@ -786,15 +782,11 @@ static int siu_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, info);
 
 	/* register using ARRAY version so we can keep dai name */
-	ret = devm_snd_soc_register_component(&pdev->dev, &siu_i2s_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &siu_component,
 					      &siu_i2s_dai, 1);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_snd_soc_register_platform(&pdev->dev, &siu_platform);
-	if (ret < 0)
-		return ret;
-
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
index 3118cb0ee3f2..172909570ed5 100644
--- a/sound/soc/sh/siu_pcm.c
+++ b/sound/soc/sh/siu_pcm.c
@@ -35,6 +35,7 @@
 
 #include "siu.h"
 
+#define DRV_NAME "siu-i2s"
 #define GET_MAX_PERIODS(buf_bytes, period_bytes) \
 				((buf_bytes) / (period_bytes))
 #define PERIOD_OFFSET(buf_addr, period_num, period_bytes) \
@@ -340,7 +341,8 @@ static int siu_pcm_open(struct snd_pcm_substream *ss)
 {
 	/* Playback / Capture */
 	struct snd_soc_pcm_runtime *rtd = ss->private_data;
-	struct siu_platform *pdata = rtd->platform->dev->platform_data;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct siu_platform *pdata = component->dev->platform_data;
 	struct siu_info *info = siu_i2s_data;
 	struct siu_port *port_info = siu_port_info(ss);
 	struct siu_stream *siu_stream;
@@ -604,9 +606,10 @@ static const struct snd_pcm_ops siu_pcm_ops = {
 	.pointer	= siu_pcm_pointer_dma,
 };
 
-struct snd_soc_platform_driver siu_platform = {
+struct snd_soc_component_driver siu_component = {
+	.name		= DRV_NAME,
 	.ops			= &siu_pcm_ops,
 	.pcm_new	= siu_pcm_new,
 	.pcm_free	= siu_pcm_free,
 };
-EXPORT_SYMBOL_GPL(siu_platform);
+EXPORT_SYMBOL_GPL(siu_component);
-- 
2.16.1
