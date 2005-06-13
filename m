From: Jeremy White <jwhite@codeweavers.com>
Subject: Re: RFC:  Appropriate device detection for Wine  (more
 advice needed)
Date: Sun, 12 Jun 2005 21:43:11 -0500
Message-ID: <42ACF2BF.5050603@codeweavers.com>
References: <42A519E9.2000103@codeweavers.com> <Pine.LNX.4.58.0506070930180.1752@pnote.perex-int.cz> <42A592BA.7050505@codeweavers.com> <Pine.LNX.4.58.0506071445070.1752@pnote.perex-int.cz> <42A5AE6A.2070204@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <42A5AE6A.2070204@codeweavers.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Okay,

So now I have a patch for Wine that very nicely
has Wine scanning for all cards and devices.  It
even probes for devices that behave badly
(e.g. my winmodem) and strips them out.

But I still have one device on my laptop;
card 0, device 4, that simply does not work
(see details below).

It seems to 'smell' right, but when data is
written to it, the buffer is never emptied.
Writing a sound file to it with aplay hangs
indefinitely; using pcm fills the sound buffer
and then blocks indefinitely.

So I'd like some advice:  Have I just been utterly
unrealistic in trying to scan for all PCM devices
on all cards?  Should I only report device 0 on each
card by default, and require the user to explicitly
request alternate devices?  Is there some way I can
detect that this device is psycho and automatically
strip it out?  What the heck is device 4 on my card?

Any/all advice appreciated.

Thanks,

Jeremy

p.s. Some details on sound card, let me know if more
is relevant:

releveant lspc -v snippet:


00000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
         Subsystem: Dell: Unknown device 011d
         Flags: bus master, medium devsel, latency 0, IRQ 7
         I/O ports at b800 [size=256]
         I/O ports at bc40 [size=64]
         Memory at f4fff800 (32-bit, non-prefetchable) [size=512]
         Memory at f4fff400 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2


jertop:/proc/asound/card0/pcm4p# cat /proc/asound/card0/pcm4p/info
card: 0
device: 4
subdevice: 0
stream: PLAYBACK
id: Intel ICH - IEC958
name: Intel 82801DB-ICH4 - IEC958
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 1



cat /proc/asound/devices
jertop:/# cat /proc/asound/devices
   0: [0- 0]: ctl
  20: [0- 4]: digital audio playback
  27: [0- 3]: digital audio capture
  26: [0- 2]: digital audio capture
  25: [0- 1]: digital audio capture
  16: [0- 0]: digital audio playback
  24: [0- 0]: digital audio capture
  33:       : timer
  32: [1- 0]: ctl
  48: [1- 0]: digital audio playback
  56: [1- 0]: digital audio capture


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
