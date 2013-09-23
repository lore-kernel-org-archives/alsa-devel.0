From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH] ALSA: compress: Make sure we trigger STOP
 before closing the stream.
Date: Mon, 23 Sep 2013 11:19:39 +0100
Message-ID: <1379931579.2516.48.camel@loki>
References: <1379090597-7096-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20130916035753.GJ17188@intel.com> <1379329283.3215.34.camel@loki>
 <s5hr4ckahjp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7221B260845
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 12:20:10 +0200 (CEST)
In-Reply-To: <s5hr4ckahjp.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.jf.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2013-09-19 at 18:43 +0200, Takashi Iwai wrote:
> At Mon, 16 Sep 2013 12:01:23 +0100,
> Liam Girdwood wrote:
> > 
> > On Mon, 2013-09-16 at 09:27 +0530, Vinod Koul wrote:
> > > On Fri, Sep 13, 2013 at 05:43:16PM +0100, Liam Girdwood wrote:
> > > > Currently we assume that userspace will shut down the compressed stream
> > > > correctly. However, if userspcae dies (e.g. cplay & ctrl-C) we dont
> > > > stop the stream before freeing it.
> > > > 
> > > > This now checks that the stream is stopped before freeing.
> > > > 
> > > > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > > > ---
> > > >  sound/core/compress_offload.c | 12 ++++++++++++
> > > >  1 file changed, 12 insertions(+)
> > > > 
> > > > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > > > index 99db892..a9ae4f3 100644
> > > > --- a/sound/core/compress_offload.c
> > > > +++ b/sound/core/compress_offload.c
> > > > @@ -139,6 +139,18 @@ static int snd_compr_open(struct inode *inode, struct file *f)
> > > >  static int snd_compr_free(struct inode *inode, struct file *f)
> > > >  {
> > > >  	struct snd_compr_file *data = f->private_data;
> > > > +	struct snd_compr_runtime *runtime = data->stream.runtime;
> > > > +
> > > > +	switch (runtime->state) {
> > > > +	case SNDRV_PCM_STATE_RUNNING:
> > > > +	case SNDRV_PCM_STATE_DRAINING:
> > > > +	case SNDRV_PCM_STATE_PAUSED:
> > > > +		data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
> > > when usermode dies the free will get invoked as we have below. The free is a
> > > valid trigger from any state. So shouldnt the DSP then STOP the DMAs and free
> > > the streams.
> > 
> > This means that the compressed stream ops don't follow the PCM ops wrt
> > trigger() sequencing (i.e. we have to add extra logic in free to deal
> > with this difference).
> > 
> > I think it would be better to follow the PCM operations use case here as
> > it simplifies the driver code and stops people making the false
> > assumption that trigger() works the same way throughout ALSA ?   
> 
> Well, the trigger of compress API has a few more jobs than PCM,
> and it's exactly what should be fixed (e.g. the proper handling of
> drain).  We need a bit more consensus over that.
> 
> So, I didn't apply this patch yet.  If Vinod is happy with this (even
> as a temporary solution), let me know.

Without this patch we have the two different sequences for shutdown
depending on whether userspace dies or not. i.e.

1) Normal: trigger(start) -> play -> trigger(stop) -> close()

2) ctrl-C: trigger(start) -> play -> ctrl-C -> close() 

So we miss out the trigger(STOP) and close the device with the stream
still in a trigger running state.

Liam
