From: Jason Mancine <jason@mancine.net>
Subject: Re: Zoom R16
Date: Thu, 28 Nov 2013 09:50:07 -0500
Message-ID: <CAPrbH=v+fVMibUGC8FqBbW-Gd6NW7uZFCgq7fxw9hiaPGR_04g@mail.gmail.com>
References: <CAPrbH=vnQ-xXsRDoj30nra7hB_hDEaF6u3ov0XuDG_ZpFzb3bA@mail.gmail.com>
 <20131124130335.GA23126@tamtam.fritz.box>
 <CAPrbH=tGph7__rgx-5BsBSi9-E95FpsTL9Yy0zbum0TccTPbyQ@mail.gmail.com>
 <20131124141803.GC23126@tamtam.fritz.box>
 <CAPrbH=sA5ppp8z3bqdaDnk4U+DZ093ukXpDgiT6DEixGi1tdZA@mail.gmail.com>
 <CAPrbH=tu0jTctOAegkT7tnq1VSGOui4cESA2rYJFfgCa3=tQDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f49.google.com (mail-wg0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 0CBA42651A0
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 15:50:28 +0100 (CET)
Received: by mail-wg0-f49.google.com with SMTP id x12so8408276wgg.16
 for <alsa-devel@alsa-project.org>; Thu, 28 Nov 2013 06:50:27 -0800 (PST)
In-Reply-To: <CAPrbH=tu0jTctOAegkT7tnq1VSGOui4cESA2rYJFfgCa3=tQDg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Actually, after a few more tries it DOES work for capture... but fails on
playback just as it did with my original quirk.

Here are logs from a playback-only attempt.  Looks like there are some
packetsize errors and failing to set sample rate for playback

DMESG:

[  319.651037] usb 2-8: new high-speed USB device number 10 using ehci-pci
[  319.959768] usb 2-8: config 1 interface 3 altsetting 0 bulk endpoint 0x1
has invalid maxpacket 64
[  319.959773] usb 2-8: config 1 interface 3 altsetting 0 bulk endpoint
0x82 has invalid maxpacket 64
[  319.960512] usb 2-8: New USB device found, idVendor=1686, idProduct=00dd
[  319.960516] usb 2-8: New USB device strings: Mfr=1, Product=2,
SerialNumber=3
[  319.960519] usb 2-8: Product: R16
[  319.960522] usb 2-8: Manufacturer: ZOOM Corporation
[  319.960525] usb 2-8: SerialNumber: 0
[  319.961397] snd-usb-audio: probe of 2-8:1.0 failed with error -5
[  324.962217] 10:1:1: cannot get freq at ep 0x3
[  334.963237] 10:2:1: cannot get freq at ep 0x84
[  360.798326] 10:1:1: cannot get freq at ep 0x3
[  365.803274] 10:1:1: cannot set freq 96000 to ep 0x3
[  387.266266] 10:2:1: cannot get freq at ep 0x84
[  392.272214] 10:2:1: cannot get freq at ep 0x84
[  413.894325] 10:1:1: cannot get freq at ep 0x3
[  418.899271] 10:1:1: cannot set freq 96000 to ep 0x3



JACK LOG:

 loading driver ..

apparent rate = 96000

creating alsa driver ... -|hw:R16|1024|2|96000|8|0|nomon|swmeter|-|32bit

configuring for 96000Hz, period = 1024 frames (10.7 ms), buffer = 2 periods

ALSA: final selected sample format for capture: 32bit integer little-endian

ALSA: use 2 periods for capture

09:45:13.982 Server configuration saved to "/root/.jackdrc".

09:45:13.983 Statistics reset.

09:45:13.993 Client activated.

09:45:13.996 Buffer size change (0).

09:45:16.971 Buffer size change (1024).

09:45:16.972 JACK connection graph change.

09:45:16.997 JACK connection change.

09:45:28.900 Client deactivated.

09:45:28.903 JACK is stopping...

jack main caught signal 15

no message buffer overruns

09:45:33.936 JACK was stopped successfully.

09:45:38.539 JACK is starting...

09:45:38.539 /usr/bin/jackd -dalsa -dhw:R16 -r96000 -p1024 -n2 -P -o2

jackd 0.122.1

Copyright 2001-2009 Paul Davis, Stephane Letz, Jack O'Quinn, Torben Hohn
and others.

jackd comes with ABSOLUTELY NO WARRANTY

This is free software, and you are welcome to redistribute it

under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support.

09:45:38.570 JACK was started with PID=2919.

loading driver ..

apparent rate = 96000

creating alsa driver ... hw:R16|-|1024|2|96000|0|2|nomon|swmeter|-|32bit

configuring for 96000Hz, period = 1024 frames (10.7 ms), buffer = 2 periods

ALSA: final selected sample format for playback: 32bit integer little-endian

ALSA: use 2 periods for playback

09:45:40.660 Server configuration saved to "/root/.jackdrc".

09:45:40.661 Statistics reset.

09:45:40.671 Client activated.

09:45:40.674 Buffer size change (0).

09:45:43.600 Buffer size change (1024).

09:45:43.601 JACK connection graph change.

09:45:43.675 JACK connection change.

ALSA: prepare error for playback on "hw:R16" (Connection timed out)

DRIVER NT: could not start driver

cannot start driver

no message buffer overruns

09:45:48.627 Shutdown notification.

09:45:48.628 Client deactivated.

09:45:48.631 JACK is being forced...

cannot read server event (Success)

cannot continue execution of the processing graph (Bad file descriptor)

graph error - calling shutdown handler

09:45:48.831 JACK was stopped successfully.

Thanks



On Thu, Nov 28, 2013 at 9:42 AM, Jason Mancine <jason@mancine.net> wrote:

> I was able to compile 3.11.9 for AVLinux.  The quirk does not work, dmesg
> returns this:
>
> [   40.759383] usb 2-8: New USB device found, idVendor=1686, idProduct=00dd
> [   40.759387] usb 2-8: New USB device strings: Mfr=1, Product=2,
> SerialNumber=3
> [   40.759390] usb 2-8: Product: R16
> [   40.759393] usb 2-8: Manufacturer: ZOOM Corporation
> [   40.759396] usb 2-8: SerialNumber: 0
> [   40.760214] snd-usb-audio: probe of 2-8:1.0 failed with error -5
> [   45.760206] 6:1:1: cannot get freq at ep 0x3
> [   55.761231] 6:2:1: cannot get freq at ep 0x84
>
>
>
>
> On Tue, Nov 26, 2013 at 1:22 PM, Jason Mancine <jason@mancine.net> wrote:
>
>> Can't seem to compile 3.11 or 3.12 for the distro I am using (AVLInux)...
>> tested it in Ubuntu Studio 13.10 and the quirk didn't seem to have any
>> effect.  The output of lsusb is the same, but the device doesn't show up as
>> a sound card.
>>
>>
>> On Sun, Nov 24, 2013 at 9:18 AM, Daniel Mack <daniel@zonque.org> wrote:
>>
>>> On Sun, Nov 24, 2013 at 09:03:47AM -0500, Jason Mancine wrote:
>>> > Thanks, I will give it a try.  By recent kernel do you mean latest
>>> mainline
>>> > or should my distro's 3.6.11 be new enough?
>>>
>>> Anything >= 3.11 should do.
>>>
>>> In further replies, please do not drop the alsa-devel mailing list.
>>>
>>>
>>> Thanks,
>>> Daniel
>>>
>>
>>
>
