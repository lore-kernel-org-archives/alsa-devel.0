From: Antonio Ospite <ao2@amarulasolutions.com>
Subject: [PATCH 2/4] ALSA: snd-usb-caiaq: use vmalloc buffers
Date: Fri, 21 Jun 2013 13:11:49 +0200
Message-ID: <1371813111-26661-3-git-send-email-ao2@amarulasolutions.com>
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
 sound/usb/caiaq/audio.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index c191618..7103b09 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -183,14 +183,15 @@ static int snd_usb_caiaq_substream_close(struct snd_pcm_substream *substream)
 static int snd_usb_caiaq_pcm_hw_params(struct snd_pcm_substream *sub,
 				       struct snd_pcm_hw_params *hw_params)
 {
-	return snd_pcm_lib_malloc_pages(sub, params_buffer_bytes(hw_params));
+	return snd_pcm_lib_alloc_vmalloc_buffer(sub,
+						params_buffer_bytes(hw_params));
 }
 
 static int snd_usb_caiaq_pcm_hw_free(struct snd_pcm_substream *sub)
 {
 	struct snd_usb_caiaqdev *cdev = snd_pcm_substream_chip(sub);
 	deactivate_substream(cdev, sub);
-	return snd_pcm_lib_free_pages(sub);
+	return snd_pcm_lib_free_vmalloc_buffer(sub);
 }
 
 /* this should probably go upstream */
@@ -345,7 +346,9 @@ static struct snd_pcm_ops snd_usb_caiaq_ops = {
 	.hw_free =	snd_usb_caiaq_pcm_hw_free,
 	.prepare =	snd_usb_caiaq_pcm_prepare,
 	.trigger =	snd_usb_caiaq_pcm_trigger,
-	.pointer =	snd_usb_caiaq_pcm_pointer
+	.pointer =	snd_usb_caiaq_pcm_pointer,
+	.page =		snd_pcm_lib_get_vmalloc_page,
+	.mmap =		snd_pcm_lib_mmap_vmalloc,
 };
 
 static void check_for_elapsed_periods(struct snd_usb_caiaqdev *cdev,
@@ -852,11 +855,6 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 	snd_pcm_set_ops(cdev->pcm, SNDRV_PCM_STREAM_CAPTURE,
 				&snd_usb_caiaq_ops);
 
-	snd_pcm_lib_preallocate_pages_for_all(cdev->pcm,
-					SNDRV_DMA_TYPE_CONTINUOUS,
-					snd_dma_continuous_data(GFP_KERNEL),
-					MAX_BUFFER_SIZE, MAX_BUFFER_SIZE);
-
 	cdev->data_cb_info =
 		kmalloc(sizeof(struct snd_usb_caiaq_cb_info) * N_URBS,
 					GFP_KERNEL);
-- 
1.8.3.1
