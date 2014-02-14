From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [PATCH 1/5] ASoC: Intel: Add Intel SST audio DSP
 low	level shim driver.
Date: Fri, 14 Feb 2014 10:02:16 +0000
Message-ID: <1392372136.2300.22.camel@loki>
References: <1392318930-8771-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5hzjluhzbk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 968A5261675
 for <alsa-devel@alsa-project.org>; Fri, 14 Feb 2014 11:02:24 +0100 (CET)
In-Reply-To: <s5hzjluhzbk.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Benson Leung <bleung@google.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2014-02-14 at 09:29 +0100, Takashi Iwai wrote:
> At Thu, 13 Feb 2014 19:15:26 +0000,
> Liam Girdwood wrote:

> > +/* Public API */
> > +void sst_dsp_shim_write(struct sst_dsp *sst, u32 offset, u32 value)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&sst->spinlock, flags);
> > +	sst->ops->write(sst->addr.shim, offset, value);
> > +	spin_unlock_irqrestore(&sst->spinlock, flags);
> > +}
> > +EXPORT_SYMBOL(sst_dsp_shim_write);
> 
> Any reason not to use *_GPL() version?
> 

No that should be GPL. Will fix.


> > +int sst_dsp_shim_update_bits64_unlocked(struct sst_dsp *sst, u32 offset,
> > +				u64 mask, u64 value)
> > +{
> > +	bool change;
> > +	u64 old, new;
> > +
> > +	old = sst_dsp_shim_read64_unlocked(sst, offset);
> > +
> > +	new = (old & (~mask)) | (value & mask);
> > +
> > +	change = (old != new);
> > +	if (change)
> > +		sst_dsp_shim_write64_unlocked(sst, offset, new);
> > +
> > +	return change;
> > +}
> > +EXPORT_SYMBOL(sst_dsp_shim_update_bits64_unlocked);
> 
> The locked versions can be simplified by calling the unlocked
> function.
> 

True, will change for V2


> > +
> > +void sst_dsp_ipc_msg_tx(struct sst_dsp *dsp, u32 msg)
> > +{
> > +	sst_dsp_shim_write_unlocked(dsp, SST_IPCX, msg | SST_IPCX_BUSY);
> > +	trace_sst_ipc_msg_tx(msg);
> 
> The trace isn't defined yet in the first patch, so the build fails
> here.  Each commit should be at least compilable.
> 

It is build-able for bisect etc, the Make/Kconfig patch is last in this
series after the trace patch. 

Liam
