From: Simon Dixon <simon@oefai.at>
Subject: USB audio - Tascam US122
Date: Fri, 13 Aug 2004 15:04:35 +0200
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <411CBC63.2080508@oefai.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-usb-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm running Debian stable kernel version 2.4.24 with ALSA 1.0.5a and I'm trying 
to get a Tascam 122 USB audio/midi interface to work, but it doesn't seem to be 
able to load the firmware.  I can't work out if the problem is with USB or with 
ALSA.
  - usbview shows it as an unknown device (correct vendor/product# 1604/8006)
  - usx2yloader reports: no US-X2Y-compatible cards found


When I unplug and replug the box, /var/log/syslog adds:
Aug 13 13:22:34 jobim kernel: uhci.c: ef80: host controller halted. very bad
Aug 13 13:22:34 jobim kernel: usb.c: USB disconnect on device 00:1d.3-1 address 2
Aug 13 13:22:48 jobim kernel: hub.c: new USB device 00:1d.3-1, assigned address 3
Aug 13 13:22:48 jobim kernel: usb.c: USB device 3 (vend/prod 0x1604/0x8006) is 
not claimed by any active driver.
Aug 13 13:22:51 jobim /etc/hotplug/usb/tascam_fw: load 
/usr/local/share/alsa/firmware/usx2yloader/us122fw.ihx for 1604/8006/100 to 
/proc/bus/usb/004/003


But no lights ever come on on the box, and it remains an unknown device (#8006). 
I read somewhere that when the firmware loads, the device reconnects as #8007, 
so I assume that loading the firmware is where it fails.


When I strace usx2yloader I get:
<...>
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/hwC0D0", O_RDWR)         = -1 ENODEV (No such device)
open("/dev/snd/controlC0", O_RDONLY)    = 3
close(3)                                = 0
open("/dev/snd/hwC0D0", O_RDWR)         = -1 ENODEV (No such device)
stat64("/usr/share/alsa/alsa.conf", {st_mode=S_IFREG|0644, st_size=8007, ...}) = 0
open("/dev/snd/controlC1", O_RDONLY)    = -1 ENODEV (No such device)
open("/dev/aloadC1", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/hwC1D0", O_RDWR)         = -1 ENODEV (No such device)
open("/dev/snd/controlC1", O_RDONLY)    = -1 ENODEV (No such device)
open("/dev/aloadC1", O_RDONLY)          = -1 ENODEV (No such device)
open("/dev/snd/hwC1D0", O_RDWR)         = -1 ENODEV (No such device)
<... lots more similar output ...>

also syslog adds (6 times) - but only when I strace it:
Aug 13 13:33:43 jobim kernel: request_module[snd-card-1]: fork failed, errno 1


I'm not sure if I understand it right, but it seems that usx2yloader asks alsa 
for the sound cards, but alsa doesn't know about the soundcard until the 
firmware is loaded.  (/proc/asound only shows the intel8x0 card)

/etc/modules.conf contains:
alias char-major-116 snd
alias snd-card-1 snd-usb-usx2y
alias snd-card-0 snd-intel8x0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
alias sound-slot-0 snd-card-0
alias sound-slot-1 snd-card-1
alias sound-service-1-0 snd-mixer-oss
alias sound-service-1-3 snd-pcm-oss
alias sound-service-1-12 snd-pcm-oss
options snd major=116 cards_limit=2
options snd-card-0 index=0 enable_midi=1
options snd-card-1 index=1 enable_midi=1

Can anyone suggest what I might be doing wrong or what I can try next?


Thanks
Simon



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
