From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Fri, 2 Dec 2011 21:54:02 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCA82D4B@bgsmsx502.gar.corp.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BA852450C
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 17:24:12 +0100 (CET)
In-Reply-To: <1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> +static int snd_compr_open(struct file *f,  struct snd_compr *compr, int
> +type) {
> +	struct snd_compr_file *data;
> +	struct snd_compr_runtime *runtime;
> +	int ret;
> +
> +	mutex_lock(&device_mutex);
> +
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	data->stream.ops = compr->ops;
NULL check for compr would help here.

> +	data->stream.direction = type;
> +	data->stream.private_data = compr->private_data;
> +	data->stream.device = compr;
> +	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
> +	if (!runtime) {
> +		ret = -ENOMEM;
> +		kfree(data);
> +		goto out;
> +	}
> +	runtime->state = SNDRV_PCM_STATE_OPEN;
> +	init_waitqueue_head(&runtime->sleep);
> +	data->stream.runtime = runtime;
> +	f->private_data = (void *)data;
> +	ret = compr->ops->open(&data->stream);
NULL check for ops would help here.

> +	if (ret) {
> +		kfree(runtime);
> +		kfree(data);
> +		goto out;
> +	}
> +out:
> +	mutex_unlock(&device_mutex);
> +	return ret;
> +}
> +

> +static int snd_compr_free(struct inode *inode, struct file *f) {
> +	struct snd_compr_file *data = f->private_data;
> +	mutex_lock(&device_mutex);
Can we have mutex for each file opened instead of having a single mutex for everything?
I think it is not required to sequence all the streams.

> +	data->stream.ops->free(&data->stream);
> +	kfree(data->stream.runtime->buffer);
> +	kfree(data->stream.runtime);
> +	kfree(data);
> +	mutex_unlock(&device_mutex);
> +	return 0;
> +}
> +
> +static void snd_compr_update_tstamp(struct snd_compr_stream *stream,
> +		struct snd_compr_tstamp *tstamp)
> +{
> +	stream->ops->pointer(stream, tstamp);
How to ensure that the caller always checks for NULL pointer? 

> +	pr_debug("dsp consumed till %d total %d bytes\n",
> +		tstamp->copied_bytes, tstamp->copied_total);
> +	stream->runtime->hw_pointer = tstamp->copied_bytes;
> +	stream->runtime->bytes_copied = tstamp->copied_total; }
> +
> +static size_t snd_compr_calc_avail(struct snd_compr_stream *stream,
> +		struct snd_compr_avail *avail)
> +{
> +	long avail_calc; /*this needs to be signed variable */
> +
> +	snd_compr_update_tstamp(stream, &avail->tstamp);
> +
> +	if (stream->runtime->bytes_written == 0 &&
> +			stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
> +		pr_debug("detected init and someone forgot to do a write\n");
> +		return stream->runtime->buffer_size;
> +	}
> +	pr_debug("app wrote %d, DSP consumed %d\n",
> +		stream->runtime->bytes_written, stream->runtime->bytes_copied);
> +	if (stream->runtime->bytes_written == stream->runtime->bytes_copied) {
> +		pr_debug("both pointers are same, returning full avail\n");
> +		return stream->runtime->buffer_size;
> +	}
> +
> +	avail_calc = stream->runtime->buffer_size -
> +		(stream->runtime->app_pointer - stream->runtime->hw_pointer);
> +	pr_debug("calc avail as %ld, app_ptr %d, hw+ptr %d\n", avail_calc,
> +		stream->runtime->app_pointer, stream->runtime->hw_pointer);
> +	if (avail_calc >= stream->runtime->buffer_size)
> +		avail_calc -= stream->runtime->buffer_size;
> +	pr_debug("ret avail as %ld\n", avail_calc);
> +	avail->avail = avail_calc;
> +	return avail_calc;
> +}
> +
> +static size_t snd_compr_get_avail(struct snd_compr_stream *stream) {
> +	struct snd_compr_avail avail;
> +
Can we update the timestamp before calculating the avail? This will allow partial   
Fragment to be written as well.
> +	return snd_compr_calc_avail(stream, &avail); }
> +
> +static int
> +snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long
> +arg) {
> +	struct snd_compr_avail ioctl_avail;
> +
Can we update the timestamp before calculating the avail? This will allow partial   
Fragment to be written as well.

> +	snd_compr_calc_avail(stream, &ioctl_avail);
> +
> +	if (copy_to_user((unsigned long __user *)arg,
> +				&ioctl_avail, sizeof(ioctl_avail)))
> +		return -EFAULT;
> +	return 0;
> +}
> +


> +static ssize_t snd_compr_write(struct file *f, const char __user *buf,
> +		size_t count, loff_t *offset)
> +{
> +
> +	/* while initiating the stream, write should be called before START
> +	 * call, so in setup move state */
> +	if (stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
> +		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
Can we implement kind of start threshold similar to PCM path here to initiate the playback?

> +		pr_debug("stream prepared, Houston we are good to go\n");
> +	}
> +
> +	mutex_unlock(&stream->device->lock);
> +	return retval;
> +}


