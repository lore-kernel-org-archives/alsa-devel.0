From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmaengine: Fix missing __user prefix in
	copy_user callback" to the asoc tree
Date: Thu, 26 Jul 2018 16:01:10 +0100 (BST)
Message-ID: <20180726150110.D9942440078@finisterre.ee.mobilebroadband>
References: <20180725204208.15230-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9191826779A
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 17:01:11 +0200 (CEST)
In-Reply-To: <20180725204208.15230-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmaengine: Fix missing __user prefix in copy_user callback

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

>From 40d1299f87bf915931970c8e6ea3852acacd1889 Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 25 Jul 2018 22:42:08 +0200
Subject: [PATCH] ASoC: dmaengine: Fix missing __user prefix in copy_user
 callback

It seems that __user prefix was forgotten to be added to
dmaengine_copy_user callback while we refactored the user-copy PCM
core.

This patch adds the missing prefix, remove the superfluous cast, and
add the needed cast (__force is needed for downgrading from user
pointer to kernel pointer), too.

Spotted by a sparse warning like:
  sound/soc/soc-generic-dmaengine-pcm.c:397:27: warning: incorrect type in initializer (incompatible argument 4 (different address spaces))

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 13bdca6e41c5..120f7b39e256 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -334,7 +334,7 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 
 static int dmaengine_copy_user(struct snd_pcm_substream *substream,
 			       int channel, unsigned long hwoff,
-			       void *buf, unsigned long bytes)
+			       void __user *buf, unsigned long bytes)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component =
@@ -350,18 +350,17 @@ static int dmaengine_copy_user(struct snd_pcm_substream *substream,
 	int ret;
 
 	if (is_playback)
-		if (copy_from_user(dma_ptr, (void __user *)buf, bytes))
+		if (copy_from_user(dma_ptr, buf, bytes))
 			return -EFAULT;
 
 	if (process) {
-		ret = process(substream, channel, hwoff,
-			      (void __user *)buf, bytes);
+		ret = process(substream, channel, hwoff, (__force void *)buf, bytes);
 		if (ret < 0)
 			return ret;
 	}
 
 	if (!is_playback)
-		if (copy_to_user((void __user *)buf, dma_ptr, bytes))
+		if (copy_to_user(buf, dma_ptr, bytes))
 			return -EFAULT;
 
 	return 0;
-- 
2.18.0
