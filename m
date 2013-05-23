From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 3/4] ALSA: hda - Fix runtime PM check
Date: Thu, 23 May 2013 07:53:00 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC4890118165D2@SHSMSX104.ccr.corp.intel.com>
References: <1369242256-32112-1-git-send-email-xingchao.wang@linux.intel.com>
	<1369242256-32112-4-git-send-email-xingchao.wang@linux.intel.com>
	<s5hli768c92.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
In-Reply-To: <s5hli768c92.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Li,
	Jocelyn" <jocelyn.li@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, Wang Xingchao <xingchao.wang@linux.intel.com>, "Girdwood,
	Liam R" <liam.r.girdwood@intel.com>, "david.henningsson@canonical.com" <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, May 23, 2013 2:03 PM
> To: Wang Xingchao
> Cc: daniel@ffwll.ch; alsa-devel@alsa-project.org;
> intel-gfx@lists.freedesktop.org; david.henningsson@canonical.com; Girdwood,
> Liam R; Li, Jocelyn; Wang, Xingchao
> Subject: Re: [PATCH 3/4] ALSA: hda - Fix runtime PM check
> 
> At Thu, 23 May 2013 01:04:15 +0800,
> Wang Xingchao wrote:
> >
> > The device can support runtime PM no matter whether it support signal
> > wakeup or not. For some chips like Haswell which doesnot support PME
> > by default, this patch let haswell Display HD-A controller enter
> > runtime suspend, and bring more power saving whith power-well feature
> > enabled.
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> 
> This change has nothing to do with the power well fix, thus no reason to put in
> the series.

But power-well feature depends on HD-A controller's power-save enabling, without this patch,
Power-well would not be shutdown automatically, thus cause more power. So I thought it should
be part of the patchset. Anyway it's a more general fix not only for Haswell, so better to leave it alone.
I will split it from the patchset in next version.

Thanks
--xingchao
> 
> 
> Takashi
> 
> > ---
> >  sound/pci/hda/hda_intel.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> > index 54c7c22..f20a88c 100644
> > --- a/sound/pci/hda/hda_intel.c
> > +++ b/sound/pci/hda/hda_intel.c
> > @@ -3755,7 +3755,7 @@ static int azx_probe(struct pci_dev *pci,
> >  			goto out_free_power;
> >  	}
> >
> > -	if (pci_dev_run_wake(pci))
> > +	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
> >  		pm_runtime_put_noidle(&pci->dev);
> >
> >  	dev++;
> > @@ -3834,7 +3834,7 @@ static void azx_remove(struct pci_dev *pci)
> >  	struct snd_card *card = pci_get_drvdata(pci);
> >  	struct azx *chip = card->private_data;
> >
> > -	if (pci_dev_run_wake(pci))
> > +	if (chip->driver_caps & AZX_DCAPS_PM_RUNTIME)
> >  		pm_runtime_get_noresume(&pci->dev);
> >
> >  	if (card)
> > --
> > 1.8.1.2
> >
