From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH] ALSA: hda - Enable runtime pm for Haswell
Date: Thu, 16 May 2013 12:04:03 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC489010E6AFD9@SHSMSX102.ccr.corp.intel.com>
References: <1368692945-2122-1-git-send-email-xingchao.wang@linux.intel.com>
 <s5hehd7jomk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 03EC32654E3
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2013 14:04:45 +0200 (CEST)
In-Reply-To: <s5hehd7jomk.wl%tiwai@suse.de>
Content-Language: en-US
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
Cc: "Li, Jocelyn" <jocelyn.li@intel.com>, "Lin,
 Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,


> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, May 16, 2013 4:49 PM
> To: Wang Xingchao
> Cc: Girdwood, Liam R; Lin, Mengdong; Li, Jocelyn; alsa-devel@alsa-project.org;
> Wang, Xingchao
> Subject: Re: [PATCH] ALSA: hda - Enable runtime pm for Haswell
> 
> At Thu, 16 May 2013 16:29:05 +0800,
> Wang Xingchao wrote:
> >
> > Haswell doesnot support runtime pm by default.
> > This patch let haswell Display HD-A controller enter runtime suspend,
> > and bring more power saving whith power-well.
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> 
> I don't think it's good to fiddle such a thing in the driver side.
> If Haswell can support runtime PM really, it should be set commonly.

Haswell doesnot show its power capability to support PME, I'm not sure it's caused by BIOS setting
or need some additional configurations in PCI registers.
So pci_dev_run_wake() return false and  this make haswell lose
the chance to support runtime pm in software, right?

If a PCI device would support runtime pm in software, maybe it doesnot support PME in hardware level, it should
get a chance to try. I see some pci devices, they look much like:

pm_runtime_put_noidle(&pdev->dev);
pm_runtime_allow(&pdev->dev);

anyway it's better if we can set haswell PME capability externally,  then it fits current code.
but if there's such software requirement for runtime pm, it should be improved, right?

Thanks
--xingchao
> 
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/hda_intel.c |    6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index bf27693..eb25888 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -3755,6 +3755,12 @@ static int azx_probe(struct pci_dev *pci,
> >
> >  	if (pci_dev_run_wake(pci))
> >  		pm_runtime_put_noidle(&pci->dev);
> > +	else if (chip->driver_caps
> > +			& AZX_DCAPS_I915_POWERWELL) {
> > +		/* Haswell doesnot support runtime pm by default */
> > +		pm_runtime_put_noidle(&pci->dev);
> > +		pm_runtime_allow(&pci->dev);
> > +	}
> >
> >  	dev++;
> >  	complete_all(&chip->probe_wait);
> > --
> > 1.7.9.5
> >
