From: Florian Schmidt <mista.tapas@gmx.net>
Subject: more pcm test program weirdness
Date: Thu, 22 Jan 2004 16:37:17 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040122163717.28f31f25.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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


Hi,

i tried the pcm test program from the alsa-lib test program and it fails
for quite a few transfer modes... Before i go into details on that i
have to say that everything else i use alsa for works very nicely:
playing music via xmms' alsa plugin; watching movies with mplayer and
the alsa9 output plugin; playing Enemy Territory via the OSS emu, etc..
I just checked the pcm test program out of curiosity..

The modes that do not work are: "write", "write_and_poll" and
"direct_write". All the other modes work [async, etc..]. "to work" in
this case means to produce audible output on my sepakers. Here's an
example output for the write method:


tapas@mango:~/source/build_stuff/sound/alsa-lib-1.0.1/test$ ./pcm 
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write

At this point it hangs, no output..  strace shows it hangs in an ioctl
[i ctrl-c'ed at the last ioctl() after some seconds]:

...
ioctl(4, 0x400c4150, 0xbffff6a0)        = 0
ioctl(4, 0x400c4150, 0xbffff6a0)        = 0
ioctl(4, 0x400c4150, 0xbffff6a0)        = 0
ioctl(4, 0x400c4150, 0xbffff6a0)        = 0
ioctl(4, 0x400c4150 <unfinished ...>


A bt in gdb shows:

(gdb) run
Starting program:
/home/tapas/source/build_stuff/sound/alsa-lib-1.0.1/test/pcm 
[New Thread 16384 (LWP 12912)]
Playback device is plughw:0,0
Stream parameters are 44100Hz, S16_LE, 1 channels
Sine wave rate is 440.0000Hz
Using transfer method: write

[here it hangs, so i ctrl-c'ed]

Program received signal SIGINT, Interrupt.
[Switching to Thread 16384 (LWP 12912)]
0x402140b4 in ioctl () from /lib/libc.so.6
(gdb) bt
#0  0x402140b4 in ioctl () from /lib/libc.so.6
#1  0x400627e7 in snd_pcm_hw_writei (pcm=0xfffffe00, buffer=0xfffffe00, 
    size=4294966784) at pcm_hw.c:609
#2  0x40052d77 in snd_pcm_writei (pcm=0xbffff640, buffer=0x8056718, 
    size=1074544976) at pcm_local.h:368
#3  0x08049ad7 in write_loop (handle=0x80565f8, samples=0x8056718, 
    areas=0x804d360) at pcm.c:219
#4  0x0804b271 in main (argc=1, argv=0xbffffb04) at pcm.c:835


jcdutton's speaker-test program shows the exact same behaviour, so he
suspected it's an alsa bug. Something along the line that writei()
should always work but fails to go to direct mode in this case or
something..


Here's some more info:

tapas@mango:~$ cat /proc/asound/cards 
0 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0xcffef000/0xcfe00000, irq 5
1 [VirMIDI        ]: VirMIDI - VirMIDI
                     Virtual MIDI Card 1

tapas@mango:~$ cat /proc/asound/devices 
  1:       : sequencer
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 18: [0- 2]: digital audio playback
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer
 32: [1- 0]: ctl
 43: [1- 3]: raw midi
 42: [1- 2]: raw midi
 41: [1- 1]: raw midi
 40: [1- 0]: raw midi


tapas@mango:~$ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.1.
Compiled on Jan 22 2004 for kernel 2.4.22 (SMP) with versioned symbols.

tapas@mango:~$ grep "VERSION_STR" /usr/include/alsa/version.h
#define SND_LIB_VERSION_STR     "1.0.1"

tapas@mango:~$ lspci 
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host (rev 01)
00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual
PCI-to-PCI bridge (AGP)
00:02.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513
00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev
d0)
00:03.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900
10/100 Ethernet (rev 90)
00:09.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974
[PCscsi] (rev 10)
00:11.0 Multimedia audio controller: Cirrus Logic CS 4614/22/24
[CrystalClear SoundFusion Audio Accelerator] (rev 01)
01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti
200] (rev a3)



tapas@mango:~$ sudo lspci -vn    
Password:
00:00.0 Class 0600: 1039:0735 (rev 01)
        Flags: bus master, medium devsel, latency 32
        Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0

00:01.0 Class 0604: 1039:0001
        Flags: bus master, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        Memory behind bridge: cdc00000-cfcfffff
        Prefetchable memory behind bridge: bd900000-cdafffff

00:02.0 Class 0601: 1039:0008
        Flags: bus master, medium devsel, latency 0

00:02.5 Class 0101: 1039:5513 (rev d0) (prog-if 80 [Master])
        Subsystem: 1039:5513
        Flags: bus master, fast devsel, latency 128
        I/O ports at ff00 [size=16]

00:03.0 Class 0200: 1039:0900 (rev 90)
        Subsystem: 1019:0a14
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at d800 [size=256]
        Memory at cffed000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at cffc0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2

00:09.0 Class 0100: 1022:2020 (rev 10)
        Flags: bus master, stepping, medium devsel, latency 64, IRQ 11
        I/O ports at dc00 [size=128]
        Expansion ROM at cfff0000 [disabled] [size=64K]

00:11.0 Class 0401: 1013:6003 (rev 01)
        Subsystem: 153b:112e
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at cffef000 (32-bit, non-prefetchable) [size=4K]
        Memory at cfe00000 (32-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 2

01:00.0 Class 0300: 10de:0201 (rev a3)
        Subsystem: 1462:8503
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 11
        Memory at ce000000 (32-bit, non-prefetchable) [size=16M]
        Memory at c0000000 (32-bit, prefetchable) [size=128M]
        Memory at cda80000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at cfcf0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 2.0



tapas@mango:~$ lsmod
Module                  Size  Used by    Tainted: P  
nvidia               1971456  14 (autoclean)
snd-virmidi             1408   0
snd-seq-virmidi         3480   0 [snd-virmidi]
snd-seq-midi-event      4096   0 [snd-seq-virmidi]
snd-pcm-oss            38180   0 (unused)
snd-cs46xx             72808   1
snd-pcm                66784   1 [snd-pcm-oss snd-cs46xx]
snd-page-alloc          6676   0 [snd-cs46xx snd-pcm]
snd-ac97-codec         48620   0 [snd-cs46xx]
snd-rawmidi            15328   0 [snd-seq-virmidi snd-cs46xx]
mousedev                4376   1
keybdev                 2084   0 (unused)
input                   3648   0 [mousedev keybdev]
snd-seq-dummy           1836   0 (unused)
snd-seq                41904   0 [snd-seq-virmidi snd-seq-midi-event
snd-seq-dummy]
snd-timer              16996   0 [snd-pcm snd-seq]
snd-seq-device          4404   0 [snd-rawmidi snd-seq]
sound                  61504   0 (unused)
snd-mixer-oss          13136   0 [snd-pcm-oss]
snd                    35588   0 [snd-virmidi snd-seq-virmidi
snd-seq-midi-event snd-pcm-oss snd-cs46xx snd-pcm snd-ac97-codec
snd-rawmidi snd-seq-dummy snd-seq snd-timer snd-seq-device
snd-mixer-oss]

TIA, flo
-- 
http://www.soundclick.com/bands/9/florianschmidt.htm
http://www.arted.biz/mista.tapas


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
