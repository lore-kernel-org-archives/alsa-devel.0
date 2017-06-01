From: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH v2 24/27] usb: gadget: u_uac1: Kill set_fs() usage
Date: Thu,  1 Jun 2017 22:58:47 +0200
Message-ID: <20170601205850.24993-25-tiwai@suse.de>
References: <20170601205850.24993-1-tiwai@suse.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170601205850.24993-1-tiwai-l3A5Bk7waGM@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Takashi Sakamoto <o-takashi-sodqOivclbsO3cATojSK5Q@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

With the new API to perform the in-kernel buffer copy, we can get rid
of set_fs() usage in this driver, finally.

Signed-off-by: Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>
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

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
