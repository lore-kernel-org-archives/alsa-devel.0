From: Francesco Rossi <franc@agbms.ch>
Subject: Re: ES1938 - ESS Solo1 - 3 Cards mounted
Date: 17 Sep 2002 21:39:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1032291542.12984.87.camel@franc.agbms.ch>
References: <E17rKNW-0000eB-00@usw-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E17rKNW-0000eB-00@usw-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Some more info, I finally ran into a kernel message:
CPU 0: Machine Check Exception: 0000000000000004
Bank 0: a200000084010400
Kernel panic: CPU context corrupt
In idle task - not syncing

I have actually modified my application not to use the OSS layer anymore
but to go directly with the ALSA APIs. The result is the same.
Since I was not completely sure about my software, I tried also using
the arecord from alsa-utils and the result hasn't changed.

I also started thinking about too much stuff passing through the bus but
it shouldn't be that a big deal. I haven't reached my need of 5 cards
yet. :-)

I have also tried to differenciate the IRQ configuration of the three
cards, at the beginning they were all on IRQ #9.

This is the configuration I am using when I am recording:

stream      : CAPTURE
access      : RW_INTERLEAVED
format      : S16_LE
subformat   : STD
channels    : 2
rate        : 44100
exact rate  : 44100 (793800/18)
msbits      : 16
buffer_size : 16320
period_size : 4080
period_time : 92517
tick_time   : 10000
tstamp_mode : NONE
period_step : 1
sleep_min   : 0
avail_min   : 4080
xfer_align  : 4080
start_threshold  : 1
stop_threshold   : 16320
silence_size: 0
boundary    : 2139095040


Any idea ?

Thanks in advance,
           Franc




> Subject: [Alsa-devel] ES1938 - ESS Solo1 - 3 Cards mounted
> 
> Hi,
> I have been running serious headaches since I am trying to mount 3 cards
> in one box running the latest stable kernel, I have tried with both alsa
> 0.5.12a and 0.9rc3 but still I am having the same kind of problem.
> 
> I am loading snd-pcm-oss and snd-mixer-oss
> I have patched the sound_core.c to fix the problem of devfs' /dev/sound
> so that now it generates the right device names.
> 
> When I start recording from the /dev/sound/dsp everything goes right,
> when I do it from /dev/sound/dsp1 or /dev/sound/dsp2 the machine is
> freezing without even a panic message.
> 
> I am attaching here the output of lspci -v
> 
> Is there anybody out there who can prevent me from having any further
> headache ?
> 
> Thank you very very much,
>           Franc
> 
> 
> 
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host
> Bridge (rev 03)
>         Subsystem: Asustek Computer, Inc.: Unknown device 8070
>         Flags: bus master, fast devsel, latency 0
>         Memory at f8000000 (32-bit, prefetchable) [size=64M]
>         Capabilities: <available only to root>
> 
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge
> (rev 03) (prog-if 00 [Normal decode])        Flags: bus master, 66Mhz,
> fast devsel, latency 64
>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
>         I/O behind bridge: 0000d000-0000dfff
>         Memory behind bridge: f3000000-f3dfffff
>         Prefetchable memory behind bridge: f3f00000-f7ffffff
> 
> 00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev
> 12) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0
>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
>         I/O behind bridge: 00006000-0000bfff
>         Memory behind bridge: f2800000-f2ffffff
>         Prefetchable memory behind bridge: f3e00000-f3efffff
> 
> 00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge
> (ICH2) (rev 12)
>         Flags: bus master, medium devsel, latency 0
> 
> 00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100
> (rev 12) (prog-if 80 [Master])
>         Subsystem: Asustek Computer, Inc.: Unknown device 8028
>         Flags: bus master, medium devsel, latency 0
>         [virtual] I/O ports at 01f0
>         [virtual] I/O ports at 03f4
>         [virtual] I/O ports at 0170
>         [virtual] I/O ports at 0374
>         I/O ports at 5800 [size=16]
> 
> 00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB
> (Hub A) (rev 12) (prog-if 00 [UHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 8028
>         Flags: bus master, medium devsel, latency 0, IRQ 5
>         I/O ports at 5400 [size=32]
> 
> 00:1f.4 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB
> (Hub B) (rev 12) (prog-if 00 [UHCI])
>         Subsystem: Asustek Computer, Inc.: Unknown device 8028
>         Flags: bus master, medium devsel, latency 0, IRQ 9
>         I/O ports at 5000 [size=32]
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF
> (prog-if 00 [VGA])
>         Subsystem: ATI Technologies Inc: Unknown device 5446
>         Flags: bus master, stepping, 66Mhz, medium devsel, latency 64,
> IRQ 11
>         Memory at f4000000 (32-bit, prefetchable) [size=64M]
>         I/O ports at d800 [size=256]
>         Memory at f3000000 (32-bit, non-prefetchable) [size=16K]
>         Expansion ROM at f3fe0000 [disabled] [size=128K]
>         Capabilities: <available only to root>
> 
> 02:09.0 Multimedia audio controller: ESS Technology ES1969 Solo-1
> Audiodrive (rev 02)
>         Subsystem: ESS Technology: Unknown device 8898
>         Flags: bus master, medium devsel, latency 32, IRQ 9
>         I/O ports at b800 [size=64]
>         I/O ports at b400 [size=16]
>         I/O ports at b000 [size=16]
>         I/O ports at a800 [size=4]
>         I/O ports at a400 [size=4]
>         Capabilities: <available only to root>
> 
> 02:0b.0 Multimedia audio controller: ESS Technology ES1969 Solo-1
> Audiodrive (rev 02)
>         Subsystem: ESS Technology: Unknown device 8898
>         Flags: bus master, medium devsel, latency 32, IRQ 9
>         I/O ports at a000 [size=64]
>         I/O ports at 9800 [size=16]
>         I/O ports at 9400 [size=16]
>         I/O ports at 9000 [size=4]
>         I/O ports at 8800 [size=4]
>         Capabilities: <available only to root>
> 
> 02:0c.0 Multimedia audio controller: ESS Technology ES1969 Solo-1
> Audiodrive (rev 02)
>         Subsystem: ESS Technology: Unknown device 8898
>         Flags: bus master, medium devsel, latency 32, IRQ 9
>         I/O ports at 8400 [size=64]
>         I/O ports at 8000 [size=16]
>         I/O ports at 7800 [size=16]
>         I/O ports at 7400 [size=4]
>         I/O ports at 7000 [size=4]
>         Capabilities: <available only to root>
> 
> 02:0e.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink]
> (rev 74)
>         Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
> Management NIC
>         Flags: bus master, medium devsel, latency 32, IRQ 10
>         I/O ports at 6800 [size=128]
>         Memory at f2800000 (32-bit, non-prefetchable) [size=128]
>         Expansion ROM at <unassigned> [disabled] [size=128K]
>         Capabilities: <available only to root>
> 
> 
> 
> 
> 
> 




-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
