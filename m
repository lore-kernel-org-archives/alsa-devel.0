From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v6 2/3] ALSA: hdac_ext: add hdac extended
 controller
Date: Mon, 8 Jun 2015 21:02:59 +0530
Message-ID: <20150608153259.GO28601@localhost>
References: <1433411602-5444-1-git-send-email-vinod.koul@intel.com>
 <1433411602-5444-3-git-send-email-vinod.koul@intel.com>
 <s5heglmk1gv.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D27826040E
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 17:31:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5heglmk1gv.wl-tiwai@suse.de>
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

On Mon, Jun 08, 2015 at 11:12:48AM +0200, Takashi Iwai wrote:
> > +struct hdac_ext_link {
> > +	struct hdac_bus *bus;
> > +	int index;
> > +	void __iomem *ml_addr; /* link output stream reg pointer */
> > +	u32 lcaps;   /* link capablities */
> > +	u16 lsdiid;  /* link sdi identifier */
> > +	char codec[HDA_MAX_CODECS][32]; /* codecs connectes to the link */
> 
> Do we need to keep the codec name string?  Isn't it just codec address
> we'd like to check the match...?  If so, we may use bitmasks instead,
> too.
This is not for matching stuff (this is link structure and not codec)
So we keep name of codec found on this link. When ASoC BE triggers we use
codec name to find the link and use

> > +/**
> > + * snd_hdac_ext_bus_parse_capabilities - parse capablity structure
> > + * @sbus: the pointer to extended bus object
> > + *
> > + * Returns 0 if successful, or a negative error code.
> > + */
> > +int snd_hdac_ext_bus_parse_capabilities(struct hdac_ext_bus *sbus)
> > +{
> > +	unsigned int cur_cap;
> > +	unsigned int offset;
> > +	struct hdac_bus *bus = &sbus->bus;
> > +
> > +	offset = snd_hdac_chip_readl(bus, LLCH);
> > +
> > +	if (offset < 0)
> > +		return -EIO;
> > +
> > +	sbus->ppcap = false;
> > +	sbus->mlcap = false;
> > +	sbus->spbcap = false;
> > +	sbus->gtscap = false;
> > +
> > +	/* Lets walk the linked capabilities list */
> > +	do {
> > +		cur_cap = _snd_hdac_chip_read(l, bus, offset);
> > +
> > +		if (cur_cap < 0)
> > +			return -EIO;
> > +
> > +		dev_dbg(bus->dev, "Capability version: 0x%x\n",
> > +				((cur_cap & AZX_CAP_HDR_VER_MASK) >> AZX_CAP_HDR_VER_OFF));
> > +
> > +		dev_dbg(bus->dev, "HDA capability ID: 0x%x\n",
> > +				(cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF);
> > +
> > +		switch ((cur_cap & AZX_CAP_HDR_ID_MASK) >> AZX_CAP_HDR_ID_OFF) {
> > +		case AZX_ML_CAP_ID:
> > +			dev_dbg(bus->dev, "Found ML capability\n");
> > +			sbus->mlcap = true;
> > +			sbus->mlcap_addr = bus->remap_addr + offset;
> 
> Can be flags (mlcap, gtscap, etc) removed by just NULL-checking the
> corresponding address?
Yes, removed these

> > +			break;
> > +
> > +		case AZX_GTS_CAP_ID:
> > +			dev_dbg(bus->dev, "Found GTS capability offset=%x\n", offset);
> > +			sbus->gtscap = true;
> > +			sbus->gtscap_addr = bus->remap_addr + offset;
> > +			break;
> > +
> > +		case AZX_PP_CAP_ID:
> > +			/* PP capability found, the Audio DSP is present */
> > +			dev_dbg(bus->dev, "Found PP capability offset=%x\n", offset);
> > +			sbus->ppcap = true;
> > +			sbus->ppcap_addr = bus->remap_addr + offset;
> > +			break;
> > +
> > +		case AZX_SPB_CAP_ID:
> > +			/* SPIB capability found, handler function */
> > +			dev_dbg(bus->dev, "Found SPB capability\n");
> > +			sbus->spbcap = true;
> > +			sbus->spbcap_addr = bus->remap_addr + offset;
> > +			break;
> > +
> > +		default:
> > +			dev_dbg(bus->dev, "Unknown capability %d\n", cur_cap);
> > +			break;
> > +		}
> > +
> > +		/* read the offset of next capabiity */
> > +		offset = cur_cap & AZX_CAP_HDR_NXT_PTR_MASK;
> > +	} while (offset);
> 
> Better to have a loop counter for avoiding the endless loop.
> You should never trust the hardware.
So we have 4 caps, so am going to put 10 as count for now and bail out on
10th one...

> 
> > +MODULE_DESCRIPTION("HDA extended core");
> > +MODULE_LICENSE("GPL v2");
> 
> These should have been added in the first patch.
Yes will move

-- 
~Vinod
