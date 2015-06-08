From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 1/3] ALSA: hdac_ext: add extended HDA bus
Date: Mon, 8 Jun 2015 15:40:08 +0530
Message-ID: <20150608101008.GD28601@localhost>
References: <1433411602-5444-1-git-send-email-vinod.koul@intel.com>
 <1433411602-5444-2-git-send-email-vinod.koul@intel.com>
 <s5hfv62k1wv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FC23260418
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 12:08:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfv62k1wv.wl-tiwai@suse.de>
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

On Mon, Jun 08, 2015 at 11:03:12AM +0200, Takashi Iwai wrote:
> One thing forgot...
> 
> At Thu,  4 Jun 2015 15:23:20 +0530,
> Vinod Koul wrote:
> > 
> > +/**
> > + * snd_hdac_ext_device_init - initialize the HDA extended codec base device
> > + * @sbus: hdac extended bus to attach to
> > + * @addr: codec address
> > + *
> > + * Returns zero for success or a negative error code.
> > + */
> > +int snd_hdac_ext_bus_device_init(struct hdac_ext_bus *sbus, int addr)
> > +{
> > +	struct hdac_device *hdev = NULL;
> > +	struct hdac_bus *bus = hdac_bus(sbus);
> > +	char name[15];
> > +	int ret;
> > +
> > +	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
> > +	if (!hdev)
> > +		return -ENOMEM;
> > +
> > +	snprintf(name, sizeof(name), "hda-codec#%03x", addr);
> > +
> > +	ret  = snd_hdac_device_init(hdev, bus, name, addr);
> 
> The device name must be unique to the whole system.  Using only the
> codec address as an id would conflict if there are multiple cards.
> The legacy HDA device consists of "hdaudioC%dD%d" indicating both the
> card number and the codec address, for example.
Sorry my bad, you did comment on it before as well. I will fix it now, by
adding card name here.

-- 
~Vinod
