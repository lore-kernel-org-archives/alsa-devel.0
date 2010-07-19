From: Jerone Young <jerone.young@canonical.com>
Subject: Re: [PATCH] Add conexant quirk for AMD based Lenovo G
 series machines
Date: Mon, 19 Jul 2010 11:56:14 -0500
Message-ID: <1279558574.20323.44.camel@laptop>
References: <1279546258.1719.1636.camel@laptop> <s5h1vazfmdn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A15B24555
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 18:56:18 +0200 (CEST)
In-Reply-To: <s5h1vazfmdn.wl%tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I sent two today. This was the 2nd one. Needs to be applied after the
first one.

			Jerone

On Mon, 2010-07-19 at 18:48 +0200, Takashi Iwai wrote:
> At Mon, 19 Jul 2010 08:30:58 -0500,
> Jerone Young wrote:
> > 
> > This is a follow on patch adds support for AMD based Lenovo G series
> > machines, such as the Lenovo G555.
> > 
> > Signed-off-by: Jerone Young <jerone.young@canonical.com>
> 
> The patch wasn't applicable straightforwardly (maybe another patch for
> Lenovo G is missing), but I fixed manually and applied now.
> 
> 
> Thanks,
> 
> Takashi
> 
> > 
> > diff --git a/pci/hda/patch_conexant.c b/pci/hda/patch_conexant.c
> > index c49030b..774edb9 100644
> > --- a/pci/hda/patch_conexant.c
> > +++ b/pci/hda/patch_conexant.c
> > @@ -3000,6 +3000,7 @@ static struct snd_pci_quirk cxt5066_cfg_tbl[] = {
> >  	SND_PCI_QUIRK(0x17aa, 0x3a0d, "ideapad", CXT5066_IDEAPAD),
> >  	SND_PCI_QUIRK(0x17aa, 0x215e, "Lenovo Thinkpad", CXT5066_THINKPAD),
> >  	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo G series", CXT5066_IDEAPAD),
> > +	SND_PCI_QUIRK(0x17aa, 0x3938, "Lenovo G series (AMD)", CXT5066_IDEAPAD),
> >  	{}
> >  };
> >  
> > 
> > 
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
