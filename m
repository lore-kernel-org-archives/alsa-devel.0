From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC 4/5] compress: add the core file
Date: Fri, 09 Sep 2011 04:48:14 +0530
Message-ID: <1315523894.26251.434.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-5-git-send-email-vinod.koul@linux.intel.com>
	<20110908103826.GA3992@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BF09924E48
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Sep 2011 01:20:50 +0200 (CEST)
In-Reply-To: <20110908103826.GA3992@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-09-08 at 11:38 +0100, Dimitris Papastamos wrote:
> On Fri, Sep 02, 2011 at 11:36:24AM +0530, Vinod Koul wrote:
> > This patch ads core.c, the file which implements the ioctls and
> > registers the devices
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@linux.intel.com>
> > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > ---
> >  sound/compress_offload/core.c |  632 +++++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 632 insertions(+), 0 deletions(-)
> >  create mode 100644 sound/compress_offload/core.c
> > 
> > diff --git a/sound/compress_offload/core.c b/sound/compress_offload/core.c
> > new file mode 100644
> > index 0000000..1797dba
> > --- /dev/null
> > +++ b/sound/compress_offload/core.c
> > @@ -0,0 +1,632 @@
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
> 
> Do we need to grab any locks here?  I'm also confused about checking for
> != SNDRV_PCM_STATE_RUNNING and only then returning POLLOUT | POLLWRNORM.
> Shouldn't the normal cycle be write->start->poll->write->poll->...?  At
> the moment, the state won't change and for this cycle to be effective we
> have to call stop/drain in between.  Am I missing something?
My original intention (and in staging sst driver), was state changes
when poll is woken up, but I agree in above case it is not true. I will
fix this

-- 
~Vinod
