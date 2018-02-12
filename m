From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: au1x: dbdma2: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:28:35 +0000
Message-ID: <E1elDDn-0002xB-UX@debutante>
References: <87inc7ew3u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AA63D26734C
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:28:39 +0100 (CET)
In-Reply-To: <87inc7ew3u.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: au1x: dbdma2: replace platform to component

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

>From abf33c7a536f97b78cce6d016768af2253810a15 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:50:37 +0000
Subject: [PATCH] ASoC: au1x: dbdma2: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/au1x/dbdma2.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/au1x/dbdma2.c b/sound/soc/au1x/dbdma2.c
index 6a035ca0f521..fb650659c3a3 100644
--- a/sound/soc/au1x/dbdma2.c
+++ b/sound/soc/au1x/dbdma2.c
@@ -32,6 +32,8 @@
 
 /*#define PCM_DEBUG*/
 
+#define DRV_NAME "dbdma2"
+
 #define MSG(x...)	printk(KERN_INFO "au1xpsc_pcm: " x)
 #ifdef PCM_DEBUG
 #define DBG		MSG
@@ -187,8 +189,8 @@ static int au1x_pcm_dbdma_realloc(struct au1xpsc_audio_dmadata *pcd,
 static inline struct au1xpsc_audio_dmadata *to_dmadata(struct snd_pcm_substream *ss)
 {
 	struct snd_soc_pcm_runtime *rtd = ss->private_data;
-	struct au1xpsc_audio_dmadata *pcd =
-				snd_soc_platform_get_drvdata(rtd->platform);
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
+	struct au1xpsc_audio_dmadata *pcd = snd_soc_component_get_drvdata(component);
 	return &pcd[ss->stream];
 }
 
@@ -327,7 +329,8 @@ static int au1xpsc_pcm_new(struct snd_soc_pcm_runtime *rtd)
 }
 
 /* au1xpsc audio platform */
-static struct snd_soc_platform_driver au1xpsc_soc_platform = {
+static struct snd_soc_component_driver au1xpsc_soc_component = {
+	.name		= DRV_NAME,
 	.ops		= &au1xpsc_pcm_ops,
 	.pcm_new	= au1xpsc_pcm_new,
 };
@@ -344,8 +347,8 @@ static int au1xpsc_pcm_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dmadata);
 
-	return devm_snd_soc_register_platform(&pdev->dev,
-					      &au1xpsc_soc_platform);
+	return devm_snd_soc_register_component(&pdev->dev,
+					&au1xpsc_soc_component, NULL, 0);
 }
 
 static struct platform_driver au1xpsc_pcm_driver = {
-- 
2.16.1
