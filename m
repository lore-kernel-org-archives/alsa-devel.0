From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Wed, 23 Nov 2011 16:02:53 +0000
Message-ID: <20111123160253.GD30049@opensource.wolfsonmicro.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 08439103A52
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2011 17:02:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 22, 2011 at 02:21:59PM +0530, Vinod Koul wrote:

Looks mostly good.

> +static int snd_compr_resume(struct snd_compr_stream *stream)
> +{
> +	int retval;
> +
> +	if (stream->runtime->state != SNDRV_PCM_STATE_PAUSED)
> +		return -EPERM;
> +	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_PAUSE_RELEASE);
> +	if (!retval)
> +		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> +	return retval;

Here we do the state transition if the trigger is successful but...

> +static int snd_compr_start(struct snd_compr_stream *stream)
> +{
> +	int retval;
> +
> +	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED)
> +		return -EPERM;
> +	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_START);
> +	stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> +	return retval;

...here we unconditionally set the new state.

> +static int snd_compress_add_device(struct snd_compr *device)
> +{
> +	int ret;
> +	struct snd_card *card;
> +
> +	ret = snd_card_create(SNDRV_DEFAULT_IDX1, device->name,
> +			THIS_MODULE, 0, &card);
> +	if (ret < 0)
> +		goto out;

It's a bit surprising that this is doing snd_card_create() - I'd expect
a compressed device to be added as a subdevice on a card being passed
in.  At least in the embedded case you'd normally get a card with a mix
of PCM and compressed streams in one unified card.

> +	mutex_init(&device->lock);
> +	/* todo integrate with asoc */

The core code shouldn't know anything about ASoC, ASoC should be able to
use the core API like any other card driver.
