From: Alan Young <Alan.Young@IEE.org>
Subject: Re: Improving status timestamp accuracy
Date: Fri, 8 Jul 2016 16:03:32 +0100
Message-ID: <577FC0C4.1060508@IEE.org>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
 <5753FFF0.3050200@gmail.com> <s5hwpm2n2bq.wl-tiwai@suse.de>
 <57554591.20103@gmail.com>
 <51c7887a-db2f-ee88-8290-2f2d21d6435d@linux.intel.com>
 <57566D64.1050400@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040709030304090502000809"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
 [209.85.220.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BE5A265D85
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 17:03:36 +0200 (CEST)
Received: by mail-pa0-f68.google.com with SMTP id dx3so7685994pab.2
 for <alsa-devel@alsa-project.org>; Fri, 08 Jul 2016 08:03:36 -0700 (PDT)
In-Reply-To: <57566D64.1050400@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>
Cc: Raymond Yau <superquad.vortex2@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040709030304090502000809
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

On 07/06/16 07:44, Alan Young wrote:
> I'll work on developing and testing a patch for consideration before 
> coming back to the last. It will be easier to discuss the merits or 
> otherwise of my proposal with a concrete, working patch to consider.


Well, it has been a few weeks but this is what I have come up with.

It is not perfect because of the issue noted in the comments but so far 
I have not been able to discover any downside. It many (most) cases, the 
reported delay (and audio_tstamp) is more accurate than it was before. 
In other cases there is no change.

Alan.

--------------040709030304090502000809
Content-Type: text/x-patch;
 name="0001-Improve-accuracy-of-delay-and-audio_tstamp-reporting.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-Improve-accuracy-of-delay-and-audio_tstamp-reporting.pa";
 filename*1="tch"

>From 0c1378b8faa91e7bebf63a60ece3c5c942652a53 Mon Sep 17 00:00:00 2001
From: Alan Young <consult.awy@gmail.com>
Date: Fri, 8 Jul 2016 14:08:10 +0100
Subject: [PATCH] Improve accuracy of delay and audio_tstamp reporting.

pcm_lib.c:snd_pcm_update_hw_ptr0() is responsible for updating the
data used for various status reporting calls.  Many drivers do not
update the position upon a call to substream->ops->pointer() other
then within an interrupt callback. Most drivers also do not update
substream->runtime->delay (in the pointer() call) -- the main exception
being USB drivers. Consequently reported delay and audio_tstamp values
will, in these cases, be inaccurate by the time elapsed since the last
interrupt callback.

By recording the delay at the time of an interrupt callback, and the
timestamp at that time, the reported delay and audio_tstamp values
can be adjusted to compensate for the time elapsed since the last
interrupt. These adjustments are only made if the reported position or
delay (as appropriate) have not changed since those recorded at the time
of that interrupt.

This approach fails if reported delay is adjusted to account from some
data (such as the CODEC delay) but the position is not adjusted to the
(probably more significant) current DMA offset.
---
 include/sound/pcm.h  |  2 ++
 sound/core/pcm_lib.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index b0be092..55da224 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -417,6 +417,8 @@ struct snd_pcm_runtime {
 	struct snd_pcm_audio_tstamp_config audio_tstamp_config;
 	struct snd_pcm_audio_tstamp_report audio_tstamp_report;
 	struct timespec driver_tstamp;
+	snd_pcm_sframes_t interrupt_delay;
+	struct timespec interrupt_tstamp;
 
 #if defined(CONFIG_SND_PCM_OSS) || defined(CONFIG_SND_PCM_OSS_MODULE)
 	/* -- OSS things -- */
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6b5a811..96cde4e 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -263,6 +263,12 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
 		audio_nsecs = div_u64(audio_frames * 1000000000LL,
 				runtime->rate);
 		*audio_tstamp = ns_to_timespec(audio_nsecs);
+
+		if (!runtime->audio_tstamp_config.report_delay && runtime->interrupt_tstamp.tv_sec
+				&& runtime->status->hw_ptr == runtime->hw_ptr_interrupt) {
+			struct timespec delta_time = timespec_sub(*curr_tstamp, runtime->interrupt_tstamp);
+			*audio_tstamp = timespec_add(*audio_tstamp, delta_time);
+		}
 	}
 	runtime->status->audio_tstamp = *audio_tstamp;
 	runtime->status->tstamp = *curr_tstamp;
@@ -275,6 +281,40 @@ static void update_audio_tstamp(struct snd_pcm_substream *substream,
 	runtime->driver_tstamp = driver_tstamp;
 }
 
+static void update_delay(struct snd_pcm_substream *substream,
+			struct timespec *curr_tstamp)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct timespec delta_time;
+	snd_pcm_sframes_t delta;
+
+	/* Can only adjust the delay if we have base timestamp. */
+	if (runtime->tstamp_mode != SNDRV_PCM_TSTAMP_ENABLE || !runtime->interrupt_tstamp.tv_sec)
+		return;
+
+	if (runtime->delay != runtime->interrupt_delay) {
+		/*
+		 *  Assume accurate if changed,
+		 *  which is not correct if driver supports variable
+		 *  codec delay reporting or similar
+		 */
+		return;
+	}
+
+	delta_time = timespec_sub(*curr_tstamp, runtime->interrupt_tstamp);
+	delta = (delta_time.tv_sec * USEC_PER_SEC + delta_time.tv_nsec / NSEC_PER_USEC)
+			* runtime->rate / USEC_PER_SEC;
+
+	/* sanity check */
+	if (delta > runtime->period_size)
+		return;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		runtime->delay = runtime->interrupt_delay - delta;
+	else
+		runtime->delay = runtime->interrupt_delay + delta;
+}
+
 static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 				  unsigned int in_interrupt)
 {
@@ -311,6 +351,11 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 				snd_pcm_gettime(runtime, (struct timespec *)&curr_tstamp);
 		} else
 			snd_pcm_gettime(runtime, (struct timespec *)&curr_tstamp);
+
+		if (in_interrupt) {
+			runtime->interrupt_delay = runtime->delay;
+			runtime->interrupt_tstamp = curr_tstamp;
+		}
 	}
 
 	if (pos == SNDRV_PCM_POS_XRUN) {
@@ -453,6 +498,9 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
 	}
 
  no_delta_check:
+	if (!in_interrupt && new_hw_ptr == runtime->hw_ptr_interrupt) {
+		update_delay(substream, &curr_tstamp);
+	}
 	if (runtime->status->hw_ptr == new_hw_ptr) {
 		update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp);
 		return 0;
-- 
2.5.5


--------------040709030304090502000809
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040709030304090502000809--
