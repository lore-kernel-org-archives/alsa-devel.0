From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: ice1712: Fix boundary checks in PCM
	pointer ops
Date: Tue,  8 Apr 2014 17:03:03 +0200
Message-ID: <1396969383-18683-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 21E4A26854B
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 17:03:03 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4F671AAF6
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 15:03:03 +0000 (UTC)
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

PCM pointer callbacks in ice1712 driver check the buffer size boundary
wrongly between bytes and frames.  This leads to PCM core warnings
like:
   snd_pcm_update_hw_ptr0: 105 callbacks suppressed
   ALSA pcm_lib.c:352 BUG: pcmC3D0c:0, pos = 5461, buffer size = 5461, period size = 2730

This patch fixes these checks to be placed after the proper unit
conversions.

Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/ice1712/ice1712.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index da005493f060..d9b9e4595f17 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -685,9 +685,10 @@ static snd_pcm_uframes_t snd_ice1712_playback_pointer(struct snd_pcm_substream *
 	if (!(snd_ice1712_read(ice, ICE1712_IREG_PBK_CTRL) & 1))
 		return 0;
 	ptr = runtime->buffer_size - inw(ice->ddma_port + 4);
+	ptr = bytes_to_frames(substream->runtime, ptr);
 	if (ptr == runtime->buffer_size)
 		ptr = 0;
-	return bytes_to_frames(substream->runtime, ptr);
+	return ptr;
 }
 
 static snd_pcm_uframes_t snd_ice1712_playback_ds_pointer(struct snd_pcm_substream *substream)
@@ -704,9 +705,10 @@ static snd_pcm_uframes_t snd_ice1712_playback_ds_pointer(struct snd_pcm_substrea
 		addr = ICE1712_DSC_ADDR0;
 	ptr = snd_ice1712_ds_read(ice, substream->number * 2, addr) -
 		ice->playback_con_virt_addr[substream->number];
+	ptr = bytes_to_frames(substream->runtime, ptr);
 	if (ptr == substream->runtime->buffer_size)
 		ptr = 0;
-	return bytes_to_frames(substream->runtime, ptr);
+	return ptr;
 }
 
 static snd_pcm_uframes_t snd_ice1712_capture_pointer(struct snd_pcm_substream *substream)
@@ -717,9 +719,10 @@ static snd_pcm_uframes_t snd_ice1712_capture_pointer(struct snd_pcm_substream *s
 	if (!(snd_ice1712_read(ice, ICE1712_IREG_CAP_CTRL) & 1))
 		return 0;
 	ptr = inl(ICEREG(ice, CONCAP_ADDR)) - ice->capture_con_virt_addr;
+	ptr = bytes_to_frames(substream->runtime, ptr);
 	if (ptr == substream->runtime->buffer_size)
 		ptr = 0;
-	return bytes_to_frames(substream->runtime, ptr);
+	return ptr;
 }
 
 static const struct snd_pcm_hardware snd_ice1712_playback = {
@@ -1116,9 +1119,10 @@ static snd_pcm_uframes_t snd_ice1712_playback_pro_pointer(struct snd_pcm_substre
 	if (!(inl(ICEMT(ice, PLAYBACK_CONTROL)) & ICE1712_PLAYBACK_START))
 		return 0;
 	ptr = ice->playback_pro_size - (inw(ICEMT(ice, PLAYBACK_SIZE)) << 2);
+	ptr = bytes_to_frames(substream->runtime, ptr);
 	if (ptr == substream->runtime->buffer_size)
 		ptr = 0;
-	return bytes_to_frames(substream->runtime, ptr);
+	return ptr;
 }
 
 static snd_pcm_uframes_t snd_ice1712_capture_pro_pointer(struct snd_pcm_substream *substream)
@@ -1129,9 +1133,10 @@ static snd_pcm_uframes_t snd_ice1712_capture_pro_pointer(struct snd_pcm_substrea
 	if (!(inl(ICEMT(ice, PLAYBACK_CONTROL)) & ICE1712_CAPTURE_START_SHADOW))
 		return 0;
 	ptr = ice->capture_pro_size - (inw(ICEMT(ice, CAPTURE_SIZE)) << 2);
+	ptr = bytes_to_frames(substream->runtime, ptr);
 	if (ptr == substream->runtime->buffer_size)
 		ptr = 0;
-	return bytes_to_frames(substream->runtime, ptr);
+	return ptr;
 }
 
 static const struct snd_pcm_hardware snd_ice1712_playback_pro = {
-- 
1.9.1
