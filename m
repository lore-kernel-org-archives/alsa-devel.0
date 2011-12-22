From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v4 5/6] core: add support for
 compress_offload
Date: Thu, 22 Dec 2011 13:49:50 +0530
Message-ID: <1324541990.1641.10133.camel@vkoul-udesk3>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<1323766980-9350-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hwr9pniqx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id AAC1F24453
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 09:19:57 +0100 (CET)
In-Reply-To: <s5hwr9pniqx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-12-22 at 08:55 +0100, Takashi Iwai wrote:
> At Tue, 13 Dec 2011 14:32:59 +0530,
> Vinod Koul wrote:
> > +static int snd_compr_free(struct inode *inode, struct file *f)
> > +{
> > +	struct snd_compr_file *data = f->private_data;
> > +	data->stream.ops->free(&data->stream);
> 
> Better to add a NULL check.
Not really. open, free and set_params callbacks are mandatory and there
is BUG_ON for them so these wont be checked here
> 
> > +static int
> > +snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
> > +{
> > +	struct snd_compr_avail ioctl_avail;
> > +	size_t avail;
> > +
> > +	avail = snd_compr_calc_avail(stream, &ioctl_avail);
> > +	ioctl_avail.avail = avail;
> > +
> > +	if (copy_to_user((unsigned long __user *)arg,
> > +				&ioctl_avail, sizeof(ioctl_avail)))
> 
> Use a correct cast.
> 
> > +static ssize_t snd_compr_write(struct file *f, const char __user *buf,
> > +		size_t count, loff_t *offset)
> > +{
> > +	struct snd_compr_file *data = f->private_data;
> > +	struct snd_compr_stream *stream;
> > +	size_t avail;
> > +	int retval;
> > +
> > +	BUG_ON(!data);
> 
> Avoid BUG_ON().  This is only for really critical bugs for which you
> must stop the whole machine.
> (BTW, snd_BUG_ON() is expanded to WARN_ON(), so it's not equivalent
>  with BUG_ON().)
Well write can be called only after open. And open should have set the
data. If data is null that means something really horrible happened (not
at all possible unless corruption) so BUG_ON :)
> 
> > +	stream = &data->stream;
> > +	mutex_lock(&stream->device->lock);
> > +	/* write is allowed when stream is running or has been steup */
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
> > +			stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
> > +		mutex_unlock(&stream->device->lock);
> > +		return -EPERM;
> 
> Hm, I'm not sure whether EPERM is best here.
> In PCM, we used to use EBADFD.
No issues
> 
> > +static unsigned int snd_compr_poll(struct file *f, poll_table *wait)
> > +{
> > +	struct snd_compr_file *data = f->private_data;
> > +	struct snd_compr_stream *stream;
> > +	size_t avail;
> > +	int retval = 0;
> > +
> > +	BUG_ON(!data);
> 
> Avoid BUG_ON().
Same point as in write. 
> 
> > +	stream = &data->stream;
> > +
> > +	mutex_lock(&stream->device->lock);
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
> > +		retval = -ENXIO;
> > +		goto out;
> > +	}
> 
> Whether to allow poll() at the state of PREPARE is an open question.
> You can think of an operation in a passive way via poll, such as,
> 
>    open();
>    prepare();
>    while (poll())
>       write();
> 
> So, poll() could be useful even at PREPARE.
Okay.


-- 
~Vinod
