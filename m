From: Rafal Dejewski <lardel@interia.pl>
Subject: Ali5451 on HP VT6200 notebook not working
Date: Thu, 21 Nov 2002 12:29:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211211230.00392.lardel@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I have HP vt6200 notebook. It has ALI5451 chip. I tried diffrent kernels 
2.4.18, 2.4.19, 2.4.20rc1, 2.5.48 and alsa-driver 0.9rc4,rc5,rc6.
The standard kernel trident module works OK on all kernels but alsa driver 
does not on any.
Before rc6 the snd-ali5451 module would just hang with "(initializing)" 
status. Now with rc6 or kernel 2.5.48 when I uncomment "#define ALI_DEBUG" 
this what dmesg is showing:
driver pci:ALI 5451: registering
kobject ALI 5451: registering
bus pci: add driver ALI 5451
probe ...
creating ...
PCI: IRQ 7 for device 00:04.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 7 for device 00:04.0
resouces allocation ...
resouces allocated.
snd_device_new is called.
chip initializing ...
ALSA sound/pci/ali5451/ali5451.c:2159: ali create: chip init error.

This is from /proc/pci:
 Bus  0, device   4, function  0:
    Multimedia audio controller: ALi Corporation M5451 PCI AC-Link Co (rev 2).
      IRQ 7.
      Master Capable.  Latency=64.  Min Gnt=2.Max Lat=24.
      I/O at 0x1000 [0x10ff].
      Non-prefetchable 32 bit memory at 0xe0001000 [0xe0001fff].



Is there anything I can do to get this thing working?

Rafal

----------------------------------------------------------------------
Portal INTERIA.PL zaprasza... >>> http://link.interia.pl/f167c 




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
