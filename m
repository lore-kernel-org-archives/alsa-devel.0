From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v4 5/6] core: add support for
 compress_offload
Date: Tue, 13 Dec 2011 19:42:20 +0530
Message-ID: <1323785540.1641.73.camel@vkoul-udesk3>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<1323766980-9350-6-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCB50B01@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 02EB1103B83
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 15:13:21 +0100 (CET)
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B01@bgsmsx502.gar.corp.intel.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-12-13 at 18:18 +0530, Nallasellan, Singaravelan wrote:

Please wrap your emails within 80 chars, you have been repeatedly asked
to do so on this on list. I don't understand how hard it is to follow
basic list etiquettes. Its difficult to read screwed up formatting

> > +static int snd_compr_open(struct inode *inode, struct file *f) {
> > +	struct snd_compr *compr;
> > +	struct snd_compr_file *data;
> > +	struct snd_compr_runtime *runtime;
> > +	int ret, type;
> > +	int maj = imajor(inode);
> > +
> > +	if (f->f_flags & O_WRONLY)
> > +		type = SNDRV_DEVICE_TYPE_COMPR_PLAYBACK;
> > +	else if (f->f_flags & O_RDONLY)
> > +		type = SNDRV_DEVICE_TYPE_COMPR_CAPTURE;
> > +	else {
> > +		pr_err("invalid direction\n");
> > +		return -EINVAL;
> > +	}
> If someone changes the device mode, this is screwed though there are
> two types 
> of (PLAYBACK and CAPTURE) devices are registered? 
> Would be better if there are two separate playback and  capture
> operations registered 
> separately.
Again, please read the related discussion on the list.

Compressed devices will not have direction associated with them . They
can be opened in any mode depending on the mode the DSP supports.
So /dev/snd/comprC0D0 can be either playback or capture device.
So a device can be ONLY opened with O_WRONLY or O_RDONLY.


> O_NONBLOCK is not tested here for non-blocking support.
Why should it be?
1) Any blocking and non blocking should be handled in user space
2) Nevertheless, that is not supported, HINT: read the documentation

> > +
> > +static ssize_t snd_compr_write(struct file *f, const char __user *buf,
> > +		size_t count, loff_t *offset)
> > +{
> > +	struct snd_compr_file *data = f->private_data;
> > +	struct snd_compr_stream *stream;
> > +	size_t avail;
> > +	int retval;
> > +
> > +	BUG_ON(!data);
> > +	stream = &data->stream;
> > +	mutex_lock(&stream->device->lock);
> > +	/* write is allowed when stream is running or has been steup */
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
> > +			stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
> > {
> Cant we call write again when the stream is in
> SNDRV_PCM_STATE_PREPARED state? 
> This code allows only one write after the stream is in
> SNDRV_PCM_STATE_SETUP state.
> What if someone wants to write multiple smaller fragments before the
> start?
Yes currently write is allowed only once and we *normally* expect a
START call. I am not sure why someone would need to call "smaller"
writes multiple times. Remember this is compressed offload where we
ideally want larger chunks of data otherwise there is no point in using
this.
> > +static unsigned int snd_compr_poll(struct file *f, poll_table *wait) {
> > +	struct snd_compr_file *data = f->private_data;
> > +	struct snd_compr_stream *stream;
> > +	size_t avail;
> > +	int retval = 0;
> > +
> > +	BUG_ON(!data);
> > +	stream = &data->stream;
> 
> Can you validate O_NONBLOCK before going into poll_wait?
> I guess this has to return -EINVAL if the device is not opened with
> O_NONBLOCK.
See above

> > +	case SNDRV_PCM_STATE_DRAINING:
> Where is this state set? I do not see this snd_cmpr_drain.
Yes this should be set in snd_compr_drain. Fixed now.

> > +	void *buffer;
> > +
> > +	buffer_size = params->buffer.fragment_size * params->buffer.fragments;
> 
> 
> If fragment_size is not a positive value, return -EINVAL.
It can only be +ve

> What is the maximum number of fragments supported? 
Whatever dsp supports

> Can we check the fragments to that limit?
Yes, can be checked here as well but I prefer to do these checks in
userspace library


> > +
> > +static int
> > +snd_compr_set_params(struct snd_compr_stream *stream, unsigned long
> > +arg) {
Pls fix your mailer, it screwing up original formatting.

> > +	struct snd_compr_params *params;
> > +	int retval;
> > +
> > +	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
> > +		/*
> > +		 * we should allow parameter change only when stream has been
> > +		 * opened not in other cases
> > +		 */
> > +		params = kmalloc(sizeof(*params), GFP_KERNEL);
> > +		if (!params)
> > +			return -ENOMEM;
> > +		if (copy_from_user(params, (void __user *)arg, sizeof(*params)))
> > +			return -EFAULT;
> > +		retval = snd_compr_allocate_buffer(stream, params);
> > +		if (retval) {
> > +			kfree(params);
> > +			return -ENOMEM;
> > +		}
> <Sing>: Can you check stream->ops->set_params for NULL as it is done
> in the get_params function?
No set_params is mandatory function to be implemented

> > +		retval = stream->ops->set_params(stream, params);
> > +		if (retval)
> > +			goto out;
> > +		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> > +	} else
> > +		return -EPERM;
> > +out:
> > +	kfree(params);
> > +	return retval;
> > +}


-- 
~Vinod
