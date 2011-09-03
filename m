From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC 4/5] compress: add the core file
Date: Sat, 03 Sep 2011 08:36:25 +0530
Message-ID: <1315019185.26251.56.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-5-git-send-email-vinod.koul@linux.intel.com>
	<20110902143615.GC10175@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 3291D244FD
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Sep 2011 05:08:12 +0200 (CEST)
In-Reply-To: <20110902143615.GC10175@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-09-02 at 15:36 +0100, Mark Brown wrote:
> On Fri, Sep 02, 2011 at 11:36:24AM +0530, Vinod Koul wrote:
> 
> > + * - Integrate with ASoC:
> > + *	Opening compressed path should also start the codec dai
> > + *   TBD how the cpu dai will be viewed and started.
> > + *	ASoC should always be optional part
> > + *	(we should be able to use this framework in non asoc systems
> 
> Just write an ALSA core API, ASoC is an ALSA driver so it can just use
> the same interfaces as everything else gets.
Actually no. That way devices would get regsitered as /dev/snd_pcmCxDxy
which wont be corect.
Was thinking of making these appear as something
like /dev/snd/comprCxDxy.
ANy pointer for above change would be welcome
> 
> > + * - Multiple node representation
> > + *	driver should be able to register multiple nodes
> > + * - Version numbering for API
> 
> I'd suggest doing this per ioctl rather than per API.
OK
> 
> > +	ret = misc->compr->ops->open(&data->stream);
> > +	if (ret) {
> > +		kfree(runtime);
> > +		kfree(data);
> > +		goto out;
> > +	}
> > +	runtime->state = SNDRV_PCM_STATE_OPEN;
> > +	init_waitqueue_head(&runtime->sleep);
> > +	data->stream.runtime = runtime;
> > +	f->private_data = (void *)data;
> 
> Should we hoist these before we call open(), especially the init of
> runtime?  It seems likely to be more robusy.
Since open is just supposed to let the device know that stream is being
created with a particular direction. Event if I move this up, doesn't
serve a purpose as driver should touch these a t open.
But I agree this helps to make more robust 
> 
> > +static int snd_compr_write(struct file *f, const char __user *buf,
> > +		size_t count, loff_t *offset)
> > +{
> > +	struct snd_ioctl_data *data = f->private_data;
> > +	struct snd_compr_stream *stream;
> > +	size_t avail;
> > +	int retval;
> > +
> > +	BUG_ON(!data);
> > +	stream = &data->stream;
> > +	/* write is allowed when stream is running or has been steup */
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
> > +			stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
> > +		return -EPERM;
> > +	mutex_lock(&stream->device->lock);
> 
> Shouldn't we lock something before we check the stream state?
Yesss...

> 
> > +static int snd_compr_read(struct file *f, char __user *buf,
> > +		size_t count, loff_t *offset)
> > +{
> > +	return -ENXIO;
> > +}
> > +
> > +static int snd_compr_mmap(struct file *f, struct vm_area_struct *vma)
> > +{
> > +	return -ENXIO;
> > +}
> 
> Do we need to implement noops like these?
Well I kept them placeholder to remind me what else needs
implementation, I think I will keep them for a while as we need to
implement mmap and recording support as well. Recording is actually
trivial after playback.
> 
> > +unsigned int snd_compr_poll(struct file *f, poll_table *wait)
> > +{
> > +	struct snd_ioctl_data *data = f->private_data;
> > +	struct snd_compr_stream *stream;
> > +
> > +	BUG_ON(!data);
> > +	stream = &data->stream;
> > +
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
> > +		return -ENXIO;
> > +	poll_wait(f, &stream->runtime->sleep, wait);
> > +
> > +	/* this would change after read is implemented, we would need to
> > +	 * check for direction here */
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
> > +		return POLLOUT | POLLWRNORM;
> > +
> > +	return 0;
> > +}
> > +
> > +void snd_compr_period_elapsed(struct snd_compr_stream *stream)
> > +{
> > +	size_t avail;
> > +
> > +	avail = snd_compr_get_avail(stream);
> > +	if (avail >= stream->runtime->fragment_size)
> > +		wake_up(&stream->runtime->sleep);
> > +}
> > +EXPORT_SYMBOL_GPL(snd_compr_period_elapsed);
> 
> I can see why you picked period_elapsed() (for consistency) but it feels
> wrong to have a time based name for something which is going to end up
> being data size based.
Yes the notion of period here cannot be time it is in bytes.

> 
> > +static int snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
> > +{
> > +	struct snd_compr_params *params;
> > +	int retval;
> > +
> > +	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN) {
> 
> It would be more legible to reverse the check I think?  Also shouldn't
> there be more locking in this (and all the other stuff looking at
> states)?
Ok, Thanks for review


-- 
~Vinod
