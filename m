From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DigiDesign MBox USB Audio device
Date: Mon, 05 Apr 2004 18:00:01 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404051750110.25421-100000@studcom.urz.uni-halle.de>
References: <Pine.LNX.4.58.0404041840230.21649@pub2.ifh.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.58.0404041840230.21649@pub2.ifh.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Boettcher <patrick.boettcher@desy.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Boettcher wrote:
> I'm using a usbsnoop program to do some basic sniffing. Logs are
> really big :/.

Try to play some 0.01-seconds wave file, and don't connect any other
USB devices.

> After plugging in, the device shows like this in /proc/bus/usb/devices:
>
> I:  If#= 0 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#= 1 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> E:  Ad=81(I) Atr=05(Isoc) MxPS= 304 Ivl=1ms
> E:  Ad=02(O) Atr=05(Isoc) MxPS= 304 Ivl=1ms

Class 0xff means vendor-specific.  This is not a "USB Audio Device" as
defined in the USB specifications.

What sample rate/format uses 304000 bytes per second?

> After talking to some more experienced guys, I know, that there has to be
> a sound chip, so I opened the device and among some A/D and D/A converter
> I found a "cs8427" chip. I suppose this is the one.
> After looking into sound directory in linux, I saw "i2c/cs8427.c" and
> "i2c/cs8427.h".
>
> 1. How should a go on?

Output of "lsusb -v"?

> 2. Can I use somehow the i2c/cs8427.c?

Probably not.  The CS8427 will be connected (via I2C) to some USB
interface/controller chip.  Can you determine which one?

> 3. How does communication with the device should work?

Sending/receiving sample data should work, but I guess this device
needs vendor-specific commands to configure it.  These are control
transfers, not isochronous; please look in the log file for them.


HTH
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
