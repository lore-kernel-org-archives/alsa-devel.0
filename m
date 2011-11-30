From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Wed, 30 Nov 2011 16:59:18 +0530
Message-ID: <1322652558.1516.989.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hbos2g4af.wl%tiwai@suse.de> <1322106354.1516.951.camel@vkoul-udesk3>
	<s5hfwhd29a5.wl%tiwai@suse.de> <1322127157.1516.973.camel@vkoul-udesk3>
	<s5h1usrxujv.wl%tiwai@suse.de>  <s5hty5lvowr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id F23BD103A7C
	for <alsa-devel@alsa-project.org>; Wed, 30 Nov 2011 12:31:48 +0100 (CET)
In-Reply-To: <s5hty5lvowr.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-11-30 at 12:19 +0100, Takashi Iwai wrote:
> At Tue, 29 Nov 2011 15:15:01 -0600,
> Pierre-Louis Bossart wrote:
> Well, my question is much more simple.  In the patch, there are checks
> of the stream direction in snd_compr_{fragment|frame}_elapsed()
> functions.
> 
> +void snd_compr_fragment_elapsed(struct snd_compr_stream *stream)
> +{
> +	pr_debug("fragment elapsed called\n");
> +	if (stream->direction !=  SNDRV_DEVICE_TYPE_COMPR_PLAYBACK)
> +		return;
> +	wake_up(&stream->runtime->sleep);
> +}
> +EXPORT_SYMBOL_GPL(snd_compr_fragment_elapsed);
> +
> +void snd_compr_frame_elapsed(struct snd_compr_stream *stream)
> +{
> +	if (stream->direction != SNDRV_DEVICE_TYPE_COMPR_CAPTURE)
> +		return;
> +	wake_up(&stream->runtime->sleep);
> +}
> +EXPORT_SYMBOL_GPL(snd_compr_frame_elapsed);
> 
> And I wonder why this restriction *must* be present in the API-level
> implementation.
> 
> And, furthermore, I see no reason to have this individual functions.
> Why simply not an inline function like
> 
> static inline void snd_compr_stream_elapsed(struct snd_compr_stream *stream)
> {
> 	wake_up(&stream->runtime->sleep);
> }
> 
> ??  Then you can reduce two exported symbols and less stack usages.
> 
Thanks, I have already changed this as above based on your suggestion
last week :)

But I have kept two different functions doing same thing for sake of
confusion. For playback you need to call this on
block/fragment/random_bytes but for capture it needs to be frame based.

-- 
~Vinod
