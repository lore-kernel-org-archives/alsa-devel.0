From: Alan Young <consult.awy@gmail.com>
Subject: Re: Improving status timestamp accuracy
Date: Sun, 5 Jun 2016 11:33:20 +0100
Message-ID: <5753FFF0.3050200@gmail.com>
References: <5752A005.2050309@gmail.com>
 <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f65.google.com (mail-wm0-f65.google.com [74.125.82.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B2858261294
 for <alsa-devel@alsa-project.org>; Sun,  5 Jun 2016 12:33:21 +0200 (CEST)
Received: by mail-wm0-f65.google.com with SMTP id m124so8435538wme.3
 for <alsa-devel@alsa-project.org>; Sun, 05 Jun 2016 03:33:21 -0700 (PDT)
In-Reply-To: <CAN8cciZN=Gjq3Za+Qz31EYoCsTuTNp4au_Upxq8ZvvEJqNdw9w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/06/16 02:14, Raymond Yau wrote:
> the point only increment in DMA brust size , so it is not sample accurate
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/include/linux/dmaengine.h
>
> |* @DMA_RESIDUE_GRANULARITY_BURST: |Residue is updated after each 
> transferred
> |* burst. This is typically only supported if the hardware has a 
> progress * register of some sort (E.g. a register with the current 
> read/write address * or a register with the amount of 
> bursts/beats/bytes that have been * transferred or still need to be 
> transferred).|
> ||
> |if the driver point callback does not read from hardware register , it 
> should use |
> ||
> |
> |DMA_RESIDUE_GRANULARITY_DESCRIPTOR: Residue reporting is not support. 
> The * DMA channel is only able to tell whether a descriptor has been 
> completed or * not, which means residue reporting is not supported by 
> this channel. The * residue field of the dma_tx_state field will 
> always be 0.|
> |


Yes, I understand that. And that is exactly my point. Because of this a 
pcm_status() result is only accurate to a granularity of period in most 
cases.

In fact, some drivers, for example imx sdma, declare 
DMA_RESIDUE_GRANULARITY_BURST accuracy because sometimes they may have 
such an accuracy but in practice, at least for audio, they only actually 
achieve period accuracy.

Regardless of what value of DMA_RESIDUE_GRANULARITY_xxx that a driver 
claims to support, it is not really defined how fine a burst might be. 
So the end result is, from the point of view of audio, that the 
resulting position obtained by the pointer() call is pretty inaccurate. 
Hence my proposal to attempt to improve the accuracy of the pcm_status() 
result given the above constraints.

The following patch gives an idea of what I am considering:

diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index 6b5a811..ea5b525 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -234,7 +234,8 @@ int snd_pcm_update_state(struct snd_pcm_substream 
*substream,

  static void update_audio_tstamp(struct snd_pcm_substream *substream,
                  struct timespec *curr_tstamp,
-                struct timespec *audio_tstamp)
+                struct timespec *audio_tstamp,
+                unsigned int adjust_existing_audio_tstamp)
  {
      struct snd_pcm_runtime *runtime = substream->runtime;
      u64 audio_frames, audio_nsecs;
@@ -252,17 +253,23 @@ static void update_audio_tstamp(struct 
snd_pcm_substream *substream,
           * add delay only if requested
           */

-        audio_frames = runtime->hw_ptr_wrap + runtime->status->hw_ptr;
+        if (adjust_existing_audio_tstamp && 
runtime->status->tstamp->tv_sec) {
+            struct timespec delta =
+                timespec_sub(*curr_tstamp, runtime->status->tstamp);
+            *audio_tstamp = timespec_add(*audio_tstamp, delta);
+        } else {
+            audio_frames = runtime->hw_ptr_wrap + runtime->status->hw_ptr;

-        if (runtime->audio_tstamp_config.report_delay) {
-            if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-                audio_frames -=  runtime->delay;
-            else
-                audio_frames +=  runtime->delay;
+            if (runtime->audio_tstamp_config.report_delay) {
+                if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+                    audio_frames -=  runtime->delay;
+                else
+                    audio_frames +=  runtime->delay;
+            }
+            audio_nsecs = div_u64(audio_frames * 1000000000LL,
+                    runtime->rate);
+            *audio_tstamp = ns_to_timespec(audio_nsecs);
          }
-        audio_nsecs = div_u64(audio_frames * 1000000000LL,
-                runtime->rate);
-        *audio_tstamp = ns_to_timespec(audio_nsecs);
      }
      runtime->status->audio_tstamp = *audio_tstamp;
      runtime->status->tstamp = *curr_tstamp;
@@ -454,7 +461,7 @@ static int snd_pcm_update_hw_ptr0(struct 
snd_pcm_substream *substream,

   no_delta_check:
      if (runtime->status->hw_ptr == new_hw_ptr) {
-        update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp);
+        update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp, 
!in_interrupt);
          return 0;
      }

@@ -479,7 +486,7 @@ static int snd_pcm_update_hw_ptr0(struct 
snd_pcm_substream *substream,
          runtime->hw_ptr_wrap += runtime->boundary;
      }

-    update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp);
+    update_audio_tstamp(substream, &curr_tstamp, &audio_tstamp, 
!in_interrupt);

      return snd_pcm_update_state(substream, runtime);
  }
