From: noreply@alsa-project.org
Subject: [ALSA - driver 0000095]: kernel disables the IRQ assigned to the sound device
Date: Fri, 16 Jul 2004 14:28:51 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716122851.6271F2C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B6994244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:28:51 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000095
======================================================================
Reported By:                buboleck
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     95
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Slackware 9.1
Kernel Version:             2.6.X
======================================================================
Date Submitted:             02-27-2004 20:09 CET
Last Modified:              07-16-2004 14:28 CEST
======================================================================
Summary:                    kernel disables the IRQ assigned to the sound device
Description: 
kernel disables the IRQ assigned to the sound device


======================================================================

----------------------------------------------------------------------
 tiwai - 03-01-2004 11:45 CET 
----------------------------------------------------------------------
this is a known problem of nforce2.
is irq 7 for the sound chip only?  or shared with others?

----------------------------------------------------------------------
 buboleck - 03-01-2004 16:34 CET 
----------------------------------------------------------------------
do you need any other info? mb, bios?

----------------------------------------------------------------------
 buboleck - 03-01-2004 17:59 CET 
----------------------------------------------------------------------
Yes IRQ7 is shared with SMBus

root@buboleck:/# lspci -v
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
        Subsystem: ABIT Computer Corp.: Unknown device 1c02
        Flags: 66Mhz, fast devsel, IRQ 7
        I/O ports at c000 [size=32]
        Capabilities: [44] Power Management version 2


00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio
Controler (MCP) (rev a1)
        Subsystem: ABIT Computer Corp.: Unknown device 1c02
        Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 7
        I/O ports at b000 [size=256]
        I/O ports at b400 [size=128]
        Memory at ef001000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

----------------------------------------------------------------------
 tiwai - 03-01-2004 18:23 CET 
----------------------------------------------------------------------
first, check whether the kernel messages like
   intel8x0: unknown IRQ bits...
appear (only when compiled with CONFIG_SND_DEBUG).

if not, try the attached patch and check the kernel message again.

----------------------------------------------------------------------
 buboleck - 03-02-2004 00:03 CET 
----------------------------------------------------------------------
i've compiled drivers with --with-debug=full, but still no other messages.
sorry but the patch was rejectet. i don't know way... i'm not very much in
this things... wich version of the driver i'should use? 1.0.3? or 1.0.2c?
i've tried with both, same result...

----------------------------------------------------------------------
 tiwai - 03-02-2004 11:12 CET 
----------------------------------------------------------------------
it's for 1.0.3.  it's applied fine.
run patch -p0 < nforce-check.dif on alsa-driver-1.0.3 directory.

----------------------------------------------------------------------
 tiwai - 03-02-2004 11:13 CET 
----------------------------------------------------------------------
note that the patch driver might hang up due to the unprocessed
interrupts.  it might run but it might show thousands irqs per
seconds in /proc/interrupts.

----------------------------------------------------------------------
 buboleck - 03-02-2004 19:28 CET 
----------------------------------------------------------------------
Hi tiwai. So now patch worked. i've pached and instaled 1.0.3 driver with
2.6.3 kernel. the system works, no lock. Kernel did not disable the IRQ,
i'm jist waching "Wonderful days" - 6 ch. ac3 . that is the good news... 

the bad:

root@buboleck:# dmesg
spurious 8259A interrupt: IRQ7
...
...
snd: no version for "struct_module" found: kernel tainted.
PCI: Setting latency timer of device 0000:00:06.0 to 64
intel8x0_measure_ac97_clock: measured 49380 usecs
intel8x0: clocking to 47405
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)
ALSA /root/alsa-driver-1.0.3/pci/intel8x0.c:825: intel8x0: unknown IRQ
bits 0x300100 (sta_mask=0xf0)

that is. it repeats 10 times.. no more mo less... But the sound works and
it seems work good...

----------------------------------------------------------------------
 tiwai - 03-03-2004 11:31 CET 
----------------------------------------------------------------------
the kernel messages are intentional.
please check /proc/interrupts whether the number of irqs is rational.

----------------------------------------------------------------------
 buboleck - 03-03-2004 13:19 CET 
----------------------------------------------------------------------
root@buboleck:~# cat /proc/interrupts
           CPU0
  0:     318441          XT-PIC  timer
  1:        500          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:       7210          XT-PIC  NVidia nForce2
  8:          1          XT-PIC  rtc
 10:        540          XT-PIC  eth0
 12:      14978          XT-PIC  i8042
 14:      14331          XT-PIC  ide0
 15:         15          XT-PIC  ide1
NMI:          0
LOC:     318372
ERR:         32
MIS:          0

I have no idea how it should look like.

----------------------------------------------------------------------
 tiwai - 03-03-2004 15:15 CET 
----------------------------------------------------------------------
the irq should occur at each period size, so the number of irqs will be
(sample_rate / buffer_size) * num_periods

anyway, the number shown on your hardware looks not bad.

----------------------------------------------------------------------
 buboleck - 03-03-2004 15:49 CET 
