From: noreply@alsa-project.org
Subject: [ALSA - driver 0000053]: Driver does not work with arts sound server
Date: Fri, 16 Jul 2004 13:04:26 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716110426.536C826008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B3006255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 13:04:26 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000053
======================================================================
Reported By:                nickallen
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     53
Category:                   PCI - intel8x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 1
Kernel Version:             2.4.22
======================================================================
Date Submitted:             02-12-2004 15:11 CET
Last Modified:              07-16-2004 13:04 CEST
======================================================================
Summary:                    Driver does not work with arts sound server
Description: 
The driver reports incorrect amount of data to be written to device
(usually 1 byte) so when artsd selects on the device it is woken up too
frequently and consumes all CPU power.
======================================================================

----------------------------------------------------------------------
 perex - 02-12-2004 16:35 CET 
----------------------------------------------------------------------
Your artsd is using native ALSA or OSS API?
Also, can you do 'cat /proc/interrupts' a few times during playback and
send results?

----------------------------------------------------------------------
 nickallen - 02-12-2004 17:03 CET 
----------------------------------------------------------------------
I have tried both with Arts (through OSS emulation on top of ALSA and
directly through ALSA). I get the same problem. It happens on about one
song in ten that I play. The cat below was captured when I was
experiencing the problem. It seems this bug is also acknowledged by the
Arts sound server on their web page
(http://www.arts-project.org/doc/handbook/faq.html). I have actually found
that when I use OSS drivers instead of ALSA the problem occurrs less
frequently but still occurrs. So it is a problem common to both drivers
for this chip.

Here is my interrupts. I cat /proc/interrupts  few times but they were all
the same (it never changed so I've only attached the output from one cat
here).

cat /proc/interrupts
           CPU0
  0:      75846          XT-PIC  timer
  1:        866          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:      13793          XT-PIC  Intel 82801DB-ICH4
  8:          1          XT-PIC  rtc
  9:         88          XT-PIC  acpi
 10:      42097          XT-PIC  usb-uhci, usb-uhci, ohci1394,
ndiswrapper, radeon@PCI:1:0:0
 11:      20511          XT-PIC  usb-uhci, ehci_hcd, eth0
 12:        121          XT-PIC  PS/2 Mouse
 14:      18207          XT-PIC  ide0
 15:          2          XT-PIC  ide1
NMI:          0
ERR:          0

----------------------------------------------------------------------
 perex - 02-12-2004 17:23 CET 
----------------------------------------------------------------------
Please, set artsd to use ALSA interface, play some sound and during
playback, send me contents of 'cat /proc/asound/card0/pcm0p/sub0/*'.

----------------------------------------------------------------------
 nickallen - 02-12-2004 19:30 CET 
----------------------------------------------------------------------
Here is the result of running cat /proc/asound/card0/pcm0p/sub0/* when not
experiencing the problem:
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 4096
buffer_size: 16384
tick_time: 10000
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: Intel ICH
name: Intel 82801DB-ICH4
subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
64
state: RUNNING
trigger_time: 1076610479.859149000
tstamp      : 1076610496.583490000
delay       : 12852
avail       : 3532
avail_max   : 4460
-----
hw_ptr      : 737740
appl_ptr    : 750592
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 4096
xfer_align: 4096
start_threshold: 1
stop_threshold: 16384
silence_threshold: 0
silence_size: 0
boundary: 1073741824

Here it is when experiencing the problem:
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 44100 (44100/1)
period_size: 4096
buffer_size: 16384
tick_time: 10000
card: 0
device: 0
subdevice: 0
stream: PLAYBACK
id: Intel ICH
name: Intel 82801DB-ICH4
subname: subdevice https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0
64
state: XRUN
trigger_time: 1076610586.365079000
tstamp      : 1076610592.497375000
delay       : 0
avail       : 18432
avail_max   : 0
-----
hw_ptr      : 4698112
appl_ptr    : 4696064
tstamp_mode: NONE
period_step: 1
sleep_min: 0
avail_min: 4096
xfer_align: 4096
start_threshold: 1
stop_threshold: 16384
silence_threshold: 0
silence_size: 0
boundary: 1073741824

----------------------------------------------------------------------
 nickallen - 02-12-2004 19:35 CET 
----------------------------------------------------------------------
I have actually found one song in my collection which always causes this
behaviour. Very strange that it can be related to a particular song as it
is normally pretty random when it occurrs. If you need me to send you the
song in order to reproduce then let me know. It is in ogg vorbis format
but is copyrighted so perhaps not a good idea?

----------------------------------------------------------------------
 perex - 02-17-2004 13:10 CET 
----------------------------------------------------------------------
Note that xrun state means that the application didn't deliver the new data
in time to driver, so driver interrupted stream.

It seems that your problem is that another task is CPU intensive. If you
use ALSA API, then the minimal count (avail_min threshold) specifies the
minimum frames to be written, so it's not same bug as with the OSS
interface emulation where the poll/select semantics should be changed.

----------------------------------------------------------------------
 nickallen - 02-17-2004 18:17 CET 
----------------------------------------------------------------------
I am running a CPU monitor and do not notice that the CPU is in much use
when the problem ocurrs. When I have the problem top reports low CPU usage
and then once problem starts CPU usage goes staright up to 100% with
arts.
Shuldn't the driver work under high cpu loads anyway? Is there anything I
can configure in the driver to prevent or reduce the chances of this
priblem occurring?

----------------------------------------------------------------------
 perex - 02-26-2004 12:16 CET 
----------------------------------------------------------------------
Can you test artsd with OSS emulation with the 1.0.3rc2 code?

----------------------------------------------------------------------
 nickallen - 02-26-2004 13:23 CET 
----------------------------------------------------------------------
I compiled and installed alsa 1.0.3rc2 and used OSS emulation in Artsd but
the problem is still there. I also tried using ALSA directly through arts
but it had the exact same problem.

----------------------------------------------------------------------
 perex - 02-29-2004 20:43 CET 
----------------------------------------------------------------------
Ok, a time to next test: 1.0.3 code is out.

Anyway, I tested artsd with i815 hardware and it is ok for the current
code, so
I suspect that the bug might be somewhere else. The select() behaviour is
definitely fixed in the ALSA's OSS emulation in kernel.

If you still have problems, please, compile 1.0.3a alsa-oss package, then
go to
alsa-oss/test directory. Run 'make osstest' and run this command in this
directory:

sh ./testaoss ./osstest -v -m mmap_and_select -M write

And, please, send me output.

----------------------------------------------------------------------
 nickallen - 03-01-2004 17:08 CET 
----------------------------------------------------------------------
I still have the same problem with 1.0.3. I've compiled the lastest drivers
and utils as you instructed as well as the test program. Here's the output
from the test program:

Using transfer method mmap_and_select
Device /dev/dsp opened sucessfully
Format set to 16
Rate set to 48000
Channels set to 2
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 16
ospace.bytes = 65536
mmap (out) returned 0x8062930
Trigger set to 00000000
Trigger set to 00000002
Select returned: 001
GETOPTR: Total: 000004140, Period: 001, Ptr: 004140
Select returned: 001
GETOPTR: Total: 000008564, Period: 002, Ptr: 008564
Select returned: 001
GETOPTR: Total: 000012388, Period: 003, Ptr: 012388
Select returned: 001
GETOPTR: Total: 000016420, Period: 004, Ptr: 016420
Select returned: 001
GETOPTR: Total: 000020484, Period: 005, Ptr: 020484
Select returned: 001
GETOPTR: Total: 000024580, Period: 006, Ptr: 024580
Select returned: 001
GETOPTR: Total: 000028680, Period: 007, Ptr: 028680
Select returned: 001
GETOPTR: Total: 000032776, Period: 008, Ptr: 032776
Select returned: 001
GETOPTR: Total: 000037272, Period: 009, Ptr: 037272
Select returned: 001
GETOPTR: Total: 000041052, Period: 010, Ptr: 041052
Select returned: 001
GETOPTR: Total: 000045064, Period: 011, Ptr: 045064
Select returned: 001
GETOPTR: Total: 000049156, Period: 012, Ptr: 049156
Select returned: 001
GETOPTR: Total: 000053252, Period: 013, Ptr: 053252
Select returned: 001
GETOPTR: Total: 000057348, Period: 014, Ptr: 057348
Select returned: 001
GETOPTR: Total: 000061444, Period: 015, Ptr: 061444
Select returned: 001
GETOPTR: Total: 000065856, Period: 016, Ptr: 000320
Select returned: 001
GETOPTR: Total: 000069676, Period: 017, Ptr: 004140
Select returned: 001
GETOPTR: Total: 000073736, Period: 018, Ptr: 008200
Select returned: 001
GETOPTR: Total: 000077828, Period: 019, Ptr: 012292
Select returned: 001
GETOPTR: Total: 000081924, Period: 020, Ptr: 016388
Select returned: 001
GETOPTR: Total: 000086020, Period: 021, Ptr: 020484
Select returned: 001
GETOPTR: Total: 000090116, Period: 022, Ptr: 024580
Select returned: 001
GETOPTR: Total: 000094212, Period: 023, Ptr: 028676
Select returned: 001
GETOPTR: Total: 000098384, Period: 024, Ptr: 032848
Select returned: 001
GETOPTR: Total: 000102404, Period: 025, Ptr: 036868
Select returned: 001
GETOPTR: Total: 000106500, Period: 026, Ptr: 040964
Select returned: 001
GETOPTR: Total: 000110596, Period: 027, Ptr: 045060
Select returned: 001
GETOPTR: Total: 000114692, Period: 028, Ptr: 049156
Select returned: 001
GETOPTR: Total: 000118788, Period: 029, Ptr: 053252
Select returned: 001
GETOPTR: Total: 000122884, Period: 030, Ptr: 057348
Select returned: 001
GETOPTR: Total: 000127336, Period: 031, Ptr: 061800
Select returned: 001
GETOPTR: Total: 000131076, Period: 032, Ptr: 000004
Select returned: 001
GETOPTR: Total: 000135172, Period: 033, Ptr: 004100
Select returned: 001
GETOPTR: Total: 000139268, Period: 034, Ptr: 008196
Select returned: 001
GETOPTR: Total: 000143364, Period: 035, Ptr: 012292
Select returned: 001
GETOPTR: Total: 000147460, Period: 036, Ptr: 016388
Select returned: 001
GETOPTR: Total: 000151556, Period: 037, Ptr: 020484
Select returned: 001
GETOPTR: Total: 000155652, Period: 038, Ptr: 024580
Select returned: 001
GETOPTR: Total: 000159820, Period: 039, Ptr: 028748
Select returned: 001
GETOPTR: Total: 000163844, Period: 040, Ptr: 032772

----------------------------------------------------------------------
 perex - 03-01-2004 17:11 CET 
----------------------------------------------------------------------
This is correct. Now try only:

./osstest -v -m mmap_and_select -M write

----------------------------------------------------------------------
 nickallen - 03-01-2004 18:35 CET 
----------------------------------------------------------------------
Here's the output from that last command:

Using transfer method mmap_and_select
Device /dev/dsp opened sucessfully
Format set to 16
Rate set to 48000
Channels set to 2
ospace.fragstotal = 16
ospace.fragsize = 4096
ospace.periods = 16
ospace.bytes = 65536
mmap (out) returned 0xbf559000
Trigger set to 00000000
Trigger set to 00000002
Select returned: 001
GETOPTR: Total: 000004132, Period: 001, Ptr: 004132
Select returned: 001
GETOPTR: Total: 000008228, Period: 002, Ptr: 008228
Select returned: 001
GETOPTR: Total: 000012616, Period: 003, Ptr: 012616
Select returned: 001
GETOPTR: Total: 000016456, Period: 004, Ptr: 016456
Select returned: 001
GETOPTR: Total: 000020512, Period: 005, Ptr: 020512
Select returned: 001
GETOPTR: Total: 000024608, Period: 006, Ptr: 024608
Select returned: 001
GETOPTR: Total: 000028676, Period: 007, Ptr: 028676
Select returned: 001
GETOPTR: Total: 000032772, Period: 008, Ptr: 032772
Select returned: 001
GETOPTR: Total: 000036868, Period: 009, Ptr: 036868
Select returned: 001
GETOPTR: Total: 000040964, Period: 010, Ptr: 040964
Select returned: 001
GETOPTR: Total: 000045232, Period: 011, Ptr: 045232
Select returned: 001
GETOPTR: Total: 000049156, Period: 012, Ptr: 049156
Select returned: 001
GETOPTR: Total: 000053252, Period: 013, Ptr: 053252
Select returned: 001
GETOPTR: Total: 000057348, Period: 014, Ptr: 057348
Select returned: 001
GETOPTR: Total: 000061444, Period: 015, Ptr: 061444
Select returned: 001
GETOPTR: Total: 000065540, Period: 016, Ptr: 000004
Select returned: 001
GETOPTR: Total: 000069636, Period: 017, Ptr: 004100
Select returned: 001
GETOPTR: Total: 000074024, Period: 018, Ptr: 008488
Select returned: 001
GETOPTR: Total: 000078024, Period: 019, Ptr: 012488
Select returned: 001
GETOPTR: Total: 000081924, Period: 020, Ptr: 016388
Select returned: 001
GETOPTR: Total: 000086020, Period: 021, Ptr: 020484
Select returned: 001
GETOPTR: Total: 000090116, Period: 022, Ptr: 024580
Select returned: 001
GETOPTR: Total: 000094212, Period: 023, Ptr: 028676
Select returned: 001
GETOPTR: Total: 000098308, Period: 024, Ptr: 032772
Select returned: 001
GETOPTR: Total: 000102404, Period: 025, Ptr: 036868
Select returned: 001
GETOPTR: Total: 000106628, Period: 026, Ptr: 041092
Select returned: 001
GETOPTR: Total: 000110596, Period: 027, Ptr: 045060
Select returned: 001
GETOPTR: Total: 000114692, Period: 028, Ptr: 049156
Select returned: 001
GETOPTR: Total: 000118788, Period: 029, Ptr: 053252
Select returned: 001
GETOPTR: Total: 000122884, Period: 030, Ptr: 057348
Select returned: 001
GETOPTR: Total: 000126980, Period: 031, Ptr: 061444
Select returned: 001
GETOPTR: Total: 000131080, Period: 032, Ptr: 000008
Select returned: 001
GETOPTR: Total: 000135440, Period: 033, Ptr: 004368
Select returned: 001
GETOPTR: Total: 000139276, Period: 034, Ptr: 008204
Select returned: 001
GETOPTR: Total: 000143364, Period: 035, Ptr: 012292
Select returned: 001
GETOPTR: Total: 000147460, Period: 036, Ptr: 016388
Select returned: 001
GETOPTR: Total: 000151556, Period: 037, Ptr: 020484
Select returned: 001
GETOPTR: Total: 000155652, Period: 038, Ptr: 024580
Select returned: 001
GETOPTR: Total: 000159748, Period: 039, Ptr: 028676
Select returned: 001
GETOPTR: Total: 000163844, Period: 040, Ptr: 032772

----------------------------------------------------------------------
 perex - 03-01-2004 18:38 CET 
----------------------------------------------------------------------
I'm out of ideas. It seems that ALSA is working correctly on your machine.
The osstest utility tests the select() call.

----------------------------------------------------------------------
 pestilence - 03-02-2004 10:22 CET 
----------------------------------------------------------------------
HI all,
I can confirm also that intel chipsets are experiencing problems with the
new Arts daemon.
I can hear sound through my speakers inside KDE but it is very crappy,
sound card is detected as it should be but it seems Arts is the problem.
I don't know if this is an Arts or an Alsa problem.
Some output from my xsession log:

ALSA lib pcm_hw.c:1056:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed:
Device or resource busy
kmix: ERROR: Alsa mixer cannot be found.
Please check that the soundcard is installed and the
soundcard driver is loaded.
kmix:

----------------------------------------------------------------------
 vda - 03-08-2004 13:43 CET 
----------------------------------------------------------------------
I came here from bug https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000124.
Is there broken-down ALSA patches for 2.6.2-bk2 -> 2.6.3-rc1 anywhere?
I will narrow it down.

----------------------------------------------------------------------
 vda - 03-08-2004 15:06 CET 
----------------------------------------------------------------------
I dug a bit deeper and instrumented pcm_oss.c
I'm new to ALSA but maybe this will be of use
to somebody.

2.6.2-bk2 log:
bytes=40960,frags=10,fragstotal=10,fragsz=4096,avail=-1014259824,path=1
last message repeated 2 times
bytes=22220,frags=5,fragstotal=10,fragsz=4096,avail=5555,path=4
bytes=18172,frags=4,fragstotal=10,fragsz=4096,avail=4543,path=4
bytes=14092,frags=3,fragstotal=10,fragsz=4096,avail=3523,path=4
bytes=10012,frags=2,fragstotal=10,fragsz=4096,avail=2503,path=4
bytes=5932,frags=1,fragstotal=10,fragsz=4096,avail=1483,path=4
bytes=4136,frags=1,fragstotal=10,fragsz=4096,avail=1034,path=4
bytes=4140,frags=1,fragstotal=10,fragsz=4096,avail=1035,path=4
bytes=4132,frags=1,fragstotal=10,fragsz=4096,avail=1033,path=4
bytes=4136,frags=1,fragstotal=10,fragsz=4096,avail=1034,path=4
last message repeated 4 times
bytes=4140,frags=1,fragstotal=10,fragsz=4096,avail=1035,path=4
bytes=4136,frags=1,fragstotal=10,fragsz=4096,avail=1034,path=4
bytes=27092,frags=6,fragstotal=10,fragsz=4096,avail=6773,path=4
bytes=23064,frags=5,fragstotal=10,fragsz=4096,avail=5766,path=4
bytes=19016,frags=4,fragstotal=10,fragsz=4096,avail=4754,path=4
bytes=16296,frags=3,fragstotal=10,fragsz=4096,avail=4074,path=4
bytes=12636,frags=3,fragstotal=10,fragsz=4096,avail=3159,path=4
bytes=8604,frags=2,fragstotal=10,fragsz=4096,avail=2151,path=4
bytes=4564,frags=1,fragstotal=10,fragsz=4096,avail=1141,path=4
bytes=4232,frags=1,fragstotal=10,fragsz=4096,avail=1058,path=4
bytes=4180,frags=1,fragstotal=10,fragsz=4096,avail=1045,path=4
bytes=4968,frags=1,fragstotal=10,fragsz=4096,avail=1242,path=4
bytes=4176,frags=1,fragstotal=10,fragsz=4096,avail=1044,path=4
bytes=4232,frags=1,fragstotal=10,fragsz=4096,avail=1058,path=4
bytes=4184,frags=1,fragstotal=10,fragsz=4096,avail=1046,path=4
bytes=4176,frags=1,fragstotal=10,fragsz=4096,avail=1044,path=4
bytes=4168,frags=1,fragstotal=10,fragsz=4096,avail=1042,path=4
bytes=8488,frags=2,fragstotal=10,fragsz=4096,avail=2122,path=4
bytes=4468,frags=1,fragstotal=10,fragsz=4096,avail=1117,path=4
bytes=4180,frags=1,fragstotal=10,fragsz=4096,avail=1045,path=4
bytes=4184,frags=1,fragstotal=10,fragsz=4096,avail=1046,path=4
bytes=4808,frags=1,fragstotal=10,fragsz=4096,avail=1202,path=4
bytes=4192,frags=1,fragstotal=10,fragsz=4096,avail=1048,path=4
bytes=4196,frags=1,fragstotal=10,fragsz=4096,avail=1049,path=4
bytes=4180,frags=1,fragstotal=10,fragsz=4096,avail=1045,path=4
bytes=5776,frags=1,fragstotal=10,fragsz=4096,avail=1444,path=4
bytes=4188,frags=1,fragstotal=10,fragsz=4096,avail=1047,path=4
bytes=4180,frags=1,fragstotal=10,fragsz=4096,avail=1045,path=4
bytes=4180,frags=1,fragstotal=10,fragsz=4096,avail=1045,path=4
bytes=7372,frags=1,fragstotal=10,fragsz=4096,avail=1843,path=4
bytes=4184,frags=1,fragstotal=10,fragsz=4096,avail=1046,path=4
bytes=4184,frags=1,fragstotal=10,fragsz=4096,avail=1046,path=4
bytes=4288,frags=1,fragstotal=10,fragsz=4096,avail=1072,path=4
bytes=21944,frags=5,fragstotal=10,fragsz=4096,avail=5486,path=4
bytes=17928,frags=4,fragstotal=10,fragsz=4096,avail=4482,path=4
...

2.6.3-rc1 log:
...
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3120,avail=781,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3124,avail=782,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3128,avail=783,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3132,avail=784,path=4
bytes=0,frags=0,fragstotal=10,fragsz=4096,fixup=-3136,avail=784,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3136,avail=785,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3140,avail=786,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3144,avail=787,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3148,avail=788,path=4
bytes=0,frags=0,fragstotal=10,fragsz=4096,fixup=-3152,avail=788,path=4
bytes=0,frags=0,fragstotal=10,fragsz=4096,fixup=-3152,avail=788,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3152,avail=789,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3156,avail=790,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3160,avail=791,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3164,avail=792,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3168,avail=793,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3172,avail=794,path=4
bytes=4,frags=0,fragstotal=10,fragsz=4096,fixup=-3176,avail=795,path=4
...

Code:

linux-2.6.2-bk2/sound/core/oss/pcm_oss.c
========================================
static int snd_pcm_oss_get_space(snd_pcm_oss_file_t *pcm_oss_file, int
stream, struct audio_buf_info *_info)
{
	snd_pcm_substream_t *substream;
	snd_pcm_runtime_t *runtime;
	snd_pcm_sframes_t avail;
	struct audio_buf_info info;
	int err;
int path;

	if (_info == NULL)
		return -EFAULT;
	substream = pcm_oss_file->streams[stream];
	if (substream == NULL)
		return -EINVAL;
	runtime = substream->runtime;

	if (runtime->oss.params &&
	    (err = snd_pcm_oss_change_params(substream)) < 0)
		return err;

	info.fragsize = runtime->oss.period_bytes;
	info.fragstotal = runtime->periods;
	if (runtime->oss.prepare) {
		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
			info.bytes = runtime->oss.period_bytes * runtime->periods;
			info.fragments = runtime->periods;
path=1;
		} else {
			info.bytes = 0;
			info.fragments = 0;
path=2;
		}
	} else {
		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
			err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DELAY, &avail);
			if (err == -EPIPE || err == -ESTRPIPE) {
				avail = runtime->buffer_size;
				err = 0;
path=3;
			} else {
				avail = runtime->buffer_size - avail;
path=4;
			}
		} else {
			err = snd_pcm_oss_capture_position_fixup(substream, &avail);
path=5;
		}
		if (err < 0)
			return err;
		info.bytes = snd_pcm_oss_bytes(substream, avail);
		info.fragments = avail / runtime->period_size;
	}

//#ifdef OSS_DEBUG //vda: commented this out
        printk("pcm_oss: space:
bytes=%i,frags=%i,fragstotal=%i,fragsz=%i,avail=%i,path=%i\n",
		info.bytes, info.fragments, info.fragstotal, info.fragsize, (int)avail,
path
	);
//#endif
	if (copy_to_user(_info, &info, sizeof(info)))
		return -EFAULT;
	return 0;
}


linux-2.6.3-rc1/sound/core/oss/pcm_oss.c
========================================
static int snd_pcm_oss_get_space(snd_pcm_oss_file_t *pcm_oss_file, int
stream, struct audio_buf_info *_info)
{
	snd_pcm_substream_t *substream;
	snd_pcm_runtime_t *runtime;
	snd_pcm_sframes_t avail;
	int fixup;
	struct audio_buf_info info;
	int err;
int path;

	if (_info == NULL)
		return -EFAULT;
	substream = pcm_oss_file->streams[stream];
	if (substream == NULL)
		return -EINVAL;
	runtime = substream->runtime;

	if (runtime->oss.params &&
	    (err = snd_pcm_oss_change_params(substream)) < 0)
		return err;

	info.fragsize = runtime->oss.period_bytes;
	info.fragstotal = runtime->periods;
	if (runtime->oss.prepare) {
		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
			info.bytes = runtime->oss.period_bytes * runtime->oss.periods;
			info.fragments = runtime->oss.periods;
path = 1;
		} else {
			info.bytes = 0;
			info.fragments = 0;
path = 2;
		}
	} else {
		if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
			err = snd_pcm_kernel_ioctl(substream, SNDRV_PCM_IOCTL_DELAY, &avail);
			if (err == -EPIPE || err == -ESTRPIPE || (! err && avail < 0)) {
				avail = runtime->buffer_size;
				err = 0;
				fixup = 0;
path = 3;
			} else {
				avail = runtime->buffer_size - avail;
				fixup = -runtime->oss.buffer_used;
path = 4;
			}
		} else {
			err = snd_pcm_oss_capture_position_fixup(substream, &avail);
			fixup = runtime->oss.buffer_used;
path = 5;
		}
		if (err < 0)
			return err;
		info.bytes = snd_pcm_oss_bytes(substream, avail) + fixup;
		info.fragments = info.bytes / runtime->oss.period_bytes;
	}

//#ifdef OSS_DEBUG //vda: commented this out
	printk("pcm_oss: space:
bytes=%i,frags=%i,fragstotal=%i,fragsz=%i,fixup=%i,avail=%i,path=%i\n",
		info.bytes, info.fragments, info.fragstotal, info.fragsize, fixup,
(int)avail, path
	);
//#endif
	if (copy_to_user(_info, &info, sizeof(info)))
		return -EFAULT;
	return 0;
}

----------------------------------------------------------------------
 vda - 03-08-2004 18:10 CET 
----------------------------------------------------------------------
If I replace
    info.bytes = snd_pcm_oss_bytes(substream, avail) + fixup;
with
    info.bytes = snd_pcm_oss_bytes(substream, avail);
CPU hogging is gone but sound plays a bit fast, say, 3/2 of normal.

----------------------------------------------------------------------
 perex - 03-09-2004 10:49 CET 
----------------------------------------------------------------------
To vda: I think that this bug is solved in 1.0.3 code (compile driver
outside
the kernel tree) or use latest patch from
ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-03-01.patch.gz
.
It's related to the select/poll usage.

----------------------------------------------------------------------
 nickallen - 04-12-2004 13:27 CEST 
----------------------------------------------------------------------
Downloaded and compiled alsa 1.0.4 and this bug is still present. Is there
anyway I can help? Have you been able to reproduce the bug yet? I can
reproduce it every time. Perhaps I can build artsd in debug mode and
figure out what's going on. 
Willing to do whatever it takes because it is a really annoying bug for me
(Basically I can never listen to music on my laptop and must turn off all
KDE sounds). The really annoying thing is that it works most of the time
and is sporadic.
I am an app developer rather than a low level driver developer but I am a
professional programmer so if you need me to do something to help you
track down the cause let me know...

----------------------------------------------------------------------
 vda - 04-12-2004 13:38 CEST 
----------------------------------------------------------------------
Does not happen to me anymore in 2.6.5

----------------------------------------------------------------------
 nickallen - 04-14-2004 23:54 CEST 
----------------------------------------------------------------------
I just upgraded my entire system using apt-get for fedora and kde-redhat
and now the problem no longer seems to be present. I noticed arts was
upgraded as well as alsa so not sure which package actually fixed it.
Anyway this bug seems fixed for me ;-)

----------------------------------------------------------------------
 perex - 04-15-2004 20:08 CEST 
----------------------------------------------------------------------
Appearently, the problem is fixed with the recent code.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-12-04 15:11 nickallen      New Bug                                      
02-12-04 15:11 nickallen      Bug Monitored: nickallen                     
02-12-04 16:33 perex          Assigned To               => perex           
02-12-04 16:33 perex          Status                   new => assigned     
02-12-04 16:35 perex          Bugnote Added: 0000227                       
02-12-04 16:36 perex          Category                 CORE - control => PCI - intel8x0
02-12-04 17:03 nickallen      Bugnote Added: 0000229                       
02-12-04 17:23 perex          Bugnote Added: 0000230                       
02-12-04 19:30 nickallen      Bugnote Added: 0000232                       
02-12-04 19:35 nickallen      Bugnote Added: 0000233                       
02-17-04 13:10 perex          Bugnote Added: 0000250                       
02-17-04 14:58 szucsg         Bugnote Added: 0000251                       
02-17-04 18:17 nickallen      Bugnote Added: 0000256                       
02-17-04 20:49 perex          Bugnote Deleted: 0000251                     
02-26-04 12:16 perex          Bugnote Added: 0000345                       
02-26-04 13:23 nickallen      Bugnote Added: 0000348                       
02-29-04 20:43 perex          Bugnote Added: 0000396                       
03-01-04 17:08 nickallen      Bugnote Added: 0000406                       
03-01-04 17:11 perex          Bugnote Added: 0000407                       
03-01-04 18:35 nickallen      Bugnote Added: 0000410                       
03-01-04 18:38 perex          Bugnote Added: 0000411                       
03-02-04 10:22 pestilence     Bugnote Added: 0000433                       
03-08-04 13:43 vda            Bugnote Added: 0000531                       
03-08-04 15:06 vda            Bugnote Added: 0000532                       
03-08-04 18:10 vda            Bugnote Added: 0000535                       
03-09-04 10:49 perex          Bugnote Added: 0000539                       
04-12-04 13:27 nickallen      Bugnote Added: 0000782                       
04-12-04 13:38 vda            Bugnote Added: 0000783                       
04-14-04 23:54 nickallen      Bugnote Added: 0000811                       
04-15-04 20:08 perex          Bugnote Added: 0000821                       
04-15-04 20:08 perex          Resolution               open => fixed       
04-15-04 20:08 perex          Status                   assigned => resolved
07-16-04 13:04 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
