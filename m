From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: bugs in usb midi alsa code
Date: Wed, 6 Nov 2002 13:04:10 -0800 (PST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0211061300520.1126-100000@cmn37.stanford.edu>
References: <Pine.LNX.4.44.0211060959140.1126-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from cm-mail.stanford.edu (cm-mail.Stanford.EDU [171.64.197.135])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA04321
	for <alsa-devel@alsa-project.org>; Wed, 6 Nov 2002 22:04:43 +0100
In-Reply-To: <Pine.LNX.4.44.0211060959140.1126-100000@cmn37.stanford.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> > > ALSA:
> > >   cat /proc/asound/devices shows only one raw midi interface. This is on
> > >   a two port device (but Muse lets me select either port). On the older
> > >   alsa two devices show up on the listing.
> > 
> > For multiport interfaces, the additional ports are available as subdevices
> > of the rawmidi device, i.e. hw:1,0,0 and hw:1,0,1. (This is the same
> > behaviour as with other multiport interfaces, i.e. snd-mtpav and
> > snd-serial-u16550.)
> 
> I understand the backwards compatibility bit, but it still looks wrong to
> me. [MUNCH]

But let me add (I should have said this explicitly before) that the
overall usb midi driver support is now MUCH better than before. Great
piece of work. Just missing (IMHO) a few details. 

-- Fernando



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
