From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB audio devices
Date: Thu, 11 Mar 2004 09:09:18 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0403110859010.18812-100000@studcom.urz.uni-halle.de>
References: <200403102104.49431.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200403102104.49431.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
> We can also vary the exact USB frame time.
> With UHCI 1.1 USB Hosts there is the SOF Register.
> ...
> It really works here already with the us428: The trick is:
> We first make the USB-Frame longer until we capture 1 Sample Frame more  45
> (for 44100). then the USB-Frame is shortened until we capture only 43 Sample
> Frames for one USB Frame. and so on.

Cool idea!

However, standard-compliant devices are supposed to base their timing
for feedback/feedforward information on the arrival of SOF packets.
Introducing jitter into the SOF timer may not be a good idea in every
case.

And this won't work if there is more than one audio device connected
to the same bus, or if the HC is OHCI or EHCI.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
