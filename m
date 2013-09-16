From: Liam Girdwood <liam.r.girdwood@intel.com>
Subject: Re: [PATCH] ALSA: compress: Make sure we trigger STOP
 before closing the stream.
Date: Mon, 16 Sep 2013 12:01:23 +0100
Message-ID: <1379329283.3215.34.camel@loki>
References: <1379090597-7096-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <20130916035753.GJ17188@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id F1F1A2608D3
 for <alsa-devel@alsa-project.org>; Mon, 16 Sep 2013 13:01:27 +0200 (CEST)
In-Reply-To: <20130916035753.GJ17188@intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <liam.r.girdwood@linux.jf.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2013-09-16 at 09:27 +0530, Vinod Koul wrote:
> On Fri, Sep 13, 2013 at 05:43:16PM +0100, Liam Girdwood wrote:
> > Currently we assume that userspace will shut down the compressed stream
> > correctly. However, if userspcae dies (e.g. cplay & ctrl-C) we dont
> > stop the stream before freeing it.
> > 
> > This now checks that the stream is stopped before freeing.
> > 
> > Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> > ---
> >  sound/core/compress_offload.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index 99db892..a9ae4f3 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -139,6 +139,18 @@ static int snd_compr_open(struct inode *inode, struct file *f)
> >  static int snd_compr_free(struct inode *inode, struct file *f)
> >  {
> >  	struct snd_compr_file *data = f->private_data;
> > +	struct snd_compr_runtime *runtime = data->stream.runtime;
> > +
> > +	switch (runtime->state) {
> > +	case SNDRV_PCM_STATE_RUNNING:
> > +	case SNDRV_PCM_STATE_DRAINING:
> > +	case SNDRV_PCM_STATE_PAUSED:
> > +		data->stream.ops->trigger(&data->stream, SNDRV_PCM_TRIGGER_STOP);
> when usermode dies the free will get invoked as we have below. The free is a
> valid trigger from any state. So shouldnt the DSP then STOP the DMAs and free
> the streams.

This means that the compressed stream ops don't follow the PCM ops wrt
trigger() sequencing (i.e. we have to add extra logic in free to deal
with this difference).

I think it would be better to follow the PCM operations use case here as
it simplifies the driver code and stops people making the false
assumption that trigger() works the same way throughout ALSA ?   

> Given that most of the usage is a DSP then IMO it might make send to tell DSP
> that stop and cleanup rather than saying stop and cleanup?
> 

Sorry, don't follow you here ;)

Liam

> ~Vinod
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> >  	data->stream.ops->free(&data->stream);
> >  	kfree(data->stream.runtime->buffer);
> >  	kfree(data->stream.runtime);
> > -- 
> > 1.8.1.2
> > 
> 



---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
