From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [ANN] Open Source US-X2Y firmware
Date: Tue, 20 Jul 2004 23:15:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040720211538.GA521@tuba.home>
References: <20040527192622.GA1966@tuba.home> <s5h3c5fsmd1.wl@alsa2.suse.de> <20040601175147.GA572@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20040601175147.GA572@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>, Karsten Wiese <annabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 01, 2004 at 07:51:48PM +0200, Martin Langer wrote:
> On Tue, Jun 01, 2004 at 10:39:38AM +0200, Takashi Iwai wrote:
> > At Thu, 27 May 2004 21:26:22 +0200,
> > Martin Langer wrote:
> > > 
> > > if someone is interested in a free (I mean GPL) firmware for the Tascam
> > > US-X2Y devices I can offer an open source replacement for the second stage 
> > > loader alsa-firmware/usx2yloader/tascam_loader.ihx. All three US-X2Y devices
> > > need this file. But I have only tried it out with an US-122 where it works.
> > > 
> > shall i include this into alsa-firmware?
> 
> In which way should it be included?
> - replacing the vendor fw file
> - as alternate fw, maybe with a configure option like 'prefer-free-fw' or so
> 
> Another point is that MidiSportLoader.ihx is 100% identical with
> tascam_loader.ihx. Maybe midisport devices work with this loader too. But I
> have no possibility to test it. Then it would be better to remove the ezusb
> stuff from usx2yloader and create a new chip specific tree for all ez-usb
> devices. Or not? 
> 
> > or should wait for a while until more debugging?
> 
> I guess some us224/midisport test would be nice. But on the other hand the
> loader core is built into the chip and my code is not much more than a few
> init lines.

Ok, now we know that us122, us224 and us428 are working.
So I vote for replacing tascam_loader.ihx :)

Apropos Midisport: What about a free midisport firmware package? A
combination of the gpl firmware by Lars Doelle and this loader. But perhaps
this loader fails for midisport devices --- it's still untested, it's just
an idea. On the other hand it looks like everybody is happy with the
alternate loader from http://usb-midi-fw.sf.net --- file it under $0.02 ;)


martin

-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
