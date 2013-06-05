From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] ALSA: convert "snd_printk(KERN_INFO"
	to "pr_info("
Date: Tue, 04 Jun 2013 23:07:51 -0700
Message-ID: <1370412471.2385.105.camel@joe-AO722>
References: <s5h61xtx6i5.wl%tiwai@suse.de>
 <Pine.LNX.4.44L0.1306041315520.1093-100000@iolanthe.rowland.org>
 <s5hppw1rtnx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id 13EB02608E8
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 08:07:53 +0200 (CEST)
In-Reply-To: <s5hppw1rtnx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Alan Stern <stern@rowland.harvard.edu>
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-06-05 at 07:52 +0200, Takashi Iwai wrote:
> At Tue, 4 Jun 2013 13:20:40 -0400 (EDT),

> > --- usb-3.10.orig/sound/isa/opti9xx/miro.c
[]
> > -			snd_printk(KERN_INFO "unknown miro aci id\n");
> > +			pr_info("unknown miro aci id\n");
[]
> need proper prefix, and should be rather pr_warning().

pr_warn should be preferred over pr_warning
and most everything should have a
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
added.  Another option would be to add
ccflags-y += -D "pr_fmt(fmt)=KBUILD_MODNAME \": \" fmt" 
to the top level sound makefile.

Some eon son I'll actually submit this
https://lkml.org/lkml/2012/3/27/247
and most all of the #define pr_fmt(...
will be unncessary.

> > --- usb-3.10.orig/sound/pci/emu10k1/emu10k1x.c
[]
> >  #if 0
> > -	snd_printk(KERN_INFO "IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
> > +	pr_info("IRQ: position = 0x%x, period = 0x%x, size = 0x%x\n",
> >  		   epcm->substream->ops->pointer(epcm->substream),
> >  		   snd_pcm_lib_period_bytes(epcm->substream),
> >  		   snd_pcm_lib_buffer_bytes(epcm->substream));
> 
> Should be pr_debug().

Or the block deleted
