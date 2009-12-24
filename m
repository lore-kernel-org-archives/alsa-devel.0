From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Duplicate wake-ups in pcm_lib.c
Date: Thu, 24 Dec 2009 09:43:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912240922460.2598@eeebox2.perex-int.cz>
References: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7692610381D
	for <alsa-devel@alsa-project.org>; Thu, 24 Dec 2009 09:43:50 +0100 (CET)
In-Reply-To: <6160a5130912231228g29669e4ctfef9ea8f42633120@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pl bossart <bossart.nospam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 23 Dec 2009, pl bossart wrote:

> Thanks to Takashi's advice, I managed to find out the reason why I was
> seeing null events returned by poll(). This could explain why
> PulseAudio doesn't seem to sleep much. It turns out that we have two
> calls to wakeup() in pcm_lib.c, and a nice race condition it seems.
> See the log below.
>
> A wake-up is generated during the period interrupt, and a second
> wake-up is generated during the write loop, after the application was
> awaken but just before the pointers are updated. This second wake-up
> shouldn't exist, since the write loop actually fills the ring buffer.
> By the time the second wake-up is actually handled, there's really no
> space left in the buffer and a null event is generated; it'll wake-up
> the application a second time for nothing. Maybe we should move the
> call to snd_pcm_update_hw_ptr() after the transfer took place?

The right fix should be to preserve wakeups when write operation is in 
progress (also for interrupts). Something like this (untested):

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index c83a4a7..8112834 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -272,6 +272,7 @@ struct snd_pcm_runtime {
  	snd_pcm_uframes_t hw_ptr_interrupt; /* Position at interrupt time */
  	unsigned long hw_ptr_jiffies;	/* Time when hw_ptr is updated */
  	snd_pcm_sframes_t delay;	/* extra delay; typically FIFO size */
+	unsigned int nowake: 1;		/* do not wakeup */

  	/* -- HW params -- */
  	snd_pcm_access_t access;	/* access mode */
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 30f4108..26cf3ff 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -208,7 +208,7 @@ static int snd_pcm_update_hw_ptr_post(struct snd_pcm_substream *substream,
  			return -EPIPE;
  		}
  	}
-	if (avail >= runtime->control->avail_min)
+	if (!runtime->nowake && avail >= runtime->control->avail_min)
  		wake_up(&runtime->sleep);
  	return 0;
  }
@@ -1776,6 +1776,7 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
  		goto _end_unlock;
  	}

+	runtime->nowake = 1;
  	while (size > 0) {
  		snd_pcm_uframes_t frames, appl_ptr, appl_ofs;
  		snd_pcm_uframes_t avail;
@@ -1786,17 +1787,18 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
  		if (!avail) {
  			if (nonblock) {
  				err = -EAGAIN;
-				goto _end_unlock;
+				goto _end_wake;
  			}
  			err = wait_for_avail_min(substream, &avail);
  			if (err < 0)
-				goto _end_unlock;
+				goto _end_wake;
  		}
  		frames = size > avail ? avail : size;
  		cont = runtime->buffer_size - runtime->control->appl_ptr % runtime->buffer_size;
  		if (frames > cont)
  			frames = cont;
  		if (snd_BUG_ON(!frames)) {
+			runtime->nowake = 0;
  			snd_pcm_stream_unlock_irq(substream);
  			return -EINVAL;
  		}
@@ -1809,10 +1811,10 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
  		switch (runtime->status->state) {
  		case SNDRV_PCM_STATE_XRUN:
  			err = -EPIPE;
-			goto _end_unlock;
+			goto _end;
  		case SNDRV_PCM_STATE_SUSPENDED:
  			err = -ESTRPIPE;
-			goto _end_unlock;
+			goto _end;
  		default:
  			break;
  		}
@@ -1830,12 +1832,18 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
  		    snd_pcm_playback_hw_avail(runtime) >= (snd_pcm_sframes_t)runtime->start_threshold) {
  			err = snd_pcm_start(substream);
  			if (err < 0)
-				goto _end_unlock;
+				goto _end_wake;
  		}
  	}
+ _end_wake:
+ 	runtime->nowake = 0;
+ 	if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
+ 		snd_pcm_update_hw_ptr_post(substream, runtime);
   _end_unlock:
  	snd_pcm_stream_unlock_irq(substream);
+	return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
   _end:
+ 	runtime->nowake = 0;
  	return xfer > 0 ? (snd_pcm_sframes_t)xfer : err;
  }


-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
