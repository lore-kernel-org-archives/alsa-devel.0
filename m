From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH V2 2/3] ASoC: don't leak on error in
	snd_dmaengine_pcm_register
Date: Tue,  3 Dec 2013 14:26:33 -0700
Message-ID: <1386105994-16373-2-git-send-email-swarren@wwwdotorg.org>
References: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id 7E8732652D3
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 22:26:41 +0100 (CET)
In-Reply-To: <1386105994-16373-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

If snd_dmaengine_pcm_register()'s call to snd_soc_add_platform() fails,
all objects allocated during registration are leaked. Fix this by adding
error-handling code.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2 (new as a separate patch):
* Re-ordered patches, so that patch 3/3 in this series could be available
  in the ASoC tree without having to wait for the patches to the DMA tree
  the implement deferred probe during channel allocation.
---
 sound/soc/soc-generic-dmaengine-pcm.c | 38 +++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 88b011b80058..a66bb03b64cd 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -310,6 +310,20 @@ static void dmaengine_pcm_request_chan_of(struct dmaengine_pcm *pcm,
 		pcm->chan[1] = pcm->chan[0];
 }
 
+static void dmaengine_pcm_release_chan(struct dmaengine_pcm *pcm)
+{
+	unsigned int i;
+
+	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE;
+	     i++) {
+		if (!pcm->chan[i])
+			continue;
+		dma_release_channel(pcm->chan[i]);
+		if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
+			break;
+	}
+}
+
 /**
  * snd_dmaengine_pcm_register - Register a dmaengine based PCM device
  * @dev: The parent device for the PCM device
@@ -320,6 +334,7 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	const struct snd_dmaengine_pcm_config *config, unsigned int flags)
 {
 	struct dmaengine_pcm *pcm;
+	int ret;
 
 	pcm = kzalloc(sizeof(*pcm), GFP_KERNEL);
 	if (!pcm)
@@ -331,11 +346,20 @@ int snd_dmaengine_pcm_register(struct device *dev,
 	dmaengine_pcm_request_chan_of(pcm, dev);
 
 	if (flags & SND_DMAENGINE_PCM_FLAG_NO_RESIDUE)
-		return snd_soc_add_platform(dev, &pcm->platform,
+		ret = snd_soc_add_platform(dev, &pcm->platform,
 				&dmaengine_no_residue_pcm_platform);
 	else
-		return snd_soc_add_platform(dev, &pcm->platform,
+		ret = snd_soc_add_platform(dev, &pcm->platform,
 				&dmaengine_pcm_platform);
+	if (ret)
+		goto err_free_dma;
+
+	return 0;
+
+err_free_dma:
+	dmaengine_pcm_release_chan(pcm);
+	kfree(pcm);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_register);
 
@@ -350,7 +374,6 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 {
 	struct snd_soc_platform *platform;
 	struct dmaengine_pcm *pcm;
-	unsigned int i;
 
 	platform = snd_soc_lookup_platform(dev);
 	if (!platform)
@@ -358,15 +381,8 @@ void snd_dmaengine_pcm_unregister(struct device *dev)
 
 	pcm = soc_platform_to_pcm(platform);
 
-	for (i = SNDRV_PCM_STREAM_PLAYBACK; i <= SNDRV_PCM_STREAM_CAPTURE; i++) {
-		if (pcm->chan[i]) {
-			dma_release_channel(pcm->chan[i]);
-			if (pcm->flags & SND_DMAENGINE_PCM_FLAG_HALF_DUPLEX)
-				break;
-		}
-	}
-
 	snd_soc_remove_platform(platform);
+	dmaengine_pcm_release_chan(pcm);
 	kfree(pcm);
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_unregister);
-- 
1.8.1.5
