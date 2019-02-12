From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: Re: [PATCH] ALSA: PCM: check if ops are defined before
 suspending PCM
Date: Tue, 12 Feb 2019 12:48:10 -0800
Message-ID: <04d603b1b56e6de34cd366f249c6d8ac113309d6.camel@linux.intel.com>
References: <20190208232953.7266-1-pierre-louis.bossart@linux.intel.com>
 <s5hwom971m9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 47C2D2673E2
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 21:48:12 +0100 (CET)
In-Reply-To: <s5hwom971m9.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2019-02-09 at 10:27 +0100, Takashi Iwai wrote:
> On Sat, 09 Feb 2019 00:29:53 +0100,
> Pierre-Louis Bossart wrote:
> > 
> > From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
> > 
> > BE dai links only have internal PCM's and their substream ops may
> > not be set. Suspending these PCM's will result in their
> >  ops->trigger() being invoked and cause a kernel oops.
> > So skip suspending PCM's if their ops are NULL.
> > 
> > Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com
> > >
> > Signed-off-by: Pierre-Louis Bossart <
> > pierre-louis.bossart@linux.intel.com>
> > ---
> >  sound/core/pcm_native.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> > index 818dff1de545..b6e158ce6650 100644
> > --- a/sound/core/pcm_native.c
> > +++ b/sound/core/pcm_native.c
> > @@ -1506,6 +1506,14 @@ int snd_pcm_suspend_all(struct snd_pcm *pcm)
> >  			/* FIXME: the open/close code should lock this
> > as well */
> >  			if (substream->runtime == NULL)
> >  				continue;
> > +
> > +			/*
> > +			 * Skip BE dai link PCM's that are internal and
> > may
> > +			 * not have their substream ops set.
> > +			 */
> > +			if (!substream->ops)
> > +				continue;
> > +
> >  			err = snd_pcm_suspend(substream);
> >  			if (err < 0 && err != -EBUSY)
> >  				return err;
> 
> Basically it's OK and safe to apply this check.  We may need to add
> such sanity checks in more places if this really hits.
> 
> But I still wonder how this can go through.  Is substream->runtime
> set
> even if substream->ops is NULL?  The substream->runtime is assigned
> dynamically at opening a substream via snd_pcm_attach_substream(), so
> without opening it, it must be NULL.
Hi Takashi,

My guess is that this happens during
dpcm_be_connect(fe, be, stream) in dpcm_add_paths().

The reason this wasnt exposed before was that the fe dai link pcm's
were suspended first. So when it was BE dai links' turn, the pcm was
already suspended. In the case of SOF, the order of dai links in the
rtd_list is BE dai links first and then the FE dai links.

Thanks,
Ranjani

> 
> 
> thanks,
> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
