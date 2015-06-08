From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 1/3] ALSA: hdac_ext: add extended HDA bus
Date: Mon, 8 Jun 2015 20:54:23 +0530
Message-ID: <20150608152423.GM28601@localhost>
References: <1433411602-5444-1-git-send-email-vinod.koul@intel.com>
 <1433411602-5444-2-git-send-email-vinod.koul@intel.com>
 <s5hfv62k1wv.wl-tiwai@suse.de> <20150608101008.GD28601@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 50E52260421
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 17:23:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150608101008.GD28601@localhost>
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

On Mon, Jun 08, 2015 at 03:40:08PM +0530, Vinod Koul wrote:
> On Mon, Jun 08, 2015 at 11:03:12AM +0200, Takashi Iwai wrote:
> > One thing forgot...
> > 
> > At Thu,  4 Jun 2015 15:23:20 +0530,
> > Vinod Koul wrote:
> > > 
> > > +/**
> > > + * snd_hdac_ext_device_init - initialize the HDA extended codec base device
> > > + * @sbus: hdac extended bus to attach to
> > > + * @addr: codec address
> > > + *
> > > + * Returns zero for success or a negative error code.
> > > + */
> > > +int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *sbus, int addr)
> > > +{
> > > +	struct hdac_device *hdev = NULL;
> > > +	struct hdac_bus *bus = hdac_bus(sbus);
> > > +	char name[15];
> > > +	int ret;
> > > +
> > > +	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
> > > +	if (!hdev)
> > > +		return -ENOMEM;
> > > +
> > > +	snprintf(name, sizeof(name), "hda-codec#%03x", addr);
> > > +
> > > +	ret  = snd_hdac_device_init(hdev, bus, name, addr);
> > 
> > The device name must be unique to the whole system.  Using only the
> > codec address as an id would conflict if there are multiple cards.
> > The legacy HDA device consists of "hdaudioC%dD%d" indicating both the
> > card number and the codec address, for example.
> Sorry my bad, you did comment on it before as well. I will fix it now, by
> adding card name here.
Okay and we have an issue here :(, We actually dont know the card number
here and card number will be created after this enumeration is complete
and we register the DAI with ASoC and then ASoC would create card later.

So how do we solve this?

-- 
~Vinod
