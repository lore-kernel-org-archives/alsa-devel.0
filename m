From: Daniel Mack <daniel@caiaq.de>
Subject: Re: device underruns
Date: Mon, 27 Apr 2009 12:05:02 +0200
Message-ID: <20090427100502.GC8196@buzzloop.caiaq.de>
References: <20090331144603.GJ16811@buzzloop.caiaq.de>
	<20090425122338.GE23274@buzzloop.caiaq.de>
	<s5hk557wtlv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 2695824556
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 12:05:05 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk557wtlv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 01:18:52PM +0200, Takashi Iwai wrote:
> > The posting below didn't get any response yet, but the problem persists.
> > Any hints, anyone?
> 
> The ALSA PCM core just relies upon two things from the lowlevel driver:
> 
> 1. The lowlevel driver calls snd_pcm_period_elapsed() at each time
>    when the set-up period size has been processed by the hardware.
> 2. The pointer callback reports the sane position as the current
>    position; not below the previous position and not above the next
>    period boundary.
> 
> Especially pulseaudio is very sensitive about these two things,
> because it always asks the driver the current position.  Thus, if your
> driver doesn't fulfill the above conditions, it won't work properly.

Oh well. Stupid me. I think I fixed it, and wonder why it didn't break
more things. Could you apply the patch below?

Thanks,
Daniel

diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 3f45c0f..b13ce76 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -195,11 +195,14 @@ static int snd_usb_caiaq_pcm_prepare(struct snd_pcm_substream *substream)
 
 	debug("%s(%p)\n", __func__, substream);
 	
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		dev->period_out_count[index] = BYTES_PER_SAMPLE + 1;
 		dev->audio_out_buf_pos[index] = BYTES_PER_SAMPLE + 1;
-	else
+	} else {
+		dev->period_in_count[index] = BYTES_PER_SAMPLE;
 		dev->audio_in_buf_pos[index] = BYTES_PER_SAMPLE;
-	
+	}
+
 	if (dev->streaming)
 		return 0;
 	
@@ -300,8 +303,7 @@ static void check_for_elapsed_periods(struct snd_usb_caiaqdev *dev,
 		if (!sub)
 			continue;
 
-		pb = frames_to_bytes(sub->runtime, 
-				     sub->runtime->period_size);
+		pb = snd_pcm_lib_period_bytes(sub);
 		cnt = (sub->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
 					&dev->period_out_count[stream] :
 					&dev->period_in_count[stream];
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index 6d51770..515de1c 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -35,7 +35,7 @@
 #include "input.h"
 
 MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
-MODULE_DESCRIPTION("caiaq USB audio, version 1.3.13");
+MODULE_DESCRIPTION("caiaq USB audio, version 1.3.14");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Native Instruments, RigKontrol2},"
 			 "{Native Instruments, RigKontrol3},"
