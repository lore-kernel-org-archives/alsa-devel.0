From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-i2s: replace platform to
	component" to the asoc tree
Date: Mon, 12 Feb 2018 12:29:56 +0000
Message-ID: <E1elDF6-0003An-E5@debutante>
References: <874lnrgay7.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BD742673D0
 for <alsa-devel@alsa-project.org>; Mon, 12 Feb 2018 13:30:00 +0100 (CET)
In-Reply-To: <874lnrgay7.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: davinci-i2s: replace platform to component

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

>From a49cb31cc7c84eab032c790df476f57ad14c8eeb Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Jan 2018 02:46:04 +0000
Subject: [PATCH] ASoC: davinci-i2s: replace platform to component

Now platform can be replaced to component, let's do it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-i2s.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 384961651904..807040bb3921 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -34,6 +34,7 @@
 #include "edma-pcm.h"
 #include "davinci-i2s.h"
 
+#define DRV_NAME "davinci-i2s"
 
 /*
  * NOTE:  terminology here is confusing.
@@ -190,7 +191,7 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
-	struct snd_soc_platform *platform = rtd->platform;
+	struct snd_soc_component *component = snd_soc_rtdcom_lookup(rtd, DRV_NAME);
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	u32 spcr;
 	u32 mask = playback ? DAVINCI_MCBSP_SPCR_XRST : DAVINCI_MCBSP_SPCR_RRST;
@@ -211,8 +212,8 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 	if (playback) {
 		/* Stop the DMA to avoid data loss */
 		/* while the transmitter is out of reset to handle XSYNCERR */
-		if (platform->driver->ops->trigger) {
-			int ret = platform->driver->ops->trigger(substream,
+		if (component->driver->ops->trigger) {
+			int ret = component->driver->ops->trigger(substream,
 				SNDRV_PCM_TRIGGER_STOP);
 			if (ret < 0)
 				printk(KERN_DEBUG "Playback DMA stop failed\n");
@@ -233,8 +234,8 @@ static void davinci_mcbsp_start(struct davinci_mcbsp_dev *dev,
 		toggle_clock(dev, playback);
 
 		/* Restart the DMA */
-		if (platform->driver->ops->trigger) {
-			int ret = platform->driver->ops->trigger(substream,
+		if (component->driver->ops->trigger) {
+			int ret = component->driver->ops->trigger(substream,
 				SNDRV_PCM_TRIGGER_START);
 			if (ret < 0)
 				printk(KERN_DEBUG "Playback DMA start failed\n");
@@ -651,7 +652,7 @@ static struct snd_soc_dai_driver davinci_i2s_dai = {
 };
 
 static const struct snd_soc_component_driver davinci_i2s_component = {
-	.name		= "davinci-i2s",
+	.name		= DRV_NAME,
 };
 
 static int davinci_i2s_probe(struct platform_device *pdev)
-- 
2.16.1
