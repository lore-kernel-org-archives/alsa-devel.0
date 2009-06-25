From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 19/19] sound: Use PCI_VDEVICE
Date: Wed, 24 Jun 2009 22:47:12 -0700
Message-ID: <1245908832.395.5.camel@Joe-Laptop.home>
References: <cover.1245906151.git.joe@perches.com>
	 <e27f875baa15d3d3e34c2a005cea9d702e822c57.1245906153.git.joe@perches.com>
	 <s5hocscna17.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758851AbZFYFrZ@vger.kernel.org>
In-Reply-To: <s5hocscna17.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2009-06-25 at 07:43 +0200, Takashi Iwai wrote:
> At Wed, 24 Jun 2009 22:13:35 -0700,
> Joe Perches wrote:
> > diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
> > index 18f4d1e..d589bbc 100644
> > --- a/sound/pci/ens1370.c
> > +++ b/sound/pci/ens1370.c
> > @@ -445,11 +445,11 @@ static irqreturn_t snd_audiopci_interrupt(int irq, void *dev_id);
> >  
> >  static struct pci_device_id snd_audiopci_ids[] = {
> >  #ifdef CHIP1370
> > -	{ 0x1274, 0x5000, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* ES1370 */
> > +	{ PCI_VDEVICE(ENSONIQ, 0x5000), 0, },	/* ES1370 */
> >  #endif
> >  #ifdef CHIP1371
> > -	{ 0x1274, 0x1371, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* ES1371 */
> > -	{ 0x1274, 0x5880, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* ES1373 - CT5880 */
> > +	{ PCI_VDEVICE(ENSONIQ, 0x1371), 0, },	/* ES1371 */
> > +	{ PCI_VDEVICE(ENSONIQ, 0x5880), 0, },	/* ES1373 - CT5880 */
> >  	{ 0x1102, 0x8938, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0, },	/* Ectiva EV1938 */
> 
> Any reason not to covert this?

Not really, 0x1102 maps to 2 PCI entries, CREATIVE and ECTIVA.
The script wouldn't know which is appropriate to use, so I skipped it.

The script is in 0/19: http://lkml.org/lkml/2009/6/25/21