> +static int snd_compr_resume(struct snd_compr_stream *stream) {
> +	int retval;
> +
> +	if (stream->runtime->state != SNDRV_PCM_STATE_PAUSED)
If the stream is running, I guess it can return 0.

> +		return -EPERM;
> +	retval = stream->ops->trigger(stream,
> SNDRV_PCM_TRIGGER_PAUSE_RELEASE);
> +	if (!retval)
> +		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> +	return retval;
> +}
> +
> +static int snd_compr_start(struct snd_compr_stream *stream) {
> +	int retval;
> +
> +	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED)
> +		return -EPERM;
> +	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_START);
> +	stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
Set to running state if start is successful.

> +	return retval;
> +}
> +
> +static int snd_compr_stop(struct snd_compr_stream *stream) {
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
> +static int snd_compr_drain(struct snd_compr_stream *stream) {
> +	int retval;
> +
> +	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED ||
> +			stream->runtime->state != SNDRV_PCM_STATE_PAUSED)
> +		return -EPERM;
What happens if the stream is in running state? This will return -EPERM. It should send DRAIN in this case.

> +	retval = stream->ops->trigger(stream, SND_COMPR_TRIGGER_DRAIN);
> +	if (!retval) {
> +		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> +		wake_up(&stream->runtime->sleep);
> +	}
> +	return retval;
> +}
> +
> +static long snd_compr_ioctl(struct file *f, unsigned int cmd, unsigned
> +long arg) {
> +	struct snd_compr_file *data = f->private_data;
> +	struct snd_compr_stream *stream;
> +	int retval = -ENOTTY;
> +
> +	BUG_ON(!data);
> +	stream = &data->stream;
> +	BUG_ON(!stream);
> +	mutex_lock(&stream->device->lock);
Simple structure with ioctl functions will reduce lots of code.
It is not anyway doing any specific processing for each ioctl.
> +	switch (_IOC_NR(cmd)) {
> +	case _IOC_NR(SNDRV_COMPRESS_IOCTL_VERSION):
> +		put_user(SNDRV_COMPRESS_VERSION,
> +				(int __user *)arg) ? -EFAULT : 0;
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_GET_CAPS):
> +		retval = snd_compr_get_caps(stream, arg);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_GET_CODEC_CAPS):
> +		retval = snd_compr_get_codec_caps(stream, arg);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_SET_PARAMS):
> +		retval = snd_compr_set_params(stream, arg);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_GET_PARAMS):
> +		retval = snd_compr_get_params(stream, arg);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_TSTAMP):
> +		retval = snd_compr_tstamp(stream, arg);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_AVAIL):
> +		retval = snd_compr_ioctl_avail(stream, arg);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_PAUSE):
> +		retval = snd_compr_pause(stream);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_RESUME):
> +		retval = snd_compr_resume(stream);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_START):
> +		retval = snd_compr_start(stream);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_STOP):
> +		retval = snd_compr_stop(stream);
> +		break;
> +	case _IOC_NR(SNDRV_COMPRESS_DRAIN):
> +		cmd = SND_COMPR_TRIGGER_DRAIN;
> +		retval = snd_compr_drain(stream);
> +		break;
> +	}
> +	mutex_unlock(&stream->device->lock);
> +	return retval;
> +}
> +
> +static const struct file_operations snd_compr_file_ops[2] = {
> +	{
> +		.owner =	THIS_MODULE,
> +		.open =		snd_compr_pb_open,
> +		.release =	snd_compr_free,
> +		.write =	snd_compr_write,
> +		.unlocked_ioctl = snd_compr_ioctl,
> +		.mmap =		snd_compr_mmap,
Suggest you to populate it when implemented.
> +		.poll =		snd_compr_pb_poll,
> +	},
> +	{
> +		.owner =	THIS_MODULE,
> +		.open =		snd_compr_cap_open,
> +		.release =	snd_compr_free,
> +		.read =		snd_compr_read,
> +		.unlocked_ioctl = snd_compr_ioctl,
> +		.mmap =		snd_compr_mmap,
> +		.poll =		snd_compr_cap_poll,
> +	}
> +};
> +
> +static int snd_compress_dev_register(struct snd_device *device) {
> +	int ret;
> +	char str[16];
> +	struct snd_compr *compr;
> +	int devtype, cidx;
> +
> +	if (snd_BUG_ON(!device || !device->device_data))
> +		return -ENXIO;
> +	compr = device->device_data;
> +
> +	for (cidx = 0; cidx < 2; cidx++) {
> +		switch (cidx) {
> +		case 0:
> +			if (!compr->pb)
Can we have the device type or direction in this variable. Suggest you not to use
two variables (cap and pb) here.
> +				continue;
> +			sprintf(str, "comprC%iD%ip", compr->card->number,
> +				compr->device);
> +			pr_debug("reg %s for device %s\n", str, compr->name);
> +			devtype = SNDRV_DEVICE_TYPE_COMPR_PLAYBACK;
> +			break;
> +
