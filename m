From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: bugs in usb midi alsa code
Date: Wed, 06 Nov 2002 16:53:07 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211062150.WAA04935@alsa.alsa-project.org>
References: <Pine.LNX.4.44.0211060959140.1126-100000@cmn37.stanford.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA04935
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 22:50:42 +0100
In-reply-to: Your message of "Wed, 06 Nov 2002 10:18:56 PST."
             <Pine.LNX.4.44.0211060959140.1126-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> > ALSA:
>> >   cat /proc/asound/devices shows only one raw midi interface. This is on
>> >   a two port device (but Muse lets me select either port). On the older
>> >   alsa two devices show up on the listing.
>> 
>> For multiport interfaces, the additional ports are available as subdevices
>> of the rawmidi device, i.e. hw:1,0,0 and hw:1,0,1. (This is the same
>> behaviour as with other multiport interfaces, i.e. snd-mtpav and
>> snd-serial-u16550.)
>
>I understand the backwards compatibility bit, but it still looks wrong to
>me. AFAIK (maybe there are other uses) subdevices are only used in
>soundcard pcm outputs when the underlying hardware is capable of multiple
>opens on the same output port (hardware mixing). So the behavior of midi
>ports in inconsistent with the behavior of audio ports. They are two
>completely independent hardware i/o ports, it looks to me like they should
>be two devices, not one.

i'm with fernando on this one. if consistency is the goal, and i think
it should be, then multiport MIDI devices should appear as multiple
ports, not subdevices. 

--p


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
