From: Josh Hattery <hobbz@dodds.net>
Subject: usb-audio problems (Extigy)
Date: Sun, 18 Aug 2002 16:48:39 -0500 (CDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.43.0208181625340.1161-100000@norad.dodds.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from norad.dodds.net (postfix@webmail.dodds.net [64.22.192.148])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id XAA08019
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 23:48:54 +0200
Received: from localhost (localhost [127.0.0.1])
	by norad.dodds.net (Postfix) with ESMTP id 002C032495C
	for <alsa-devel@alsa-project.org>; Sun, 18 Aug 2002 16:48:39 -0500 (CDT)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm having a few problems getting the Extigy to work using
alsa-driver-0.9.0rc3.  When I use aplay to play a .au file, it cuts off
the end of the file and gives the xrun message shown below.

I'm running Debian 3.0 using the 2.4.19-xfs kernel.

Here are a few symptoms I've found so far:

lsusb returns nothing and /proc/bus/usb is an empty directory (??).


-- aplay Receive.au
hobbz@graviton:~$ aplay .gaim/sounds/Receive.au
Playing Sparc Audio 'Receive.au' : Mu-Law, Rate 8012 Hz, Mono
xrun!!! (at least 0.208 ms long)
xrun!!! (at least 0.184 ms long)


-- xmms with alsa-xmms plugin:
hobbz@graviton:~$ xmms
xmms: simple.c:1370: snd_mixer_selem_get_playback_volume: Assertion
`(unsigned int) channel < s->str[0].channels' failed.
Aborted


-- dmesg:
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 17:00:17 Aug 18 2002
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xdc00, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe000, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xe400, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 3
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
XFS mounting filesystem ide0(3,1)
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 112k freed
hub.c: USB new device connect on bus1/1, assigned device number 2
input0,hiddev0: USB HID v1.10 Mouse [Logitech USB Mouse] on usb1:2.0
hub.c: USB new device connect on bus3/1, assigned device number 2
usb.c: USB device 2 (vend/prod 0x41e/0x3000) is not claimed by any active
driver.
Adding Swap: 498004k swap-space (priority -1)
usb.c: registered new driver snd-usb-audio
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:2 : unsupported format type 0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:3 : unsupported format type 0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:4 : unsupported format type 0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:5 : unsupported format type 0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:6 : unsupported format type 0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:7 : unsupported format type 0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:8 : unsupported format type 0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:9 : unsupported format type 0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:10 : unsupported format type
0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:11 : unsupported format type
0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:12 : unsupported format type
0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:13 : unsupported format type
0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:14 : unsupported format type
0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:15 : unsupported format type
0
ALSA ../alsa-kernel/usb/usbaudio.c:1433: 2:1:16 : unsupported format type
0
usb-uhci.c: interrupt, status 2, frame# 44
usb_control/bulk_msg: timeout
ALSA ../alsa-kernel/usb/usbmixer.c:998: cannot get min/max values for
proc/ext unit
usb_control/bulk_msg: timeout
ALSA ../alsa-kernel/usb/usbmixer.c:998: cannot get min/max values for
proc/ext unit
usb_control/bulk_msg: timeout
ALSA ../alsa-kernel/usb/usbmixer.c:998: cannot get min/max values for
proc/ext unit


-- lsmod:
Module                  Size  Used by    Tainted: P
NVdriver              988512  10  (autoclean)
snd-seq-oss            23168   0  (unused)
snd-seq-midi-event      3112   0  [snd-seq-oss]
snd-seq                37900   2  [snd-seq-oss snd-seq-midi-event]
snd-seq-device          3920   0  [snd-seq-oss snd-seq]
snd-pcm-oss            36772   0  (unused)
snd-mixer-oss           9120   0  [snd-pcm-oss]
snd-usb-audio          23648   0
snd-pcm                54784   0  [snd-pcm-oss snd-usb-audio]
snd-timer              10688   0  [snd-seq snd-pcm]
snd                    25192   0  [snd-seq-oss snd-seq-midi-event snd-seq
snd-seq-device snd-pcm-oss snd-mixer-oss snd-usb-audio snd-pcm snd-timer]
soundcore               3588   5  [snd]




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
