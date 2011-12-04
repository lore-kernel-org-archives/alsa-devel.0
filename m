From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Sun, 04 Dec 2011 10:01:15 +0530
Message-ID: <1322973076.30390.14.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D4B@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 1352C24562
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 05:33:14 +0100 (CET)
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507CCA82D4B@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-12-02 at 21:54 +0530, Nallasellan, Singaravelan wrote:
> > +static int snd_compr_open(struct file *f,  struct snd_compr *compr,
> int
> > +type) {
> > +	struct snd_compr_file *data;
> > +	struct snd_compr_runtime *runtime;
> > +	int ret;
> > +
> > +	mutex_lock(&device_mutex);
> > +
> > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data) {
> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	data->stream.ops = compr->ops;
> NULL check for compr would help here.
That would be double check, hence bogus
see the pb_open

> > +	data->stream.direction = type;
> > +	data->stream.private_data = compr->private_data;
> > +	data->stream.device = compr;
> > +	runtime = kzalloc(sizeof(*runtime), GFP_KERNEL);
> > +	if (!runtime) {
> > +		ret = -ENOMEM;
> > +		kfree(data);
> > +		goto out;
> > +	}
> > +	runtime->state = SNDRV_PCM_STATE_OPEN;
> > +	init_waitqueue_head(&runtime->sleep);
> > +	data->stream.runtime = runtime;
> > +	f->private_data = (void *)data;
> > +	ret = compr->ops->open(&data->stream);
> NULL check for ops would help here.
if ops is null you shouldnt be even here, or your driver is buggy so fix
that
> 
> > +	if (ret) {
> > +		kfree(runtime);
> > +		kfree(data);
> > +		goto out;
> > +	}
> > +out:
> > +	mutex_unlock(&device_mutex);
> > +	return ret;
> > +}
> > +
> 
> > +static int snd_compr_free(struct inode *inode, struct file *f) {
> > +	struct snd_compr_file *data = f->private_data;
> > +	mutex_lock(&device_mutex);
> Can we have mutex for each file opened instead of having a single
> mutex for everything?
> I think it is not required to sequence all the streams.
This is changed already per Takashi's comments.
Would help if you read the archives

> 
> > +	data->stream.ops->free(&data->stream);
> > +	kfree(data->stream.runtime->buffer);
> > +	kfree(data->stream.runtime);
> > +	kfree(data);
> > +	mutex_unlock(&device_mutex);
> > +	return 0;
> > +}
> > +
> > +static void snd_compr_update_tstamp(struct snd_compr_stream
> *stream,
> > +		struct snd_compr_tstamp *tstamp)
> > +{
> > +	stream->ops->pointer(stream, tstamp);
> How to ensure that the caller always checks for NULL pointer? 
Not required, ops will be valid and pointer is mandatory callback


> > +
> > +static size_t snd_compr_get_avail(struct snd_compr_stream *stream)
> {
> > +	struct snd_compr_avail avail;
> > +
> Can we update the timestamp before calculating the avail? This will
> allow partial   
> Fragment to be written as well.
yes that is the implementation

> > +	return snd_compr_calc_avail(stream, &avail); }
> > +
> > +static int
> > +snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned
> long
> > +arg) {
> > +	struct snd_compr_avail ioctl_avail;
> > +
> Can we update the timestamp before calculating the avail? This will
> allow partial   
> Fragment to be written as well.
ditto

> 
> > +static ssize_t snd_compr_write(struct file *f, const char __user
> *buf,
> > +		size_t count, loff_t *offset)
> > +{
> > +
> > +	/* while initiating the stream, write should be called before
> START
> > +	 * call, so in setup move state */
> > +	if (stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
> > +		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
> Can we implement kind of start threshold similar to PCM path here to
> initiate the playback?
You already know how much is copied into buffer
> 
> > +		pr_debug("stream prepared, Houston we are good to go\n");
> > +	}
> > +
> > +	mutex_unlock(&stream->device->lock);
> > +	return retval;
> > +}
> 
> 
> > +static int snd_compr_resume(struct snd_compr_stream *stream) {
> > +	int retval;
> > +
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_PAUSED)
> If the stream is running, I guess it can return 0.
NO. The fact that someone is trying to resume running stream makes me
believe something else is badly written/behaving. This should be told
upfront rather than hidden
> 
> > +		return -EPERM;
> > +	retval = stream->ops->trigger(stream,
> > SNDRV_PCM_TRIGGER_PAUSE_RELEASE);
> > +	if (!retval)
> > +		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> > +	return retval;
> > +}
> > +
> > +static int snd_compr_start(struct snd_compr_stream *stream) {
> > +	int retval;
> > +
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED)
> > +		return -EPERM;
> > +	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_START);
> > +	stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> Set to running state if start is successful.
read the archives please

> > +
> > +static int snd_compr_drain(struct snd_compr_stream *stream) {
> > +	int retval;
> > +
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED ||
> > +			stream->runtime->state != SNDRV_PCM_STATE_PAUSED)
> > +		return -EPERM;
> What happens if the stream is in running state? This will return
> -EPERM. It should send DRAIN in this case.
Yes, fixed now

> > +static long snd_compr_ioctl(struct file *f, unsigned int cmd,
> unsigned
> > +long arg) {
> > +	struct snd_compr_file *data = f->private_data;
> > +	struct snd_compr_stream *stream;
> > +	int retval = -ENOTTY;
> > +
> > +	BUG_ON(!data);
> > +	stream = &data->stream;
> > +	BUG_ON(!stream);
> > +	mutex_lock(&stream->device->lock);
> Simple structure with ioctl functions will reduce lots of code.
> It is not anyway doing any specific processing for each ioctl.
Code readability improves

> > +static int snd_compress_dev_register(struct snd_device *device) {
> > +	int ret;
> > +	char str[16];
> > +	struct snd_compr *compr;
> > +	int devtype, cidx;
> > +
> > +	if (snd_BUG_ON(!device || !device->device_data))
> > +		return -ENXIO;
> > +	compr = device->device_data;
> > +
> > +	for (cidx = 0; cidx < 2; cidx++) {
> > +		switch (cidx) {
> > +		case 0:
> > +			if (!compr->pb)
> Can we have the device type or direction in this variable. Suggest you
> not to use
> two variables (cap and pb) here.
The above was correct in that context. We wanted to know which devices
to register playback or capture or both
Nevertheless, this is changed now.


-- 
~Vinod
