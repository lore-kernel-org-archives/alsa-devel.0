From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: usb-audio Quattro
Date: Mon, 28 Jun 2004 09:24:40 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406280917270.22724-100000@studcom.urz.uni-halle.de>
References: <40DEF7E4.70700@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <40DEF7E4.70700@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> There is something very strange happening with the latest cvs code for
> the usb-audio driver.
>
> I've upgraded my music machine to demudi-1.1.0 which uses gcc-3.3 and
> installed a 2.4.26 kernel.
>
> The machine has the ohci interface.
>
> Unfortunately I encountered the following bugs:
>
> - input channels 1 and 3 are permanently maxed.

I thought the Quattro doesn't have any mixer controls?  Or what data
do you receive on this channels?

(I almost expect that you now get big-endian data on even-numbered
channels and little-endian data on odd-numbered channels.  ;-)

> - I cannot record stereo with two versions of arecord at the same time.
> - I cannot get access to all four channels at the same time via the
> route plugin (q4b).

What are the contents of /proc/asound/cardX/stream*?

> It's strange because the driver appeared to work very well on my main
> machine which has gcc-2.2, kernel-2.4.19, a uhci interface and the
> patched driver code from last weekend.

... and are there any differences to the streamX files on that
machine?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
