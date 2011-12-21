From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda - add ALC889 quick id for Intel Los
 Lunas 2 desktop reference board
Date: Wed, 21 Dec 2011 15:23:14 +0800
Message-ID: <20111221072314.GA10669@localhost>
References: <20111221022020.GA20195@localhost> <s5hy5u6pgl3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 945AD1038CA
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 08:23:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy5u6pgl3.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 21, 2011 at 02:46:32PM +0800, Takashi Iwai wrote:
> At Wed, 21 Dec 2011 10:20:20 +0800,
> Wu Fengguang wrote:
> > 
> > Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
> 
> Do you really need this?

Yeah, the problem (now and future) is, our early hardware often have
broken BIOS that does not get the pin-config right.  However I
understand that it's not sane to continue expanding the quick code.

> I'm in the process removing all these model quirks.

Doesn't that risk introducing many regressions? What would be the
problem if we switch to the generic HDA driver for *new* boards and
leave the old working quicks/models untouched?

> Basically if the BIOS provides the right pin-config, it should work
> with the auto-parser.  If not, you can still provide the pin-config
> either statically or dynamically.

OK. Do you expect me to follow the example given by commit 2996bdbaa
("ALSA: hda - Remove ALC662 eeepc-p701 and ecs models")?

Thanks,
Fengguang

> > ---
> >  sound/pci/hda/alc882_quirks.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > --- linux.orig/sound/pci/hda/alc882_quirks.c	2011-12-20 14:16:51.880000058 +0800
> > +++ linux/sound/pci/hda/alc882_quirks.c	2011-12-20 14:16:58.740000115 +0800
> > @@ -2955,6 +2955,7 @@ static const struct snd_pci_quirk alc882
> >  	SND_PCI_QUIRK(0x8086, 0x0002, "DG33FBC", ALC883_3ST_6ch_INTEL),
> >  	SND_PCI_QUIRK(0x8086, 0x2503, "82801H", ALC883_MITAC),
> >  	SND_PCI_QUIRK(0x8086, 0x0022, "DX58SO", ALC889_INTEL),
> > +	SND_PCI_QUIRK(0x8086, 0x7270, "Intel Los Lunas 2", ALC889_INTEL),
> >  	SND_PCI_QUIRK(0x8086, 0x0021, "Intel IbexPeak", ALC889A_INTEL),
> >  	SND_PCI_QUIRK(0x8086, 0x3b56, "Intel IbexPeak", ALC889A_INTEL),
> >  	SND_PCI_QUIRK(0x8086, 0xd601, "D102GGC", ALC882_6ST_DIG),
> > 
