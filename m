From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB audio devices
Date: Thu, 11 Mar 2004 09:13:17 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <404FAF1D.2040009@boosthardware.com>
References: <Pine.HPX.4.33n.0403091851500.4549-100000@studcom.urz.uni-halle.de> <Pine.LNX.4.58.0403101006120.28347@pnote.perex-int.cz> <s5hr7w1m43f.wl@alsa2.suse.de> <200403102104.49431.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> We can also vary the exact USB frame time.
> With UHCI 1.1 USB Hosts there is the SOF Register. 
> It is setable from 0 to 255, the default being 127.
> Using this SOF-Register, we can set the actual USB Frame Rate from 
> ((12000 - 127) / 12000)ms to ((12000 + 128) / 12000)ms. That is about -/+ 1%:
> More than enough to adjust the USB-Frame rate to let us get 44(44100) or 48
> (48000) Sample Frames everyy USB Frame.
> It really works here already with the us428: The trick is:
> We first make the USB-Frame longer until we capture 1 Sample Frame more  45 
> (for 44100). then the USB-Frame is shortened until we capture only 43 Sample 
> Frames for one USB Frame. and so on. 
> If we use a period size of multiples of 44 (for 44100) then :
> - Latency is almost at its best (only 1/44 less than optimal.
> - User Prog Scheduling Jitter is minimized.
> - Alsas keeps constant Period size.
> 

Hallaluhjah

Please please please make this standard for the usb audio driver.



-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
========================================


Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
