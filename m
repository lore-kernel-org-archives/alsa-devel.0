From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 5/6] compress: add the core file
Date: Thu, 24 Nov 2011 09:15:54 +0530
Message-ID: <1322106354.1516.951.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1321951920-4363-6-git-send-email-vinod.koul@linux.intel.com>
	<s5hbos2g4af.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 43BD1103D59
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2011 04:49:21 +0100 (CET)
In-Reply-To: <s5hbos2g4af.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-11-23 at 18:03 +0100, Takashi Iwai wrote:
> At Tue, 22 Nov 2011 14:21:59 +0530,
> Vinod Koul wrote:
> > 
> > This patch adds core.c, the file which implements the ioctls and
> > registers the devices
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> A general note: it's not necessarily to split playback and capture
> devices.  For example, rawmidi has a single device for full-duplex.
> In the case of PCM, we had to split them because of mmap.  The mmap
> for the capture was supposed not to be read-only, some apps may want
> to add mark on the buffer.  But, if this isn't the case for
> compression devices, you can have a single device serving for both
> playback and capture.  The direction can be checked by the open flag.
Yes we can have them common. I went with usualy convention of having
devices as pcmCxDxp translated to comprCxDxp.

If you don't mind we can keep it as is for now, and once we have
capture, mmap and other support built and tested we can merge these?

> 
> > +#define FORMAT(fmt) "%s: %d: " fmt, __func__, __LINE__
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " FORMAT(fmt)
> 
> Is this referred anywhere?
This is trick I picked up :)
pr_err/debug is define as pr_fmt. These just add the module name,
function and line number to what you are printing

> > +
> > +static int snd_compr_open(struct file *f,  struct snd_compr *compr, int type)
> > +{
> > +	struct snd_compr_file *data;
> > +	struct snd_compr_runtime *runtime;
> > +	int ret;
> > +
> > +	mutex_lock(&device_mutex);
> 
> Do you need a global lock for opening a device, too?  Just to be sure,
> since I see no obvious need.  (Anyway you don't need to have a lock at
> this early place before a bunch of kmallocs.  The lock should be done
> as small as possible.)
Thinking on this lock should be only for device open call. That way we
prevent race of two opens.
> 
> > +static int snd_compr_free(struct inode *inode, struct file *f)
> > +{
> > +	struct snd_compr_file *data = f->private_data;
> > +	mutex_lock(&device_mutex);
> > +	data->stream.ops->free(&data->stream);
> > +	kfree(data->stream.runtime->buffer);
> > +	kfree(data->stream.runtime);
> > +	kfree(data);
> > +	mutex_unlock(&device_mutex);
> 
> Ditto.  Do you need a global lock?
nope
> 
> > +static int
> > +snd_compr_ioctl_avail(struct snd_compr_stream *stream, unsigned long arg)
> > +{
> > +	struct snd_compr_avail ioctl_avail;
> > +
> > +	snd_compr_calc_avail(stream, &ioctl_avail);
> > +	if (copy_to_user((unsigned long __user *)arg,
> > +				&ioctl_avail, sizeof(ioctl_avail)))
> 
> snd_compr_calc_avail() doesn't initialize the pointer, so this may
> leak some kernel space.
Not sure if I understood this
snd_compr_calc_avail() will go and get the tstamp updated from driver by
passing the tstamp structure inside this, calculate avail and update
that value.

> 
> 
> > +void snd_compr_fragment_elapsed(struct snd_compr_stream *stream)
> > +{
> > +	pr_debug("fragment elapsed called\n");
> > +	if (stream->direction !=  SNDRV_DEVICE_TYPE_COMPR_PLAYBACK)
> > +		return;
> > +	wake_up(&stream->runtime->sleep);
> > +}
> > +EXPORT_SYMBOL_GPL(snd_compr_fragment_elapsed);
> > +
> > +void snd_compr_frame_elapsed(struct snd_compr_stream *stream)
> > +{
> > +	if (stream->direction != SNDRV_DEVICE_TYPE_COMPR_CAPTURE)
> > +		return;
> > +	wake_up(&stream->runtime->sleep);
> > +}
> > +EXPORT_SYMBOL_GPL(snd_compr_frame_elapsed);
> 
> These are better to be inlined...
> (And fragment and frame for different directions?  Hm, not so
> intuitive :)
Well we hve different notions for playback and capture.
In playback, the application can set any random fragment size and dsp
will send a notification by calling snd_compr_fragment_elapsed.
But in case of capture, we would want to get data in frames, but
application may not have a clue on what is the frame size. So once it
has encoded one frame and copied to buffer, it should update its time
stamp and call snd_compr_frame_elapsed. And application can know where
frame boundary is and read data per frame basis.

> 
> 
> > +	mutex_lock(&stream->device->lock);
> > +	switch (_IOC_NR(cmd)) {
> > +	case _IOC_NR(SNDRV_COMPRESS_IOCTL_VERSION):
> > +		put_user(SNDRV_COMPRESS_VERSION,
> > +				(int __user *)arg) ? -EFAULT : 0;
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_GET_CAPS):
> > +		retval = snd_compr_get_caps(stream, arg);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_GET_CODEC_CAPS):
> > +		retval = snd_compr_get_codec_caps(stream, arg);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_SET_PARAMS):
> > +		retval = snd_compr_set_params(stream, arg);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_GET_PARAMS):
> > +		retval = snd_compr_get_params(stream, arg);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_TSTAMP):
> > +		retval = snd_compr_tstamp(stream, arg);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_AVAIL):
> > +		retval = snd_compr_ioctl_avail(stream, arg);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_PAUSE):
> > +		retval = snd_compr_pause(stream);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_RESUME):
> > +		retval = snd_compr_resume(stream);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_START):
> > +		retval = snd_compr_start(stream);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_STOP):
> > +		retval = snd_compr_stop(stream);
> > +		break;
> > +	case _IOC_NR(SNDRV_COMPRESS_DRAIN):
> > +		cmd = SND_COMPR_TRIGGER_DRAIN;
> 
> What's this?
So we have two notions of stopping the stream.
1) STOP: where the dsp is expected to discard any pending data and stop
the decoder.
2) DRAIN: where the dsp is expected to keep decoding and rendering till
last frame available, typcially required for end of file scenarios

Thanks for your review
-- 
~Vinod
