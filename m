From: "Bai Ao" <aobai@hotmail.com>
Subject: compaq presario laptop, via686a + AMD duron, sound not work
Date: Fri, 15 Feb 2002 03:31:47 +0000
Message-ID: <F113B3fJliVXjABbqGL0000842a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Received: from hotmail.com (f11.pav2.hotmail.com [64.4.37.11])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id EAA17734
	for <alsa-devel@alsa-project.org>; Fri, 15 Feb 2002 04:43:43 +0100
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

Hi, I have spend almost weeks on this but not luck. I have tried 
via82cxxx_audio.o which come from standard linux kernel and alsa via686a, 
but modules seems to load but give no sound.

when I try to load snd-card-via686a, it gaves out a poping noise just like 
speaker poweron, then nothing comes out if play something, no error message 
too. Is that an IRQ problem or EAPD problem? I have seen people talk about 
this identical laptop here but no further messages anymore. You help are 
greatly appreciated!

tried 2.4.18-pre9, 2.5.2-pre10, which are only two stable kernel run on my 
laptop. APM on, ACPI and APIC off. I am currently suspect that it is an IRQ 
problem since in my /var/log/messages:

Feb 15 22:22:03 on1vm kernel: Via 686a audio driver 1.9.1
Feb 15 22:22:03 on1vm kernel: PCI: Found IRQ 11 for device 00:07.5
Feb 15 22:22:03 on1vm kernel: IRQ routing conflict for 00:07.5, have irq 5, 
want irq 11
Feb 15 22:22:03 on1vm kernel: PCI: Sharing IRQ 11 with 00:0a.0
Feb 15 22:22:03 on1vm kernel: PCI: Sharing IRQ 11 with 00:0b.0
Feb 15 22:22:03 on1vm kernel: ac97_codec: AC97 Audio codec, id: 
0x4144:0x5361 (Unknown)
Feb 15 22:22:03 on1vm kernel: via82cxxx: board #1 at 0x1000, IRQ 5
Feb 15 22:23:42 on1vm kernel: PCI: Found IRQ 11 for device 00:07.5
Feb 15 22:23:42 on1vm kernel: IRQ routing conflict for 00:07.5, have irq 5, 
want irq 11
Feb 15 22:23:42 on1vm kernel: PCI: Sharing IRQ 11 with 00:0a.0
Feb 15 22:23:42 on1vm kernel: PCI: Sharing IRQ 11 with 00:0b.0


lspci

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 
80)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 42)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 Audio 
Controller (rev 50)
00:09.0 Communication controller: CONEXANT: Unknown device 2f00 (rev 01)
00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 
10)
01:00.0 VGA compatible controller: S3 Inc.: Unknown device 8d02 (rev 01)

lspci -v00:07.5 Multimedia audio controller: VIA Technologies, Inc. AC97 
Audio Controller (rev 50)
	Subsystem: Compaq Computer Corporation: Unknown device 0097
	Flags: medium devsel, IRQ 5
	I/O ports at 1000 [size=256]
	I/O ports at 1854 [size=4]
	I/O ports at 1850 [size=4]
	Capabilities: [c0] Power Management version 2
[root@on1vm sound]# modprobe via82cxxx_audio
[root@on1vm sound]# lsmod
Module                  Size  Used by
via82cxxx_audio        17728   0  (unused)
ac97_codec              9376   0  [via82cxxx_audio]
hsfbasic2              91824   2  (autoclean)
hsfserial              18144   0  (autoclean)
hsfengine             890820   0  (autoclean) [hsfserial]
hsfosspec              18320   0  (autoclean) [hsfbasic2 hsfengine]
apm                     9688   2
8139too                13792   1
mii                     1072   0  [8139too]
rtc                     6456   0  (autoclean)

cat /proc/interrupts
           CPU0
  0:     166863          XT-PIC  timer
  1:        870          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          0          XT-PIC  hsf
  5:         44          XT-PIC  via82cxxx
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci
11:      13175          XT-PIC  eth0
12:     289883          XT-PIC  PS/2 Mouse
14:      10484          XT-PIC  ide0
15:       6481          XT-PIC  ide1
NMI:          0
ERR:          0

[root@on1vm sound]# modprobe snd-card-via686a
[root@on1vm sound]# cat /proc/interrupts
           CPU0
  0:     173523          XT-PIC  timer
  1:       1082          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          0          XT-PIC  hsf
  5:         44          XT-PIC  VIA686A
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  usb-uhci
11:      14758          XT-PIC  eth0
12:     295936          XT-PIC  PS/2 Mouse
14:      10687          XT-PIC  ide0
15:       6910          XT-PIC  ide1
NMI:          0
ERR:          0






_________________________________________________________________
Chat with friends online, try MSN Messenger: http://messenger.msn.com


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
