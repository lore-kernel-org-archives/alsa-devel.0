From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Sun, 4 Dec 2011 13:44:14 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCAD7954@bgsmsx502.gar.corp.intel.com>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCA82D4B@bgsmsx502.gar.corp.intel.com>
	<1322973076.30390.14.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 842BB245E8
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 09:14:24 +0100 (CET)
In-Reply-To: <1322973076.30390.14.camel@vkoul-udesk3>
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
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> > > +	stream->ops->pointer(stream, tstamp);
> > How to ensure that the caller always checks for NULL pointer?
> Not required, ops will be valid and pointer is mandatory callback

So any buggy driver can cause oops in the compressed core?

> >
> > > +static ssize_t snd_compr_write(struct file *f, const char __user
> > *buf,
> > > +		size_t count, loff_t *offset)
> > > +{
> > > +
> > > +	/* while initiating the stream, write should be called before
> > START
> > > +	 * call, so in setup move state */
> > > +	if (stream->runtime->state == SNDRV_PCM_STATE_SETUP) {
> > > +		stream->runtime->state = SNDRV_PCM_STATE_PREPARED;
> > Can we implement kind of start threshold similar to PCM path here to
> > initiate the playback?
> You already know how much is copied into buffer
You expect the user space to explicitly invoke START. Is it right?
If threshold is implemented, the user space does not require to track the
bytes_written/read.
> >
> > > +		pr_debug("stream prepared, Houston we are good to go\n");
> > > +	}
> > > +
> > > +	mutex_unlock(&stream->device->lock);
> > > +	return retval;
> > > +}
> >
> > > +static int snd_compr_start(struct snd_compr_stream *stream) {
> > > +	int retval;
> > > +
> > > +	if (stream->runtime->state != SNDRV_PCM_STATE_PREPARED)
> > > +		return -EPERM;
> > > +	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_START);
> > > +	stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> > Set to running state if start is successful.
> read the archives please
Sure, it will not harm if you respond to this. 
> 
> > > +static long snd_compr_ioctl(struct file *f, unsigned int cmd,
> > unsigned
> > > +long arg) {
> > > +	struct snd_compr_file *data = f->private_data;
> > > +	struct snd_compr_stream *stream;
> > > +	int retval = -ENOTTY;
> > > +
> > > +	BUG_ON(!data);
> > > +	stream = &data->stream;
> > > +	BUG_ON(!stream);
> > > +	mutex_lock(&stream->device->lock);
> > Simple structure with ioctl functions will reduce lots of code.
> > It is not anyway doing any specific processing for each ioctl.
> Code readability improves
Not sure other way does not help readability. Try to make it simple.
