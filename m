From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Linux 2.6.38 freeze because of
	sound/core/pcm_lib.c commit 59ff878ffb26bc0be812ca8295799164f413ae88
Date: Thu, 31 Mar 2011 13:58:43 +0200
Message-ID: <4D946C73.4090402@ladisch.de>
References: <AANLkTin17=rCU4eDGYtnVFZ1ffbUn+var4Q_AQUuGKaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay06.ispgateway.de (smtprelay06.ispgateway.de
	[80.67.31.102]) by alsa0.perex.cz (Postfix) with ESMTP id 68D102442E
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Mar 2011 13:57:29 +0200 (CEST)
In-Reply-To: <AANLkTin17=rCU4eDGYtnVFZ1ffbUn+var4Q_AQUuGKaw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Christopher K." <c.krooss@googlemail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Christopher K. wrote:
> Kernel 2.6.38 has been freezing ever since rc1 on my asus p7p55d.
> After booting up, the kernel seems to use a lot of cpu-time and after
> 20-30 seconds
> the system comes to a complete halt.
> 
> I just finished bisecting 2.6.37 - 2.6.38-rc1 and found this commit to
> be responsible:
> 
> 59ff878ffb26bc0be812ca8295799164f413ae88

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
