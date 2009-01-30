From: Laurent Pinchart <laurent.pinchart@skynet.be>
Subject: Re: Very faint sound on Dell Latitude E6500
Date: Fri, 30 Jan 2009 13:12:22 +0100
Message-ID: <200901301312.22243.laurent.pinchart@skynet.be>
References: <200901271651.56181.laurent.pinchart@skynet.be>
	<200901301238.57737.laurent.pinchart@skynet.be>
	<s5hbptprosk.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay010.isp.belgacom.be (mailrelay010.isp.belgacom.be
	[195.238.6.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 892831037FA
	for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2009 13:12:30 +0100 (CET)
In-Reply-To: <s5hbptprosk.wl%tiwai@suse.de>
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

On Friday 30 January 2009, Takashi Iwai wrote:
> At Fri, 30 Jan 2009 12:38:57 +0100,
>
> Laurent Pinchart wrote:
> > On Friday 30 January 2009, Takashi Iwai wrote:
> > > At Thu, 29 Jan 2009 22:33:19 +0100, Laurent Pinchart wrote:
> > > > On Thursday 29 January 2009, Takashi Iwai wrote:
> > > > > At Thu, 29 Jan 2009 02:47:45 +0100, Laurent Pinchart wrote:
> > > > > > On Wednesday 28 January 2009, Takashi Iwai wrote:
> > > > > > > At Tue, 27 Jan 2009 16:51:56 +0100, Laurent Pinchart wrote:
> > > > > > > > Hi everybody,
> > > > > > > >
> > > > > > > > I've received a brand new Dell Latitude E6500 and found out
> > > > > > > > that the sound card wasn't exactly well supported by ALSA.
> > > > > > > >
> > > > > > > > Sound is barely audible (so faint that I'm not even sure if
> > > > > > > > the proper sound is output or if I just get garbage), with
> > > > > > > > some loud noise here and there that seem to correspond to the
> > > > > > > > saturated audio data  parts.
> > > > > > > >
> > > > > > > > The sound card is an HDA-Intel with an IDT 92HD71B7X codec.
> > > > > > > > Hardware information can be found at
> > > > > > > > http://www.alsa-project.org/db/?f=30cac30e5b1ddd9c842481a830c
> > > > > > > >250c c3e5 93b0 d. A
> > > > > > >
> > > > > > > Please run with --no-upload and included the result in the
> > > > > > > post.
> > > > > >
> > > > > > Done, output included in this e-mail.
> > > > > >
> > > > > > > Anyway, this problem might be related with the volume-knob.
> > > > > > > Install hda-verb and try the following
> > > > > > >
> > > > > > > 	hda-verb /dev/snd/hwC0D0 0x28 SET_VOLUME_KNOB 0xff
> > > > > > > or
> > > > > > > 	hda-verb /dev/snd/hwC0D0 0x28 SET_VOLUME_KNOB 0
> > > > > >
> > > > > > Unfortunately none of those make a difference.
> > > > >
> > > > > After doing this, check /proc/asound/card0/codec* whether this node
> > > > > 0x28 is really changed.
> > > >
> > > > Yes it does (the range is 0x00-0x7f and not 0x00-0xff).
> > >
> > > The bit 7 is to specify the direct mode.
> > > Maybe we need to select the input of the widget beforehand:
> > >
> > > 	% hda-verb /dev/snd/hwC0D0 0x28 SET_CONN 1
> > > 	% hda-verb /dev/snd/hwC0D0 0x28 SET_VOLUME_KNOB 0xff
> >
> > I'm afraid it doesn't make any difference either.
>
> Did you check proc output and see any difference at all?

SET_VOLUME_KNOB changes the Volume Knob Widget's 'direct' and 'value' fields, 
but SET_CONN doesn't seem to have any effect.

Best regards,

Laurent Pinchart
