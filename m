From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: USB audio devices
Date: Wed, 10 Mar 2004 21:04:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403102104.49431.annabellesgarden@yahoo.de>
References: <Pine.HPX.4.33n.0403091851500.4549-100000@studcom.urz.uni-halle.de> <Pine.LNX.4.58.0403101006120.28347@pnote.perex-int.cz> <s5hr7w1m43f.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hr7w1m43f.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

We can also vary the exact USB frame time.
With UHCI 1.1 USB Hosts there is the SOF Register. 
It is setable from 0 to 255, the default being 127.
Using this SOF-Register, we can set the actual USB Frame Rate from 
((12000 - 127) / 12000)ms to ((12000 + 128) / 12000)ms. That is about -/+ 1%:
More than enough to adjust the USB-Frame rate to let us get 44(44100) or 48
(48000) Sample Frames everyy USB Frame.
It really works here already with the us428: The trick is:
We first make the USB-Frame longer until we capture 1 Sample Frame more  45 
(for 44100). then the USB-Frame is shortened until we capture only 43 Sample 
Frames for one USB Frame. and so on. 
If we use a period size of multiples of 44 (for 44100) then :
- Latency is almost at its best (only 1/44 less than optimal.
- User Prog Scheduling Jitter is minimized.
- Alsas keeps constant Period size.

cheers,
Karsten




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
