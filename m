From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH next 2/2] ALSA: pcm: Disable mmap for known
	broken archs
Date: Wed, 22 Oct 2014 12:15:49 +0200
Message-ID: <1413972949-11290-2-git-send-email-tiwai@suse.de>
References: <1413972949-11290-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 141DA260667
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 12:15:55 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E63C6AD2B
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 10:15:54 +0000 (UTC)
In-Reply-To: <1413972949-11290-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Some architectures like PARISC is known not to support mmap properly
with the DMA buffer, where dma_mmap_coherent() returns -EINVAL
unconditionally.  From the API POV, we should rather drop the mmap
support there and expose it before the user-space tries to call mmap.

The patch contains again ugly ifdef's, unfortunately, as there is no
global flag indicating this.  Once when such macro is defined, we can
get rid of this instead.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/pcm_native.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index aa6754da7929..dc9a1355a4ab 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -192,6 +192,21 @@ int snd_pcm_info_user(struct snd_pcm_substream *substream,
 	return err;
 }
 
+static bool hw_support_mmap(struct snd_pcm_substream *substream)
+{
+	if (!(substream->runtime->hw.info & SNDRV_PCM_INFO_MMAP))
+		return false;
+	/* check architectures that return -EINVAL from dma_mmap_coherent() */
+	/* FIXME: this should be some global flag */
+#if defined(CONFIG_C6X) || defined(CONFIG_FRV) || defined(CONFIG_MN10300) ||\
+	defined(CONFIG_PARISC) || defined(CONFIG_XTENSA)
+	if (!substream->ops->mmap &&
+	    substream->dma_buffer.dev.type == SNDRV_DMA_TYPE_DEV)
+		return false;
+#endif
+	return true;
+}
+
 #undef RULES_DEBUG
 
 #ifdef RULES_DEBUG
@@ -369,8 +384,12 @@ int snd_pcm_hw_refine(struct snd_pcm_substream *substream,
 	}
 
 	hw = &substream->runtime->hw;
-	if (!params->info)
+	if (!params->info) {
 		params->info = hw->info & ~SNDRV_PCM_INFO_FIFO_IN_FRAMES;
+		if (!hw_support_mmap(substream))
+			params->info &= ~(SNDRV_PCM_INFO_MMAP |
+					  SNDRV_PCM_INFO_MMAP_VALID);
+	}
 	if (!params->fifo_size) {
 		m = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 		i = hw_param_interval(params, SNDRV_PCM_HW_PARAM_CHANNELS);
@@ -2069,7 +2088,7 @@ int snd_pcm_hw_constraints_complete(struct snd_pcm_substream *substream)
 		mask |= 1 << SNDRV_PCM_ACCESS_RW_INTERLEAVED;
         if (hw->info & SNDRV_PCM_INFO_NONINTERLEAVED)
 		mask |= 1 << SNDRV_PCM_ACCESS_RW_NONINTERLEAVED;
-	if (hw->info & SNDRV_PCM_INFO_MMAP) {
+	if (hw_support_mmap(substream)) {
 		if (hw->info & SNDRV_PCM_INFO_INTERLEAVED)
 			mask |= 1 << SNDRV_PCM_ACCESS_MMAP_INTERLEAVED;
 		if (hw->info & SNDRV_PCM_INFO_NONINTERLEAVED)
-- 
2.1.2
