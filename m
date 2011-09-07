From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: [RFC 4/5] compress: add the core file
Date: Wed, 7 Sep 2011 16:20:56 +0100
Message-ID: <20110907152056.GA23774@opensource.wolfsonmicro.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-5-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C45A2441B
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 17:21:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1314943585-11670-5-git-send-email-vinod.koul@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 02, 2011 at 11:36:24AM +0530, Vinod Koul wrote:
> This patch ads core.c, the file which implements the ioctls and
> registers the devices
> 
> Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/compress_offload/core.c |  632 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 632 insertions(+), 0 deletions(-)
>  create mode 100644 sound/compress_offload/core.c
> 
> diff --git a/sound/compress_offload/core.c b/sound/compress_offload/core.c
> new file mode 100644
> index 0000000..1797dba
> --- /dev/null
> +++ b/sound/compress_offload/core.c
> @@ -0,0 +1,632 @@

> +static int snd_compr_start(struct snd_compr_stream *stream)
> +{
> +	int retval;
> +
> +	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED)
> +		return -EPERM;
> +	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_START);
> +	if (!retval)
> +		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> +	return retval;
> +}
> +
> +static int snd_compr_stop(struct snd_compr_stream *stream)
> +{
> +	int retval;
> +
> +	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED)
> +		return -EPERM;
> +	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_STOP);
> +	if (!retval) {
> +		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +		wake_up(&stream->runtime->sleep);
> +	}
> +	return retval;
> +}
> +
> +static int snd_compr_drain(struct snd_compr_stream *stream)
> +{
> +	int retval;
> +
> +	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED ||
> +			stream->runtime->state != SNDRV_PCM_STATE_PAUSED)
> +		return -EPERM;
> +	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_DRAIN);
> +	if (!retval) {
> +		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +		wake_up(&stream->runtime->sleep);
> +	}
> +	return retval;
> +}

How is it expected to have stream->runtime->state ==
SNDRV_PCM_STATE_PREPARED?  This is not set anywhere in the core code.
Do we need to just add another ioctl for _PREPARE?

Thanks,
Dimitris
