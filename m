From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 2.6.38+ hard lockup in pcm_lib.c
Date: Thu, 31 Mar 2011 09:11:16 +0200
Message-ID: <4D942914.3020404@ladisch.de>
References: <4D9314A1.7030106@silka.with-linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 710F0246DA
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 09:10:00 +0200 (CEST)
In-Reply-To: <4D9314A1.7030106@silka.with-linux.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kelly Anderson <kelly@silka.with-linux.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Kelly Anderson wrote:
> I had a consistent hard-lockup on one of my machines, an Amd X6, just
> after Kdm loaded the desktop (most certainly when it decides to start
> talking to the sound card).  Everything was dead, even ssh access to the
> computer.  I git bisected it until I found the commit that was causing
> it.  After reverting the patch everything is fine.
> 
> commit 59ff878ffb26bc0be812ca8295799164f413ae88
> Author: Clemens Ladisch
> Date:   Thu Nov 18 09:43:52 2010 +0100
> 
>      ALSA: pcm: detect xruns in no-period-wakeup mode

This looks as if you get an infinite loop, probably because
hw_ptr_buffer_jiffies is zero.

Please try this patch:

--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -425,6 +425,8 @@ static int snd_pcm_hw_params(struct snd_
 	runtime->no_period_wakeup =
 			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
 			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
+	runtime->hw_ptr_buffer_jiffies =
+			max(1uL, (runtime->buffer_size * HZ) / runtime->rate);
 
 	bits = snd_pcm_format_physical_width(runtime->format);
 	runtime->sample_bits = bits;
@@ -866,8 +868,6 @@ static void snd_pcm_post_start(struct sn
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_trigger_tstamp(substream);
 	runtime->hw_ptr_jiffies = jiffies;
-	runtime->hw_ptr_buffer_jiffies = (runtime->buffer_size * HZ) / 
-							    runtime->rate;
 	runtime->status->state = state;
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
 	    runtime->silence_size > 0)
