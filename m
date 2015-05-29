From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add topology core
Date: Fri, 29 May 2015 11:27:31 +0530
Message-ID: <20150529055731.GB3140@localhost>
References: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1432574570-7436-2-git-send-email-liam.r.girdwood@linux.intel.com>
 <20150527190021.GO21577@sirena.org.uk>
 <1432823609.2726.42.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 29AD52665E7
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 07:56:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1432823609.2726.42.camel@loki>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Zhang, Vivian" <vivian.zhang@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, May 28, 2015 at 03:33:29PM +0100, Liam Girdwood wrote:
> On Wed, 2015-05-27 at 20:00 +0100, Mark Brown wrote:
> > On Mon, May 25, 2015 at 06:22:49PM +0100, Liam Girdwood wrote:
> > 
> > This looks really nice at a high level, obviously it's a lot of code so
> > there might be detail problems but I expect we can fix those up later.
> > 
> > > @@ -564,6 +565,7 @@ struct snd_soc_dapm_widget {
> > >  	int num_kcontrols;
> > >  	const struct snd_kcontrol_new *kcontrol_news;
> > >  	struct snd_kcontrol **kcontrols;
> > > +	struct snd_soc_dobj dobj;
> > >  
> > >  	/* widget input and outputs */
> > >  	struct list_head sources;
> > 
> > This adds the dynamic object (which isn't enormous but isn't tiny) to
> > every widget which could add up a bit.  I don't know if it's worth
> > making it a pointer to a dobj and allocating that separately?  OTOH it's
> > really routes rather than widgets that are the big cost, and it depends
> > on allocators being friendly and not putting lots of padding round
> > dobjs.  Definitely fixable incrementally if it is an issue though.
> > 
> 
> Fwiw, we are planning to shrink DAPM a bit as part of the reduced memory
> work that Keyon and Vivian are doing. This will be on the list.
> 
> > > +	/* external kcontrol init - used to set ext funcs + private data */
> > > +	int (*control_load)(struct snd_soc_component *,
> > > +		struct snd_kcontrol_new *, struct snd_soc_tplg_ctl_hdr *);
> > > +	int (*control_unload)(struct snd_soc_component *,
> > > +		struct snd_soc_dobj *);
> > 
> > Do we have examples of all these external users yet?  Just thinking
> > about what happens if we need a load/unload function but the kernel
> > doesn't know about this particular firmware type - the file didn't say
> > code would be needed and perhaps the code is optional anyway (some
> > optimisation or something).  Is that something that was thought about
> > yet, what sort of uses are we expecting?
> 
> Vinod has some example code that has the callback on SKL (dont know if
> it's on public git atm). The intention here was to allow the driver to
> setup any configuration outside the standard kcontrol registration, so
> it would be used for things like sending DSP IPC messages to create the
> control in FW, or loading the private data into the DSP for that control
> etc. The comment is probably misleading since the get/put/info function
> binding is done in the core. I'll fix the comment for V3. 
The toplogy code wasnt sent in RFC as it was dependent on this series but I
can push it to git if Mark wants a look :)

So for us, each control requires some parameters which we need to pass to
DSP in order to instantiate that object. So we get the callback into driver
and save the private data in kcontrol and pass it to DSP as IPC parameters

-- 
~Vinod
> 
> > 
> > > +/* pass vendor data to component driver for processing */
> > > +static int soc_tplg_vendor_load_(struct soc_tplg *tplg,
> > > +	struct snd_soc_tplg_hdr *hdr)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	if (tplg->comp && tplg->ops && tplg->ops->vendor_load)
> > > +		ret = tplg->ops->vendor_load(tplg->comp, hdr);
> > > +
> > > +	if (ret < 0)
> > > +		dev_err(tplg->dev,
> > > +			"ASoC: vendor load failed at hdr offset %ld/0x%lx for type %d:%d\n",
> > > +			soc_tplg_get_hdr_offset(tplg),
> > > +			soc_tplg_get_hdr_offset(tplg),
> > > +			hdr->type, hdr->vendor_type);
> > > +	return ret;
> > > +}
> > 
> > For example I wonder if we should warn if we don't have a handler for
> > vendor data that we see?
> 
> Yes, will fix in V3.
> 

-- 
