From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: bugs in usb midi alsa code
Date: Wed, 6 Nov 2002 18:10:30 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211061803000.1126-100000@cmn37.stanford.edu>
References: <Pine.LNX.4.33.0211062342220.573-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id DAA10831
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 03:11:04 +0100
In-Reply-To: <Pine.LNX.4.33.0211062342220.573-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > >> > ALSA:
> > >> >   cat /proc/asound/devices shows only one raw midi interface. This is on
> > >> >   a two port device (but Muse lets me select either port). On the older
> > >> >   alsa two devices show up on the listing.
> > >> 
> > >> For multiport interfaces, the additional ports are available as subdevices
> > >> of the rawmidi device, i.e. hw:1,0,0 and hw:1,0,1. (This is the same
> > >> behaviour as with other multiport interfaces, i.e. snd-mtpav and
> > >> snd-serial-u16550.)
> > >
> > >I understand the backwards compatibility bit, but it still looks wrong to
> > >me. AFAIK (maybe there are other uses) subdevices are only used in
> > >soundcard pcm outputs when the underlying hardware is capable of multiple
> > >opens on the same output port (hardware mixing). So the behavior of midi
> > >ports in inconsistent with the behavior of audio ports. 
> > 
> > i'm with fernando on this one. if consistency is the goal, and i think
> > it should be, then multiport MIDI devices should appear as multiple
> > ports, not subdevices. 
> 
> We have no minor numbers for direct addressing of tenths rawmidi devices.

That's really too bad. What does that address space look like at this
point and how is it used? (ie: what is it that is available?) Sorry for
the ignorance. Or is this related to allocation of new device numbers?  
(I seem to remember that at some point Linus, I think, sort of forbid to
add new ones).

Is it possible to at least to fix the behavior in the OSS world?  As it is
now, the only visible interface is the first one. 

-- Fernando



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
