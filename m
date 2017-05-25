From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 12/14] usb: gadget: u_uac1: Kill set_fs() usage
Date: Thu, 25 May 2017 21:17:33 +0200
Message-ID: <20170525191735.13787-13-tiwai@suse.de>
References: <20170525191735.13787-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CB001267393
 for <alsa-devel@alsa-project.org>; Thu, 25 May 2017 21:17:41 +0200 (CEST)
In-Reply-To: <20170525191735.13787-1-tiwai@suse.de>
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
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

With the new API to perform the in-kernel buffer copy, we can get rid
of set_fs() usage in this driver, finally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/usb/gadget/function/u_uac1.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/u_uac1.c b/drivers/usb/gadget/function/u_uac1.c
index c78c84138a28..ca88e4c0fd1e 100644
--- a/drivers/usb/gadget/function/u_uac1.c
+++ b/drivers/usb/gadget/function/u_uac1.c
@@ -157,7 +157,6 @@ size_t u_audio_playback(struct gaudio *card, void *buf, size_t count)
 	struct gaudio_snd_dev	*snd = &card->playback;
 	struct snd_pcm_substream *substream = snd->substream;
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	mm_segment_t old_fs;
 	ssize_t result;
 	snd_pcm_sframes_t frames;
 
@@ -174,15 +173,11 @@ size_t u_audio_playback(struct gaudio *card, void *buf, size_t count)
 	}
 
 	frames = bytes_to_frames(runtime, count);
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	result = snd_pcm_lib_write(snd->substream, (void __user *)buf, frames);
+	result = snd_pcm_kernel_write(snd->substream, buf, frames);
 	if (result != frames) {
 		ERROR(card, "Playback error: %d\n", (int)result);
-		set_fs(old_fs);
 		goto try_again;
 	}
-	set_fs(old_fs);
 
 	return 0;
 }
-- 
2.13.0
