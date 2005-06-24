From: Colin Fletcher <colinf@axicon.com>
Subject: Re: [linux-usb-devel] Fw: BUG: Kernel panic when disconnecting
 Edirol USB2 audio interface
Date: Fri, 24 Jun 2005 10:35:36 +0100
Message-ID: <42BBD3E8.5070505@axicon.com>
References: <20050623024635.5b873305.akpm@osdl.org> <1119527109.42baa0c5df4ea@www.domainfactory-webmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1119527109.42baa0c5df4ea@www.domainfactory-webmail.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-usb-devel@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> You didn't mention that the device was currently playing/recording, so
> I assume it wasn't.  

Correct. Simply plugging in and unplugging the USB cable (or powering
the UA-1000 on and off) causes the oops every time.

> In this case, the oops apparently happens when the
> MIDI URBs are canceled (the MIDI input URBs are active as long as the
> driver is loaded).  Please try the attached patch; it adds two printk()s
> around the snd_usbmidi_disconnect() function.  If my theory is correct,
> the oops should happen immediately after the "killing MIDI URBs..."
> message.

I don't see the "killing MIDI URBs..." message at all.

> BTW: I never had the opportunity to test my code for the UA-1000.
> Does playback/capture/MIDI work?

jackd will connect to the UA-1000, at which point the 10 output state
LEDs on the front light up, and the output meter shows signals when I
play sound through it, but it's a bit unstable: it will stop working 
after a short while. I haven't investigated any further.


Colin Fletcher.

-- 



This email and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you have received this email in error please notify the system manager. This message contains confidential information and is intended only for the individual named. If you are not the named addressee you should not disseminate, distribute or copy this e-mail.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
