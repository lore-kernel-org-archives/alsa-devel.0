From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] ALSA,
 hda: Add support for Lenovo ThinkPad Edge 13 in conexant codec
Date: Fri, 28 May 2010 01:02:09 -0500
Message-ID: <1275026529.2945.1701.camel@laptop>
References: <20100527160656.GE10254@alberich.amd.com>
	<s5htyps3788.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3151C103AD1
	for <alsa-devel@alsa-project.org>;
	Fri, 28 May 2010 08:02:16 +0200 (CEST)
In-Reply-To: <s5htyps3788.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andreas Herrmann <herrmann.der.user@googlemail.com>, Borislav Petkov <borislav.petkov@amd.com>
List-Id: alsa-devel@alsa-project.org

@Andreas
	can you grab Alsa git tree and install it on the system you are using.
It has a patch already taking care of the issue.

The issue Takashi is most likely folks using the older kernel version.
model=ideapad was just recently introduced so they where unable to try
that out. But olpc-xo-1_5 has been there for a while. Though for Lenovo
products model=ideapad is much better.


	
			Thanks,
				Jerone
On Fri, 2010-05-28 at 07:50 +0200, Takashi Iwai wrote:
> At Thu, 27 May 2010 18:06:56 +0200,
> Andreas Herrmann wrote:
> > 
> > From: Andreas Herrmann <andreas.herrmann3@amd.com>
> > 
> > On a Thinkpad Edge 13 I had the problem that speakers played sound
> > although headphones were plugged.
> > 
> > Using "model=olpc-xo-1_5" solved this problem. So it seems sensible to
> > add this quirk. (Using other models, like ideabad did not fix it.)
> > 
> > Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
> > ---
> >  sound/pci/hda/patch_conexant.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> > 
> > I don't know whether adding this quirk is the right/complete solution
> > to support sound on Thinkpad Edge. But at least it solves this
> > annoying problem.
> 
> Well, Jerone Young already sent a quirk patch but he took
> model=ideapd.  Could you guys check which one is really better?
> 
> 
> thanks,
> 
> Takashi
> 
> 
> > 
> > Please apply.
> > 
> > 
> > Thanks,
> > 
> > Andreas
> > 
> > diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
> > index feabb44..f85f072 100644
> > --- a/sound/pci/hda/patch_conexant.c
> > +++ b/sound/pci/hda/patch_conexant.c
> > @@ -2848,6 +2848,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
> >  	SND_PCI_QUIRK(0x1179, 0xff50, "Toshiba Satellite P500-PSPGSC-01800T", CXT5066_OLPC_XO_1_5),
> >  	SND_PCI_QUIRK(0x1179, 0xffe0, "Toshiba Satellite Pro T130-15F", CXT5066_OLPC_XO_1_5),
> >  	SND_PCI_QUIRK(0x17aa, 0x21b2, "Thinkpad X100e", CXT5066_IDEAPAD),
> > +	SND_PCI_QUIRK(0x17aa, 0x21b3, "Thnkpad Edge 13", CXT5066_OLPC_XO_1_5),
> >  	SND_PCI_QUIRK(0x17aa, 0x3a0d, "ideapad", CXT5066_IDEAPAD),
> >  	{}
> >  };
> > -- 
> > 1.6.4.4
> > 
