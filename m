From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: crashes usb-audio yamaha rp-u200
Date: Thu, 19 Feb 2004 13:24:25 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402191317140.2456-100000@studcom.urz.uni-halle.de>
References: <20040219121910.GA1725@kobux1.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20040219121910.GA1725@kobux1.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: jaap <jacobus@free.fr>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

jaap wrote:
> When I start jack with
>
> jackstart -d alsa -P hw:0,0 -C hw:0,1,
> jack seems to start ,but then the system freezes
> with kernel panic.Sometimes jack is running but then
> the system crashes as soon as I try to do something with audio
>
> alsa-driver 0.9.8

This is quite old.  Please try the latest version.

> Adhoc cc95e706 <[uhci]rh_int_timer_do+76/1e0>

Uh, this isn't ALSA, it's in the USB driver.  :-)
But this could be the async unlinking bug where ALSA was responsible
(this has been fixed recently).


HTH
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
