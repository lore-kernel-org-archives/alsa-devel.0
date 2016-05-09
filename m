From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/3] ALSA: hdac: add link pm and ref
	counting
Date: Mon, 9 May 2016 13:28:23 +0530
Message-ID: <20160509075823.GB2274@localhost>
References: <1462428071-30248-1-git-send-email-vinod.koul@intel.com>
 <1462428071-30248-2-git-send-email-vinod.koul@intel.com>
 <20160509044100.GX2274@localhost> <s5hvb2nrax3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id D192E260515
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 09:52:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvb2nrax3.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, May 09, 2016 at 08:40:56AM +0200, Takashi Iwai wrote:
> > >   * @gtscap: gts capabilities pointer
> > >   * @drsmcap: dma resume capabilities pointer
> > >   * @hlink_list: link list of HDA links
> > > + * @lock: lock for link mgmt
> > > + * @cmd_io: state of cmd_io
> > >   */
> > >  struct hdac_ext_bus {
> > >  	struct hdac_bus bus;
> > > @@ -27,6 +29,9 @@ struct hdac_ext_bus {
> > >  	void __iomem *drsmcap;
> > >  
> > >  	struct list_head hlink_list;
> > > +
> > > +	struct mutex lock;
> > > +	int cmd_io;
> 
> It'd be better to put some comments what the flag means.
> Also, a bool would be clearer.

Well we do have comment that it means state of cmd_io but yes we can make it
clearer by explicitly saying the state of cmd DMAs CORB and RIRB

I will make it a bool

> > > +int snd_hdac_ext_bus_link_put(struct hdac_ext_bus *ebus,
> > > +				struct hdac_ext_link *link)
> > > +{
> > > +	int ret = 0, state = 0;
> > > +	struct hdac_ext_link *hlink = NULL;
> 
> Why initializing hlink?

Not required :)

> > > +	/*
> > > +	 * if we move from 1 to 0, count will be 0
> > > +	 * so power down this link as well
> > > +	 */
> > > +	if (--link->ref_count == 0) {
> > > +		ret = snd_hdac_ext_bus_link_power_down(link);
> > > +
> > > +		/*
> > > +		 * now check if all links are off, if so turn off
> > > +		 * cmd dma as well
> > > +		 */
> > > +		list_for_each_entry(hlink, &ebus->hlink_list, list) {
> > > +			if (hlink->ref_count)
> > > +				state++;
> > > +		}
> 
> Basically you can break at the first match.  But it's supposed to be a
> relatively short list, so no performance impact should be seen.
> So, take micro-optimization only if it's simple enough.

No not in this case, we are scanning the state of all links to see if they
are on or not and turning off DMAs when all the links are off, so we can't
break at first match in this case.

Yes for other places where we find a link, first match break will help, I
will check that

Thanks
-- 
~Vinod
