From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 05/14] ALSA: hdac: Add MISCBDCGE support
Date: Fri, 11 Dec 2015 14:55:27 +0530
Message-ID: <20151211092527.GV1854@localhost>
References: <1449816267-11910-1-git-send-email-vinod.koul@intel.com>
 <1449816267-11910-6-git-send-email-vinod.koul@intel.com>
 <s5hfuz9l60d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 456162657D8
 for <alsa-devel@alsa-project.org>; Fri, 11 Dec 2015 10:22:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfuz9l60d.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, Jayachandran B <jayachandran.b@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 11, 2015 at 09:54:42AM +0100, Takashi Iwai wrote:
> > +static void update_pci_dword(struct pci_dev *pci,
> > +			unsigned int reg, u32 mask, u32 val)
> > +{
> > +	u32 data;
> > +
> > +	pci_read_config_dword(pci, reg, &data);
> > +	data &= ~mask;
> > +	data |= (val & mask);
> > +	pci_write_config_dword(pci, reg, data);
> > +}
> > +
> > +void snd_hdac_ext_bus_enable_miscbdcge(struct device *dev, bool enable)
> > +{
> > +	struct pci_dev *pci = to_pci_dev(dev);
> > +	u32 val;
> > +
> > +	val = enable ? AZX_CGCTL_MISCBDCGE_MASK : 0;
> > +
> > +	update_pci_dword(pci, AZX_PCIREG_CGCTL, AZX_CGCTL_MISCBDCGE_MASK, val);
> > +}
> > +EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_enable_miscbdcge);
> 
> PCI access doesn't belong in the HDA-core in general.  It's over the
> abstraction level of HD-audio controller.

Okay but this is part of HDA controller and I think we might be using this
bit so move to core for common usage.

I can move to driver if you feel that is better approach

-- 
~Vinod
