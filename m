From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] ALSA: au88x0: pr_* replaced with dev_*
Date: Thu, 09 Oct 2014 07:18:03 -0700
Message-ID: <1412864283.3438.43.camel@joe-AO725>
References: <1412847397-4292-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <1412847397-4292-2-git-send-email-sudipm.mukherjee@gmail.com>
	 <s5hd2a1tlb2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hd2a1tlb2.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2014-10-09 at 15:38 +0200, Takashi Iwai wrote:
> At Thu,  9 Oct 2014 15:06:37 +0530,
> Sudip Mukherjee wrote:
> > 
> > pr_* macros replaced with dev_* as they are more preffered over pr_*.
> > each file which had pr_* was reviewed manually and replaced with dev_*.
> > here we have actually used the reference of the vortex which was added
> > to some functions in the previous patch of this series.
> > 
> > Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
> > ---
> >  sound/pci/au88x0/au88x0.c        |  26 +++++-----
> >  sound/pci/au88x0/au88x0_a3d.c    |  15 +++---
> >  sound/pci/au88x0/au88x0_core.c   | 103 ++++++++++++++++++++++-----------------
> >  sound/pci/au88x0/au88x0_eq.c     |   3 +-
> >  sound/pci/au88x0/au88x0_game.c   |   3 +-
> >  sound/pci/au88x0/au88x0_mpu401.c |   2 +-
> >  sound/pci/au88x0/au88x0_pcm.c    |   7 +--
> >  sound/pci/au88x0/au88x0_synth.c  |  17 ++++---
> >  8 files changed, 98 insertions(+), 78 deletions(-)
> > 
> > diff --git a/sound/pci/au88x0/au88x0.c b/sound/pci/au88x0/au88x0.c
[]
> > @@ -48,10 +48,10 @@ static void vortex_fix_latency(struct pci_dev *vortex)
> >  {
> >  	int rc;
> >  	if (!(rc = pci_write_config_byte(vortex, 0x40, 0xff))) {
> > -			pr_info( CARD_NAME
> > +			dev_info(&vortex->dev, CARD_NAME
> >  			       ": vortex latency is 0xff\n");
> 
> Omit the superfluous prefix when converting to dev_info() & co.
> Other than that, looks good to me.

Hi Sudip.

Probably all the uses of CARD_NAME and "vortex" singly and
in combination should be removed in all these conversions.
