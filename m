From: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Subject: Re: [PATCH v4 5/6] core: add support for
 compress_offload
Date: Tue, 13 Dec 2011 21:32:43 +0530
Message-ID: <3CA6C6D9F70D314CA34352990B57DA1507CCB50B87@bgsmsx502.gar.corp.intel.com>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<1323766980-9350-6-git-send-email-vinod.koul@linux.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507CCB50B01@bgsmsx502.gar.corp.intel.com>
	<1323785540.1641.73.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id BC65B103B66
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2011 17:02:52 +0100 (CET)
In-Reply-To: <1323785540.1641.73.camel@vkoul-udesk3>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@ti.com" <lrg@ti.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


> 
> Please wrap your emails within 80 chars, you have been repeatedly asked to do so
> on this on list. I don't understand how hard it is to follow basic list etiquettes. Its
> difficult to read screwed up formatting
> 
Yes sir. Apologize for the mistake.

> > If someone changes the device mode, this is screwed though there are
> > two types of (PLAYBACK and CAPTURE) devices are registered?
> > Would be better if there are two separate playback and  capture
> > operations registered separately.
> Again, please read the related discussion on the list.
> 
> Compressed devices will not have direction associated with them . They can be
> opened in any mode depending on the mode the DSP supports.
> So /dev/snd/comprC0D0 can be either playback or capture device.
> So a device can be ONLY opened with O_WRONLY or O_RDONLY.
> 
Nice, Does it look like a hack hack hack...
> 
> > O_NONBLOCK is not tested here for non-blocking support.
> Why should it be?
> 1) Any blocking and non blocking should be handled in user space
> 2) Nevertheless, that is not supported, HINT: read the documentation
> 
This is not as per the write system call definition as I understand.  Look like we redefine the
system call here. Support it in the standard way.
> > > +	if (stream->runtime->state != SNDRV_PCM_STATE_SETUP &&
> > > +			stream->runtime->state != SNDRV_PCM_STATE_RUNNING)
> > > {
> > Cant we call write again when the stream is in
> > SNDRV_PCM_STATE_PREPARED state?
> > This code allows only one write after the stream is in
> > SNDRV_PCM_STATE_SETUP state.
> > What if someone wants to write multiple smaller fragments before the
> > start?
> Yes currently write is allowed only once and we *normally* expect a START call. I am
> not sure why someone would need to call "smaller"
> writes multiple times. Remember this is compressed offload where we ideally want
> larger chunks of data otherwise there is no point in using this.
The code allows this to happen.  Is there any minimum size documented anywhere? 

> > > +static unsigned int snd_compr_poll(struct file *f, poll_table *wait) {
> > > +	struct snd_compr_file *data = f->private_data;
> > > +	struct snd_compr_stream *stream;
> > > +	size_t avail;
> > > +	int retval = 0;
> > > +
> > > +	BUG_ON(!data);
> > > +	stream = &data->stream;
> >
> > Can you validate O_NONBLOCK before going into poll_wait?
> > I guess this has to return -EINVAL if the device is not opened with
> > O_NONBLOCK.
> See above
Not a write implementation. 
> 
> 
> > What is the maximum number of fragments supported?
> Whatever dsp supports
IMHO, compress-core needs to query it from each driver and allocate memory 
only if the supported fragments is greater than requested fragments. 
> 
> > Can we check the fragments to that limit?
> Yes, can be checked here as well but I prefer to do these checks in userspace library
Think the driver needs to check and return error if it is not within the maximum
supported by the driver.
> 
> 
> > <Sing>: Can you check stream->ops->set_params for NULL as it is done
> > in the get_params function?
> No set_params is mandatory function to be implemented
Ok. It is my miss. 
> 
> --
> ~Vinod
