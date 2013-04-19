From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 4/7] ALSA: compress_core: Add support for
	capture	streams
Date: Fri, 19 Apr 2013 15:42:16 +0100
Message-ID: <20130419144216.GA9324@opensource.wolfsonmicro.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
 <61f3f3c2-726d-4fde-af44-608a154ea183@opensource.wolfsonmicro.com>
 <20130419132552.GA6081@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0A8352615B9
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 16:42:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130419132552.GA6081@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> >  static ssize_t snd_compr_read(struct file *f, char __user *buf,
> >  		size_t count, loff_t *offset)
> >  {
> > -	return -ENXIO;
> > +	struct snd_compr_file *data = f->private_data;
> > +	struct snd_compr_stream *stream;
> > +	size_t avail;
> > +	int retval;
> > +
> > +	if (snd_BUG_ON(!data))
> > +		return -EFAULT;
> > +
> > +	stream = &data->stream;
> > +	mutex_lock(&stream->device->lock);
> > +
> > +	/* read is allowed when stream is running */
> > +	if (stream->runtime->state != SNDRV_PCM_STATE_RUNNING) {
> > +		retval = -EBADFD;
> > +		goto out;
> minor one but shouldnt we allow read even when we have stoped or paused the
> stream. Stop is important as you might want to get all buffers after you have
> stopped.

Yes, looks like a bug to me. Not sure that it's a blocker - new feature so
nobody is going to be using this immediately.
As you can't capture sounds from the future(!) the DSP could only hold data up
to the point you stopped/paused. But the DSP could have some audio packets queued
that it hasn't sent to host yet and you still need to read them.
You'd probably not have much queued anyway as it would be disturbing for user
if they monitor recording through their device headphones and it has significant
latency from the real world sounds?
