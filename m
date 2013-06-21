From: Antonio Ospite <ao2@amarulasolutions.com>
Subject: [PATCH 3/4] ALSA: snd-usb-6fire: use vmalloc buffers
Date: Fri, 21 Jun 2013 13:11:50 +0200
Message-ID: <1371813111-26661-4-git-send-email-ao2@amarulasolutions.com>
References: <1371813111-26661-1-git-send-email-ao2@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1371813111-26661-1-git-send-email-ao2@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, patch@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@amarulasolutions.com>, Clemens Ladisch <clemens@ladisch.de>, Karsten Wiese <annabellesgarden@yahoo.de>, Torsten Schenk <torsten.schenk@zoho.com>, Daniel Mack <daniel@caiaq.de>, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

For USB devices it's not necessary to allocate physically contiguous
buffers.

Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
---
 sound/usb/6fire/pcm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/sound/usb/6fire/pcm.c b/sound/usb/6fire/pcm.c
index 40dd50a..c5b9cac 100644
--- a/sound/usb/6fire/pcm.c
+++ b/sound/usb/6fire/pcm.c
@@ -450,13 +450,13 @@ static int usb6fire_pcm_close(struct snd_pcm_substream *alsa_sub)
 static int usb6fire_pcm_hw_params(struct snd_pcm_substream *alsa_sub,
 		struct snd_pcm_hw_params *hw_params)
 {
-	return snd_pcm_lib_malloc_pages(alsa_sub,
-			params_buffer_bytes(hw_params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(alsa_sub,
+						params_buffer_bytes(hw_params));
 }
 
 static int usb6fire_pcm_hw_free(struct snd_pcm_substream *alsa_sub)
 {
-	return snd_pcm_lib_free_pages(alsa_sub);
+	return snd_pcm_lib_free_vmalloc_buffer(alsa_sub);
 }
 
 static int usb6fire_pcm_prepare(struct snd_pcm_substream *alsa_sub)
@@ -560,6 +560,8 @@ static struct snd_pcm_ops pcm_ops = {
 	.prepare = usb6fire_pcm_prepare,
 	.trigger = usb6fire_pcm_trigger,
 	.pointer = usb6fire_pcm_pointer,
+	.page = snd_pcm_lib_get_vmalloc_page,
+	.mmap = snd_pcm_lib_mmap_vmalloc,
 };
 
 static void usb6fire_pcm_init_urb(struct pcm_urb *urb,
@@ -622,10 +624,6 @@ int usb6fire_pcm_init(struct sfire_chip *chip)
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_ops);
 	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_CAPTURE, &pcm_ops);
 
-	ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
-			SNDRV_DMA_TYPE_CONTINUOUS,
-			snd_dma_continuous_data(GFP_KERNEL),
-			MAX_BUFSIZE, MAX_BUFSIZE);
 	if (ret) {
 		kfree(rt);
 		snd_printk(KERN_ERR PREFIX
-- 
1.8.3.1