----------------------------------------------------------------------
So what does it mean? Is it good or bad? What else I should do?

----------------------------------------------------------------------
 tiwai - 03-03-2004 16:01 CET 
----------------------------------------------------------------------
calcalate the interrupt frequency above with the reference to
/proc/asound/card0/pcm0p/sub0/hw_params (appearing only while
playback).  since periods = (buffer_size / period_size), the
formula above becomes:

irqs per second = (rates / buffer_size) * (buffer_size / period_size)

then measure the value of irq 7 in /proc/interrupts while playback.
if the rate of increasing number is as same as the expected value
above, it's ok.

----------------------------------------------------------------------
 buboleck - 03-03-2004 18:33 CET 
----------------------------------------------------------------------
root@buboleck:~# cat /proc/asound/card0/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 2048
buffer_size: 16384
tick_time: 1000

root@buboleck:~# cat /proc/interrupts
           CPU0
  0:    1383630          XT-PIC  timer
  1:       1606          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  7:     537896          XT-PIC  NVidia nForce2
  8:          1          XT-PIC  rtc
 10:        970          XT-PIC  eth0
 12:      39282          XT-PIC  i8042
 14:      28049          XT-PIC  ide0
 15:         15          XT-PIC  ide1
NMI:          0
LOC:    1383499
ERR:       9718
MIS:          0

so irqs per second = (48000 / 16384) * (16384 / 2048) = 23.4375

----------------------------------------------------------------------
 tiwai - 03-04-2004 10:56 CET 
----------------------------------------------------------------------
.. and the increase of irq numbers does match with the expected
rate ?

----------------------------------------------------------------------
 buboleck - 03-04-2004 18:15 CET 
----------------------------------------------------------------------
No... the increase is between 7-29, mostly in the middle ~14-17, and every
time I check it's diferent.

----------------------------------------------------------------------
 tiwai - 03-04-2004 18:39 CET 
----------------------------------------------------------------------
do you mean the increase "rate" of irqs?
you'll need to measure both the playback time and the number of
irqs generated during that period.

----------------------------------------------------------------------
 buboleck - 03-05-2004 17:38 CET 
----------------------------------------------------------------------
I'll tell you at tuesday. I'm away for couple of days.

----------------------------------------------------------------------
 tiwai - 03-05-2004 17:45 CET 
----------------------------------------------------------------------
the current CVS version is fixed for this problem (Nforce* only).

----------------------------------------------------------------------
 buboleck - 03-06-2004 12:01 CET 
----------------------------------------------------------------------
So this mean bug is resolved?

----------------------------------------------------------------------
 tiwai - 03-10-2004 17:49 CET 
----------------------------------------------------------------------
yes (hopefully).

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-27-04 20:09 buboleck       New Bug                                      
03-01-04 11:45 tiwai          Bugnote Added: 0000403                       
03-01-04 11:45 tiwai          Assigned To               => tiwai           
03-01-04 11:45 tiwai          Status                   new => assigned     
03-01-04 16:24 buboleck       Bugnote Added: 0000404                       
03-01-04 16:34 buboleck       Bugnote Added: 0000405                       
03-01-04 17:55 buboleck       Bugnote Deleted: 0000404                     
03-01-04 17:59 buboleck       Bugnote Added: 0000408                       
03-01-04 18:23 tiwai          Bugnote Added: 0000409                       
03-01-04 18:23 tiwai          File Added: nforce-check.dif                    
03-02-04 00:03 buboleck       Bugnote Added: 0000427                       
03-02-04 11:12 tiwai          Bugnote Added: 0000436                       
03-02-04 11:13 tiwai          Bugnote Added: 0000437                       
03-02-04 19:28 buboleck       Bugnote Added: 0000444                       
03-03-04 11:31 tiwai          Bugnote Added: 0000457                       
03-03-04 13:19 buboleck       Bugnote Added: 0000459                       
03-03-04 13:30 buboleck       Bug Monitored: buboleck                      
03-03-04 15:15 tiwai          Bugnote Added: 0000463                       
03-03-04 15:49 buboleck       Bugnote Added: 0000465                       
03-03-04 16:01 tiwai          Bugnote Added: 0000466                       
03-03-04 18:33 buboleck       Bugnote Added: 0000468                       
03-04-04 10:56 tiwai          Bugnote Added: 0000475                       
03-04-04 18:15 buboleck       Bugnote Added: 0000485                       
03-04-04 18:39 tiwai          Bugnote Added: 0000487                       
03-05-04 17:38 buboleck       Bugnote Added: 0000506                       
03-05-04 17:45 tiwai          Bugnote Added: 0000508                       
03-06-04 12:01 buboleck       Bugnote Added: 0000516                       
03-10-04 17:49 tiwai          Bugnote Added: 0000563                       
03-10-04 17:49 tiwai          Resolution               open => fixed       
03-10-04 17:49 tiwai          Status                   assigned => resolved
07-16-04 14:28 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
