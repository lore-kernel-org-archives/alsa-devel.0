From: Martin Langer <martin-langer@gmx.de>
Subject: Re: 1.0.6rc1 packages
Date: Thu, 5 Aug 2004 21:52:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040805195259.GB509@tuba.home>
References: <32796.192.168.1.5.1091660025.squirrel@192.168.1.5> <26012.1091692137@www37.gmx.net> <59465.195.245.190.94.1091699072.squirrel@195.245.190.94>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (pop.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 2D52A215
	for <alsa-devel@alsa-project.org>; Thu,  5 Aug 2004 21:51:37 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <59465.195.245.190.94.1091699072.squirrel@195.245.190.94>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rui Nuno Capela <rncbc@rncbc.org>
Cc: alsa-devel@alsa-project.org, annabellesgarden@yahoo.de, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 05, 2004 at 10:44:32AM +0100, Rui Nuno Capela wrote:
> >
> >> Tomorrow I'll try on my dreaded laptop, Mdk10.0, 2.6.8-rc2 UP kernel,
> >> where recent snd-usb-usx2y it's known to freeze the whole system :(
> >>
> >> BTW, it's not a SMP vs. UP issue, as I've tested today on a SMP kernel
> >> with a very same config as of my other box, and the freezing result was
> >> the same.
> >
> > different usb controllers? Problems with non-UHCI?
> >
> 
> Probably. lspci -v gives:
> 
> 00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
> (prog-if 10 [OHCI])
> 	Subsystem: Hewlett-Packard Company: Unknown device 0850
> 	Flags: bus master, medium devsel, latency 64, IRQ 10
> 	Memory at d4000000 (32-bit, non-prefetchable) [size=4K]
> 	Capabilities: <available only to root>
> 
> so, it seems that is a non-UHCI system.

Yep. The same bug occurs on my OHCI Powerbook. It has to be an OHCI problem.
A simple "aplay xxx.wav" freezes the system. Only arecord runs fine. But you
already know the story.

But I have to downgrade alsa again for now. I need some working audio at the 
moment...


martin


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
