From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: core: add hooks for audio
	timestamps
Date: Fri, 28 Sep 2012 11:33:50 +0200
Message-ID: <50656EFE.40407@ladisch.de>
References: <1348820142-15822-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B1357261693
 for <alsa-devel@alsa-project.org>; Fri, 28 Sep 2012 11:33:54 +0200 (CEST)
In-Reply-To: <1348820142-15822-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> @@ -506,8 +512,27 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
> +		if (!(runtime->hw.info & SNDRV_PCM_INFO_HAS_WALL_CLOCK)) {
> +			/*
> +			 * no wall clock available, provide audio timestamp
> +			 * derived from pointer position+delay
> +			 */
> +			u64 audio_frames, audio_nsecs;
> +
> +			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +				audio_frames = runtime->status->hw_ptr
> +					- runtime->delay;
> +			else
> +				audio_frames = runtime->status->hw_ptr
> +					+ runtime->delay;
> +			audio_nsecs = audio_frames * 1000000000LL /
> +				runtime->rate;

This looks like a 64-bit division.

And what happens if audio_frames becomes negative?


Regards,
Clemens
