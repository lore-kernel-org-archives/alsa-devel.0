From: Trifon Trifonov <triffon@gmail.com>
Subject: Re: ALC880 driver
Date: Fri, 15 Dec 2006 08:55:08 +0100
Message-ID: <458254DC.4080306@gmail.com>
References: <200612150009.kBF09lEZ028693@turbo.physics.adelaide.edu.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070603070100000904060708"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200612150009.kBF09lEZ028693@turbo.physics.adelaide.edu.au>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Cc: Takashi Iwai <tiwai@suse.de>, PeiSen Hou <pshou@realtek.com.tw>, Kailang Yang <kailang@realtek.com.tw>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070603070100000904060708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jonathan Woithe:
> Hi Trifon
>
> [ Alsa-devel list added to CC ]
>
>   
>> I have a Realtek IntelHDA audio card using the ALC880 codec. I am 
>> runing Ubuntu Linux with kernel version 2.6.17-10.
>> When I first installed Ubuntu, it correctly recognised my card, but I 
>> could hear audio only through the right speaker. I looked in my kern.log 
>> and found a message that it is recognised as ALC880, but the vendor is 
>> unknown. I inspected the file patch_realtek.c for possible board config 
>> types and experimented with all of them. Some were not working at all, 
>> some were working again with only right speaker, some were working with 
>> both speakers, but microphone input is not working. Finally, I found 
>> that the W810 config is right for me -- everything is working stereo and 
>> also the input. I have no problems with the card, just wanted to share 
>> the knowledge so maybe you can add automatic detection for my type of 
>> card to work on the W810 config.
>> Please, write to me what kind of additional information do you need 
>> for that.
>>     
>
> Could you please provide the following information:
>
>  1) The make and model of your laptop
>   
I don't think this will help, because my laptop is not a very popular 
brand, it was assembled in Greece. But anyway, the brand is Turbo-X 
Coeus, model is G610P.
>  2) The output of the following commands:
>
>       lspci
>       lspci -nv
>
>     Depending on your system's configuration you may have to include the
>     full path when running lspci - for example, "/sbin/lspci".
>   
You forgot to mention that I have to sudo first to get all the info :) I 
attach the required files, hope they help.

Best,
  Trifon

--------------070603070100000904060708
Content-Type: text/plain;
 name="lspci.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci.txt"

00:00.0 Host bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express Memory Controller Hub (rev 03)
00:01.0 PCI bridge: Intel Corporation Mobile 945GM/PM/GMS/940GML and 945GT Express PCI Express Root Port (rev 03)
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller (rev 02)
00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 (rev 02)
00:1c.1 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 2 (rev 02)
00:1c.2 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 3 (rev 02)
00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev e2)
00:1f.0 ISA bridge: Intel Corporation 82801GBM (ICH7-M) LPC Interface Bridge (rev 02)
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial ATA Storage Controller IDE (rev 02)
00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 02)
01:00.0 VGA compatible controller: ATI Technologies Inc Unknown device 7145
03:00.0 Ethernet controller: Broadcom Corporation NetLink BCM5789 Gigabit Ethernet PCI Express (rev 11)
06:03.0 Network controller: Intel Corporation PRO/Wireless 2200BG Network Connection (rev 05)
06:07.0 FireWire (IEEE 1394): O2 Micro, Inc. Unknown device 00f7 (rev 02)
06:07.2 Class 0805: O2 Micro, Inc. Unknown device 7120 (rev 01)
06:07.3 Mass storage controller: O2 Micro, Inc. Unknown device 7130 (rev 01)

--------------070603070100000904060708
Content-Type: text/plain;
 name="lspci -nv.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci -nv.txt"

00:00.0 0600: 8086:27a0 (rev 03)
	Subsystem: 1019:0f69
	Flags: bus master, fast devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:01.0 0604: 8086:27a1 (rev 03)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000a000-0000cfff
	Memory behind bridge: ff300000-ff3fffff
	Prefetchable memory behind bridge: 00000000bdf00000-00000000dde00000
	Capabilities: [88] #0d [0000]
	Capabilities: [80] Power Management version 2
	Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [a0] Express Root Port (Slot+) IRQ 0

00:1b.0 0403: 8086:27d8 (rev 02)
	Subsystem: 1019:0f69
	Flags: bus master, fast devsel, latency 0, IRQ 58
	Memory at ffefc000 (64-bit, non-prefetchable) [size=16K]
	Capabilities: [50] Power Management version 2
	Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [70] Express Unknown type IRQ 0

