From: thomas schorpp <t.schorpp@gmx.de>
Subject: snd-usb-audio hangs modprobe if switching dv camera betw. webcam
 / usb mass storage mode
Date: Sun, 31 Jul 2005 11:16:00 +0200
Message-ID: <42EC96D0.7050000@gmx.de>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

hello,

this bug is in conjunction with the older
"usb disconnect hangs keyboard" bug on lkml.

module-init-tools / hotplug hangs with snd-usb-audio if i switch/remove
usb camera as stated above, if  a client like kmix is attached.
(strange, since this device has no mixers here).

if its not unavoidable, pls fix soon, thx. vanilla kernel 2.6.12.0.

Jul 31 10:35:58 tom1 kernel: usb 1-2: USB disconnect, address 3
...
killall kmix
...

Jul 31 10:42:08 tom1 kernel: usb 1-2: new full speed USB device using
uhci_hcd and address 4
Jul 31 10:42:08 tom1 kernel:
/usr/src/spca5xx-20050701/drivers/usb/spca5xx.c: USB SPCA5XX camera
found. Aiptek DV3500 Mpeg4
Jul 31 10:42:08 tom1 kernel:
/usr/src/spca5xx-20050701/drivers/usb/spca5xx.c: [spca5xx_probe:8652]
Camera type JPEG
Jul 31 10:42:08 tom1 kernel: ALSA sound/usb/usbaudio.c:2570: 4:3:1: add
audio endpoint 0x86

y
tom


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
