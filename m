From: Laurent Pinchart <laurent.pinchart@skynet.be>
Subject: Re: Very faint sound on Dell Latitude E6500
Date: Thu, 29 Jan 2009 14:27:49 +0100
Message-ID: <200901291427.50098.laurent.pinchart@skynet.be>
References: <200901271651.56181.laurent.pinchart@skynet.be>
	<200901290247.45669.laurent.pinchart@skynet.be>
	<s5hk58ea4ti.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AA0210386B
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 14:27:58 +0100 (CET)
In-Reply-To: <s5hk58ea4ti.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On Thursday 29 January 2009, Takashi Iwai wrote:
> At Thu, 29 Jan 2009 02:47:45 +0100, Laurent Pinchart wrote:
> > On Wednesday 28 January 2009, Takashi Iwai wrote:
> > > At Tue, 27 Jan 2009 16:51:56 +0100, Laurent Pinchart wrote:
> > > > Hi everybody,
> > > >
> > > > I've received a brand new Dell Latitude E6500 and found out that the
> > > > sound card wasn't exactly well supported by ALSA.
> > > >
> > > > Sound is barely audible (so faint that I'm not even sure if the
> > > > proper sound is output or if I just get garbage), with some loud
> > > > noise here and there that seem to correspond to the saturated audio
> > > > data  parts.
> > > >
> > > > The sound card is an HDA-Intel with an IDT 92HD71B7X codec. Hardware
> > > > information can be found at
> > > > http://www.alsa-project.org/db/?f=30cac30e5b1ddd9c842481a830c250cc3e5
> > > >93b0 d. A
> > >
> > > Please run with --no-upload and included the result in the post.
> >
> > Done, output included in this e-mail.
> >
> > > Anyway, this problem might be related with the volume-knob.
> > > Install hda-verb and try the following
> > >
> > > 	hda-verb /dev/snd/hwC0D0 0x28 SET_VOLUME_KNOB 0xff
> > > or
> > > 	hda-verb /dev/snd/hwC0D0 0x28 SET_VOLUME_KNOB 0
> >
> > Unfortunately none of those make a difference.
>
> After doing this, check /proc/asound/card0/codec* whether this node
> 0x28 is really changed.
>
> Then, try the latest alsa-driver snapshot from
>    
> ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-sna
>pshot.tar.gz
>
> This contains more fixes since 1.0.19.  It's generated from the GIT
> tree below:
>     git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
>    
> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git

I will test the snapshot this evening.

> Also, check the headphone output at first.  The speaker output needs
> more work than the headphone in general.

The headphone output works properly with the stock 2.6.28 kernel without 
having to mess with volume-knob. I haven't tested it with alsa-driver 1.0.19 
yet.

> You can also try to change the power-map by
> 	hda-verb /dev/snd/hwC0D0 1 0x7ec 0
> This is pretty specific to IDT codecs.

Thanks for your help.

Best regards,

Laurent Pinchart
