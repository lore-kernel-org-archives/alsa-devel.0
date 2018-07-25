From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: dmaengine: Fix missing __user prefix in
	copy_user callback
Date: Wed, 25 Jul 2018 22:42:08 +0200
Message-ID: <20180725204208.15230-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 922BF26774B
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 22:42:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

It seems that __user prefix was forgotten to be added to
dmaengine_copy_user callback while we refactored the user-copy PCM
core.

This patch adds the missing prefix, remove the superfluous cast, and
add the needed cast (__force is needed for downgrading from user
pointer to kernel pointer), too.

Spotted by a sparse warning like:
  sound/soc/soc-generic-dmaengine-pcm.c:397:27: warning: incorrect type in initializer (incompatible argument 4 (different address spaces))

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-generic-dmaengine-pcm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 56a541b9ff9e..61027dd0ef91 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -343,7 +343,7 @@ static snd_pcm_uframes_t dmaengine_pcm_pointer(
 
 static int dmaengine_copy_user(struct snd_pcm_substream *substream,
 			       int channel, unsigned long hwoff,
-			       void *buf, unsigned long bytes)
+			       void __user *buf, unsigned long bytes)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_component *component =
@@ -359,18 +359,17 @@ static int dmaengine_copy_user(struct snd_pcm_substream *substream,
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
