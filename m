From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usbaudio won't do 24-bit or 32-bit i/o...
Date: Sat, 21 Dec 2002 07:00:45 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E03930D.8040908@boosthardware.com>
References: <Pine.HPX.4.33n.0212051549290.19058-100000@studcom.urz.uni-halle.de>	<3DF0482E.8010109@boosthardware.com>	<s5hd6o5u6hw.wl@alsa2.suse.de>	<3DFB0C79.7010000@boosthardware.com>	<s5hvg1tswyq.wl@alsa2.suse.de>	<3DFE2295.2020502@boosthardware.com> <s5hlm2ou0k9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, iriXx <m@iriXx.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> hmmm, it seems that the problem is on usb-uhci driver.
> mysteriously, the midi part of quattro causes the kernel panic.  the
> audio part seems ok.
> you can avoid this either by using uhci driver or by commenting out
> the entry for quattro in alsa-kernel/usb/usbquirks.h.
> 

I am trying it out on my ohci machine too and the latest driver has 
fixed the problem with not being able to capture from all the input.

Thanks.

I have commented out the midi quirk though in alsa-kernel/usb/usbquirk.h

I will be saving this cvs for sure.

The 24_3le support in arecord still captures the left channel maxed and 
the right at normal volume on pcm0 and pcm1.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.NET email is sponsored by:  The Best Geek Holiday Gifts!
Time is running out!  Thinkgeek.com has the coolest gifts for
your favorite geek.   Let your fingers do the typing.   Visit Now.
T H I N K G E E K . C O M        http://www.thinkgeek.com/sf/
