From: Martin Langer <martin-langer@gmx.de>
Subject: Re: [ANN] Open Source US-X2Y firmware
Date: Tue, 27 Jul 2004 21:37:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040727193708.GA1085@tuba.home>
References: <20040527192622.GA1966@tuba.home> <s5h3c5fsmd1.wl@alsa2.suse.de> <20040601175147.GA572@tuba.home> <20040720211538.GA521@tuba.home> <s5h65895z0l.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h65895z0l.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Karsten Wiese <annabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 27, 2004 at 04:02:34PM +0200, Takashi Iwai wrote:
> At Tue, 20 Jul 2004 23:15:39 +0200,
> Martin Langer wrote:
> > 
> > On Tue, Jun 01, 2004 at 07:51:48PM +0200, Martin Langer wrote:
> > > On Tue, Jun 01, 2004 at 10:39:38AM +0200, Takashi Iwai wrote:
> > > > At Thu, 27 May 2004 21:26:22 +0200,
> > > > Martin Langer wrote:
> > > > > 
> > > > > if someone is interested in a free (I mean GPL) firmware for the Tascam
> > > > > US-X2Y devices I can offer an open source replacement for the second stage 
> > > > > loader alsa-firmware/usx2yloader/tascam_loader.ihx. All three US-X2Y devices
> > > > > need this file. But I have only tried it out with an US-122 where it works.
> > > > > 
> > > > shall i include this into alsa-firmware?
> > > 
> > > In which way should it be included?
> > > - replacing the vendor fw file
> > > - as alternate fw, maybe with a configure option like 'prefer-free-fw' or so
> > > 
> > > Another point is that MidiSportLoader.ihx is 100% identical with
> > > tascam_loader.ihx. Maybe midisport devices work with this loader too. But I
> > > have no possibility to test it. Then it would be better to remove the ezusb
> > > stuff from usx2yloader and create a new chip specific tree for all ez-usb
> > > devices. Or not? 
> > > 
> > > > or should wait for a while until more debugging?
> > > 
> > > I guess some us224/midisport test would be nice. But on the other hand the
> > > loader core is built into the chip and my code is not much more than a few
> > > init lines.
> > 
> > Ok, now we know that us122, us224 and us428 are working.
> > So I vote for replacing tascam_loader.ihx :)
> 
> Great.  Could you send a patch?

Sure. It's attached, but I'm still unsure: A patch for alsa-tools/usx2yloader
or alsa-firmware/usx2yloader? Is it divided by license or by loader/firmware
separation? I've choosen alsa-firmware/usx2yloader/src.

I guess many users will get trouble because they haven't yet installed a new 
version of as31 (v2.2). BTW, I haven't found any deb or rpm :(

Nevertheless the one and only as31 tarball I found is available here:
http://www.erazor-zone.de/ez/execute/explorer.php4?dir=..%2Fprojects%2Flinux%2Fas31%2F&view=small_icons

But it works!


martin


-- 
                                     Living on earth may be expensive,
                   but it includes an annual free trip around the sun. 

--GvXjxJ+pjyke8COw
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="usx2y-fw.patch.gz"
Content-Transfer-Encoding: base64

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

--GvXjxJ+pjyke8COw--


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
