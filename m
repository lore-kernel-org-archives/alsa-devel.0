From: Anton Blanchard <anton@samba.org>
Subject: Re: Intel dg45id motherboard - ICH10 HD audio issues
Date: Wed, 22 Oct 2008 09:48:11 +1100
Message-ID: <20081021224811.GC1594@kryten>
References: <20080831012826.GA9900@kryten> <s5h63pg74uc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B00A24421
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 00:51:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h63pg74uc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi Takashi,

> > I was unable to get sound to work (analog or SPDIF) on my dg45id using
> > 2.6.27. After looking at the pinout information I made a quick hack to
> > get SPDIF out going (it's a mythtv box so thats all I need):
> > 
> > Index: linux-source-2.6.27/sound/pci/hda/patch_sigmatel.c
> > ===================================================================
> > --- linux-source-2.6.27.orig/sound/pci/hda/patch_sigmatel.c	2008-08-31 11:06:37.000000000 +1000
> > +++ linux-source-2.6.27/sound/pci/hda/patch_sigmatel.c	2008-08-31 11:07:14.000000000 +1000
> > @@ -3591,7 +3591,7 @@
> >  	spec->num_pwrs = ARRAY_SIZE(stac92hd73xx_pwr_nids);
> >  	spec->pwr_nids = stac92hd73xx_pwr_nids;
> >  
> > -	err = stac92xx_parse_auto_config(codec, 0x22, 0x24);
> > +	err = stac92xx_parse_auto_config(codec, 0x26, 0x24);
> >  
> >  	if (!err) {
> >  		if (spec->board_config < 0) {
> > 
> > And pointed mythtv at ALSA:plughw:0,1. Quick and dirty I know :)
> > 
> > Details of the chipset are below.
> 
> Thanks.  There seems two problems behind.
> 
> - the codec has two SPDIF outputs but the driver assumes only the
>   first one
> - the driver wrongly probes the pin widget instead of audio-out
>   widget
> 
> So, your patch fixes only the latter problem which is specific to your
> device.
> 
> Could you rewrite the patch to probe the pin first?  That is, check
> the availability of pin 0x22 and 0x23.  If one of them is available,
> pick the corresponding audio-out widget (0x25 and 0x26).

I'm going to need some help here, I have very little understanding of
ALSA. Could you give me a quick rundown on how to probe pins or point me
at an example in code?

Thanks,
Anton
