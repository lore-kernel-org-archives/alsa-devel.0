From: "Tomas 'Sleep_Walker' Cech" <sleep_walker@suse.cz>
Subject: AC97 reset fail after suspend
Date: Fri, 8 May 2009 01:48:19 +0200
Message-ID: <200905080148.20137.sleep_walker@suse.cz>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_EN3AKyRsxsrOHNO"
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: alsa-devel@alsa-project.org, Marek Vasut <marek.vasut@gmail.com>
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_EN3AKyRsxsrOHNO
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I've got following error on Palm LifeDrive and PalmTX after suspend & resume:

pxa2xx_ac97_try_warm_reset: warm reset timeout (GSR=0x0)
pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x0)
pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x44)
WM9712 AC97 reset failed
could not reset AC97 codec

That completely disable whole AC97 communication, so touchscreen, sound and 
battery doesn't work any longer.

I also tried this with Treo680 (code will be sent soon). HW is very similar, 
only codec is different - LD/T5/TX use WM9712, Treo680 use WM9713. On Treo680 
there is no problem with that.

Thanks for any hint about that.

Tomas 'Sleep_Walker' Cech

Attaching config for LD/TX and dmesg output.



--Boundary-00=_EN3AKyRsxsrOHNO
Content-Type: text/plain;
  charset="utf-8";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.30-rc3-TX.sw3 (tcech@daredevil) (gcc version 4.2.4) #246 Thu May 7 19:50:35 CEST 2009
CPU: XScale-PXA270 [69054117] revision 7 (ARMv5TE), cr=0000397f
CPU: VIVT data cache, VIVT instruction cache
Machine: Palm LifeDrive
Memory policy: ECC disabled, Data cache writeback
On node 0 totalpages: 8192
free_area_init_node: node 0, pgdat c0321ff4, node_mem_map c033f000
  Normal zone: 64 pages used for memmap
  Normal zone: 0 pages reserved
  Normal zone: 8128 pages, LIFO batch:0
Run Mode clock: 208.00MHz (*16)
Turbo Mode clock: 416.00MHz (*2.0, active)
Memory clock: 208.00MHz (/2)
System bus clock: 208.00MHz 
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 8128
Kernel command line: init=/sbin/init root=/dev/mmcblk0p2 psplash=false rootwait
NR_IRQS:192
PID hash table entries: 128 (order: 7, 512 bytes)
Console: colour dummy device 80x30
console [tty0] enabled
Dentry cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 2048 (order: 1, 8192 bytes)
Memory: 32MB = 32MB total
Memory: 29156KB available (2808K code, 252K data, 132K init, 0K highmem)
Calibrating delay loop... 415.33 BogoMIPS (lpj=2076672)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
net_namespace: 716 bytes
NET: Registered protocol family 16
bio: create slab <bio-0> at 0
cfg80211: Using static regulatory domain info
cfg80211: Regulatory domain: US
	(start_freq - end_freq @ bandwidth), (max_antenna_gain, max_eirp)
	(2402000 KHz - 2472000 KHz @ 40000 KHz), (600 mBi, 2700 mBm)
	(5170000 KHz - 5190000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5190000 KHz - 5210000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5210000 KHz - 5230000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5230000 KHz - 5330000 KHz @ 40000 KHz), (600 mBi, 2300 mBm)
	(5735000 KHz - 5835000 KHz @ 40000 KHz), (600 mBi, 3000 mBm)
cfg80211: Calling CRDA for country: US
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 1024 (order: 1, 8192 bytes)
TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
TCP: Hash tables configured (established 1024 bind 1024)
TCP reno registered
NET: Registered protocol family 1
PXA CPU 27x max frequency not defined (pxa27x_maxfreq), assuming pxa271 with 416000kHz maxfreq
PXA CPU frequency change support initialized
NetWinder Floating Point Emulator V0.97 (double precision)
squashfs: version 4.0 (2009/01/31) Phillip Lougher
msgmni has been set to 56
alg: No test for stdrng (krng)
io scheduler noop registered (default)
Console: switching to colour frame buffer device 53x43
pxa2xx-uart.0: ttyS0 at MMIO 0x40100000 (irq = 22) is a FFUART
pxa2xx-uart.1: ttyS1 at MMIO 0x40200000 (irq = 21) is a BTUART
pxa2xx-uart.2: ttyS2 at MMIO 0x40700000 (irq = 20) is a STUART
brd: module loaded
loop: module loaded
pxa2xx-pcmcia: use which platform_data?
pxa27x_udc: version 2008-04-18
g_ether gadget: using random self ethernet address
g_ether gadget: using random host ethernet address
usb0: MAC 3e:63:7e:d0:61:36
usb0: HOST MAC ba:45:a4:a0:15:95
g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
g_ether gadget: g_ether ready
mice: PS/2 mouse device common for all mice
input: pxa27x-keypad as /class/input/input0
input: gpio-keys as /class/input/input1
cpuidle: using governor ladder
palmld_mci_init: irq registered
Advanced Linux Sound Architecture Driver Version 1.0.19.
WM9711/WM9712 SoC Audio Codec 0.4
asoc: AC97 HiFi <-> pxa2xx-ac97 mapping ok
asoc: AC97 Aux <-> pxa2xx-ac97-aux mapping ok
wm97xx-ts 0-0:WM9712: detected a wm9712 codec
input: wm97xx touchscreen as /class/input/input2
ALSA device list:
  #0: Palm/PXA27x (WM9712)
TCP cubic registered
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
lib80211: common routines for IEEE802.11 drivers
lib80211_crypt: registered algorithm 'NULL'
XScale iWMMXt coprocessor detected.
Waiting for root device /dev/mmcblk0p2...
mmc0: new SD card at address 1147
mmcblk0: mmc0:1147 SK01G 945 MiB 
 mmcblk0: p1 p2 p3
VFS: Mounted root (ext2 filesystem) readonly on device 179:2.
Freeing init memory: 132K
pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
pcmcia 0.0: pcmcia: registering new device pcmcia0.0
Adding 94744k swap on /dev/mmcblk0p3.  Priority:-1 extents:1 across:94744k SS
ADDRCONF(NETDEV_UP): usb0: link is not ready
wm97xx-ts 0-0:WM9712: No IRQ specified
PM: Syncing filesystems ... done.
Freezing user space processes ... (elapsed 0.05 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
pxa2xx_ac97_try_warm_reset: warm reset timeout (GSR=0x0)
pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x0)
pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=0 GSR=0x44)
WM9712 AC97 reset failed
could not reset AC97 codec
pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=120 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=76 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=78 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=80 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=82 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=84 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=86 GSR=0x44)
Restarting tasks ... done.
pxa2xx_ac97_write: write error (ac97_reg=120 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=122 GSR=0x44)
wm97xx-ts 0-0:WM9712: No IRQ specified
pxa2xx_ac97_read: read error (ac97_reg=122 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_write: write error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)
pxa2xx_ac97_read: read error (ac97_reg=118 GSR=0x44)

--Boundary-00=_EN3AKyRsxsrOHNO
Content-Type: application/zip;
  charset="utf-8";
  name="config-TX.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config-TX.zip"

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

--Boundary-00=_EN3AKyRsxsrOHNO
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
--Boundary-00=_EN3AKyRsxsrOHNO--
