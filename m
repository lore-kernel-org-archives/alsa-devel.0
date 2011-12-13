From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH v4 5/6] core: add support for
 compress_offload
Date: Tue, 13 Dec 2011 18:18:09 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B01@bgsmsx502.gar.corp.intel.com>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<1323766980-9350-6-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id E805D24609
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 13:48:15 +0100 (CET)
In-Reply-To: <1323766980-9350-6-git-send-email-vinod.koul@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


> +static int snd_compr_open(struct inode *inode, struct file *f) {
> +	struct snd_compr *compr;
> +	struct snd_compr_file *data;
> +	struct snd_compr_runtime *runtime;
> +	int ret, type;
> +	int maj = imajor(inode);
> +
> +	if (f->f_flags & O_WRONLY)
> +		type = SNDRV_DEVICE_TYPE_COMPR_PLAYBACK;
> +	else if (f->f_flags & O_RDONLY)
> +		type = SNDRV_DEVICE_TYPE_COMPR_CAPTURE;
> +	else {
> +		pr_err("invalid direction\n");
> +		return -EINVAL;
> +	}
If someone changes the device mode, this is screwed though there are two types 
of (PLAYBACK and CAPTURE) devices are registered? 
Would be better if there are two separate playback and  capture operations registered 
separately.

O_NONBLOCK is not tested here for non-blocking support.
> +
> +	if (maj == snd_major)
> +		compr = snd_lookup_minor_data(iminor(inode), type);
> +	else
> +		return -ENXIO;
> +
> +	if (compr == NULL) {
> +		pr_err("no device data!!!\n");
> +		return -ENODEV;
> +	}
> +
> +
> +static ssize_t snd_compr_write(struct file *f, const char __user *buf,
> +		size_t count, loff_t *offset)
> +{
> +	struct snd_compr_file *data = f->private_data;
> +	struct snd_compr_stream *stream;
> +	size_t avail;
> +	int retval;
> +
> +	BUG_ON(!data);
> +	stream = &data->stream;
> +	mutex_lock(&stream->device->lock);
> +	/* write is allowed when stream is running or has been steup */
> +	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
> +			stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
> {
Cant we call write again when the stream is in SNDRV_PCM_STATE_PREPARED state? 
This code allows only one write after the stream is in SNDRV_PCM_STATE_SETUP state.
What if someone wants to write multiple smaller fragments before the start?
> +		mutex_unlock(&stream->device->lock);
> +		return -EPERM;
> +	}
> +
> +	avail = snd_compr_get_avail(stream);
> +	pr_debug("avail returned %ld\n", (long)avail);
> +	/* calculate how much we can write to buffer */
> +	if (avail > count)
> +		avail = count;
> +
> +	if (stream->ops->copy)
> +		retval = stream->ops->copy(stream, buf, avail);
> +	else
> +		retval = snd_compr_write_data(stream, buf, avail);
> +	if (retval > 0)
> +		stream->runtime->bytes_written += retval;
> +
> +	/* while initiating the stream, write should be called before START
> +	 * call, so in setup move state */
> +	if (stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
> +		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
> +		pr_debug("stream prepared, Houston we are good to go\n");
> +	}
> +
> +	mutex_unlock(&stream->device->lock);
> +	return retval;
> +}
> +
> +static unsigned int snd_compr_poll(struct file *f, poll_table *wait) {
> +	struct snd_compr_file *data = f->private_data;
> +	struct snd_compr_stream *stream;
> +	size_t avail;
> +	int retval = 0;
> +
> +	BUG_ON(!data);
> +	stream = &data->stream;

Can you validate O_NONBLOCK before going into poll_wait?
I guess this has to return -EINVAL if the device is not opened with O_NONBLOCK.

> +
> +	mutex_lock(&stream->device->lock);
> +	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
> +		retval = -ENXIO;
> +		goto out;
> +	}
> +	poll_wait(f, &stream->runtime->sleep, wait);
> +
> +	avail = snd_compr_get_avail(stream);
> +	pr_debug("avail is %ld\n", (long)avail);
> +	/* check if we have at least one fragment to fill */
> +	switch (stream->runtime->state) {
> +	case SNDRV_PCM_STATE_RUNNING:
> +	case SNDRV_PCM_STATE_PREPARED:
> +	case SNDRV_PCM_STATE_PAUSED:
> +		if (avail >= stream->runtime->fragment_size) {
> +			if (stream->direction ==
> SNDRV_DEVICE_TYPE_COMPR_PLAYBACK)
> +				retval = POLLOUT | POLLWRNORM;
> +			else
> +				retval = POLLIN | POLLRDNORM;
> +			break;
> +		}
> +		/* Fall through */
> +	case SNDRV_PCM_STATE_DRAINING:
Where is this state set? I do not see this snd_cmpr_drain.
> +		break;
> +	default:
> +		if (stream->direction == SNDRV_DEVICE_TYPE_COMPR_PLAYBACK)
> +			retval = POLLOUT | POLLWRNORM | POLLERR;
> +		else
> +			retval = POLLIN | POLLRDNORM | POLLERR;
> +		break;
> +	}
> +out:
> +	mutex_unlock(&stream->device->lock);
> +	return retval;
> +}
> +


> +
> +/* revisit this with snd_pcm_preallocate_xxx */ static int
> +snd_compr_allocate_buffer(struct snd_compr_stream *stream,
> +		struct snd_compr_params *params)
> +{
> +	unsigned int buffer_size;
> +	void *buffer;
> +
> +	buffer_size = params->buffer.fragment_size * params->buffer.fragments;


If fragment_size is not a positive value, return -EINVAL.
What is the maximum number of fragments supported? 
Can we check the fragments to that limit?

> +	if (stream->ops->copy) {
> +		buffer = NULL;
> +		/* if copy is defined the driver will be required to copy
> +		 * the data from core
> +		 */
> +	} else {
> +		buffer = kmalloc(buffer_size, GFP_KERNEL);
> +		if (!buffer)
> +			return -ENOMEM;
> +	}
> +	stream->runtime->fragment_size = params->buffer.fragment_size;
> +	stream->runtime->fragments = params->buffer.fragments;
> +	stream->runtime->buffer = buffer;
> +	stream->runtime->buffer_size = buffer_size;
> +	return 0;
> +}


> +
> +static int
> +snd_compr_set_params(struct snd_compr_stream *stream, unsigned long
> +arg) {
> +	struct snd_compr_params *params;
> +	int retval;
> +
> +	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
> +		/*
> +		 * we should allow parameter change only when stream has been
> +		 * opened not in other cases
> +		 */
> +		params = kmalloc(sizeof(*params), GFP_KERNEL);
> +		if (!params)
> +			return -ENOMEM;
> +		if (copy_from_user(params, (void __user *)arg, sizeof(*params)))
> +			return -EFAULT;
> +		retval = snd_compr_allocate_buffer(stream, params);
> +		if (retval) {
> +			kfree(params);
> +			return -ENOMEM;
> +		}
<Sing>: Can you check stream->ops->set_params for NULL as it is done in the get_params function?
> +		retval = stream->ops->set_params(stream, params);
> +		if (retval)
> +			goto out;
> +		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +	} else
> +		return -EPERM;
> +out:
> +	kfree(params);
> +	return retval;
> +}
