From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: bugs in usb midi alsa code
Date: Wed, 6 Nov 2002 23:43:47 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211062342220.573-100000@pnote.perex-int.cz>
References: <200211062150.WAA04935@alsa.alsa-project.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (root@gate.perex.cz [194.212.165.105])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA05683
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 23:46:49 +0100
In-Reply-To: <200211062150.WAA04935@alsa.alsa-project.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>, Clemens Ladisch <clemens@ladisch.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 6 Nov 2002, Paul Davis wrote:

> >> > ALSA:
> >> >   cat /proc/asound/devices shows only one raw midi interface. This is on
> >> >   a two port device (but Muse lets me select either port). On the older
> >> >   alsa two devices show up on the listing.
> >> 
> >> For multiport interfaces, the additional ports are available as subdevices
> >> of the rawmidi device, i.e. hw:1,0,0 and hw:1,0,1. (This is the same
> >> behaviour as with other multiport interfaces, i.e. snd-mtpav and
> >> snd-serial-u16550.)
> >
> >I understand the backwards compatibility bit, but it still looks wrong to
> >me. AFAIK (maybe there are other uses) subdevices are only used in
> >soundcard pcm outputs when the underlying hardware is capable of multiple
> >opens on the same output port (hardware mixing). So the behavior of midi
> >ports in inconsistent with the behavior of audio ports. They are two
> >completely independent hardware i/o ports, it looks to me like they should
> >be two devices, not one.
> 
> i'm with fernando on this one. if consistency is the goal, and i think
> it should be, then multiport MIDI devices should appear as multiple
> ports, not subdevices. 

We have no minor numbers for direct addressing of tenths rawmidi devices.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