00:1c.0 0604: 8086:27d0 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1c.1 0604: 8086:27d2 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	Memory behind bridge: ff400000-ff4fffff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1c.2 0604: 8086:27d4 (rev 02)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=05, sec-latency=0
	I/O behind bridge: 0000d000-0000dfff
	Capabilities: [40] Express Root Port (Slot+) IRQ 0
	Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 Enable+
	Capabilities: [90] #0d [0000]
	Capabilities: [a0] Power Management version 2

00:1d.0 0c03: 8086:27c8 (rev 02)
	Subsystem: 1019:0f69
	Flags: bus master, medium devsel, latency 0, IRQ 50
	I/O ports at ec00 [size=32]

00:1d.1 0c03: 8086:27c9 (rev 02)
	Subsystem: 1019:0f69
	Flags: bus master, medium devsel, latency 0, IRQ 58
	I/O ports at e880 [size=32]

00:1d.2 0c03: 8086:27ca (rev 02)
	Subsystem: 1019:0f69
	Flags: bus master, medium devsel, latency 0, IRQ 66
	I/O ports at e800 [size=32]

00:1d.3 0c03: 8086:27cb (rev 02)
	Subsystem: 1019:0f69
	Flags: bus master, medium devsel, latency 0, IRQ 74
	I/O ports at e480 [size=32]

00:1d.7 0c03: 8086:27cc (rev 02) (prog-if 20)
	Subsystem: 1019:0f69
	Flags: bus master, medium devsel, latency 0, IRQ 66
	Memory at ffefbc00 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Debug port

00:1e.0 0604: 8086:2448 (rev e2) (prog-if 01)
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=06, subordinate=07, sec-latency=32
	Memory behind bridge: ff500000-ffdfffff
	Prefetchable memory behind bridge: 00000000ddf00000-00000000dfe00000
	Capabilities: [50] #0d [0000]

00:1f.0 0601: 8086:27b9 (rev 02)
	Subsystem: 1019:0f69
	Flags: bus master, medium devsel, latency 0
	Capabilities: [e0] Vendor Specific Information

00:1f.2 0101: 8086:27c4 (rev 02) (prog-if 80)
	Subsystem: 1019:0f69
	Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 233
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at <unassigned>
	I/O ports at ffa0 [size=16]
	Capabilities: [70] Power Management version 2

00:1f.3 0c05: 8086:27da (rev 02)
	Subsystem: 1019:0f69
	Flags: medium devsel, IRQ 5
	I/O ports at 0400 [size=32]

01:00.0 0300: 1002:7145
	Subsystem: 1019:0f69
	Flags: bus master, fast devsel, latency 0, IRQ 169
	Memory at c0000000 (32-bit, prefetchable) [size=256M]
	I/O ports at c000 [size=256]
	Memory at ff3f0000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at ff3c0000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
	Capabilities: [58] Express Legacy Endpoint IRQ 0

03:00.0 0200: 14e4:169d (rev 11)
	Subsystem: 1019:0f58
	Flags: bus master, fast devsel, latency 0, IRQ 177
	Memory at ff4f0000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
	Capabilities: [d0] Express Endpoint IRQ 0

06:03.0 0280: 8086:4220 (rev 05)
	Subsystem: 8086:2702
	Flags: bus master, medium devsel, latency 64, IRQ 233
	Memory at ffdfe000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2

06:07.0 0c00: 1217:00f7 (rev 02) (prog-if 10)
	Subsystem: 1217:00f7
	Flags: bus master, medium devsel, latency 64, IRQ 169
	Memory at ff500000 (32-bit, non-prefetchable) [size=4K]
	Memory at ffdfc800 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [60] Power Management version 2

06:07.2 0805: 1217:7120 (rev 01)
	Subsystem: 0001:0000
	Flags: slow devsel, IRQ 169
	Memory at ffdfc400 (32-bit, non-prefetchable) [size=256]
	Capabilities: [a0] Power Management version 2

06:07.3 0180: 1217:7130 (rev 01)
	Subsystem: 0001:0000
	Flags: slow devsel, IRQ 10
	Memory at ffdff000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [a0] Power Management version 2


--------------070603070100000904060708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------070603070100000904060708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------070603070100000904060708--
