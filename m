From: noreply@alsa-project.org
Subject: [ALSA - driver 0000081]: APM suspension causes loss of audio or lockup
Date: Fri, 16 Jul 2004 14:30:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123029.947572C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 06E42244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:30:32 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000081
======================================================================
Reported By:                chip
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     81
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-23-2004 17:44 CET
Last Modified:              07-16-2004 14:30 CEST
======================================================================
Summary:                    APM suspension causes loss of audio or lockup
Description: 
APM suspension while driver is idle causes silence.
APM suspension while driver is active causes process hang.
======================================================================

----------------------------------------------------------------------
 tiwai - 02-26-2004 19:52 CET 
----------------------------------------------------------------------
could you try the attached patch?

----------------------------------------------------------------------
 chip - 03-01-2004 03:48 CET 
----------------------------------------------------------------------
No, I'm afraid that patch made no difference.

----------------------------------------------------------------------
 tiwai - 03-02-2004 12:32 CET 
----------------------------------------------------------------------
how about the second one?
a small delay was added there.  this was reported once to solve
the register mismatch problem on some ICH notebook.

----------------------------------------------------------------------
 chip - 03-09-2004 18:28 CET 
----------------------------------------------------------------------
I regret to report that the second patch also had no effect.

Next time you post something please notify me at chip@pobox.com or It'll
take me forever to notice, again.

----------------------------------------------------------------------
 sziwan - 04-28-2004 00:56 CEST 
----------------------------------------------------------------------
Just my $0.02 here: I have the same problem, introduced somewhere between
0.9.4 and 0.9.8 (the former was still fine and I could have sound playing
over any kind of suspend). 

Right now, if the application uses the PCM in native mode while
suspending, it hangs; the exemplary trace looks like this:
artsd         D FFFFFC18   152 21438      1               27468 (NOTLB)
Using defaults from ksymoops -t elf32-i386 -a i386
Call Trace:    [<c010642a>] [<c0106584>] [<d2924284>] [<d2922cf0>]
[<c015c809>]
  [<c010789f>]
Warning (Oops_read): Code line not seen, dumping what data is available

Proc;  artsd

>>EIP; fffffc18 <END_OF_CODE+2b27ed95/????>   <=====

Trace; c010642a <__down+5a/a0>
Trace; c0106584 <__down_failed+8/c>
Trace; d2924284 <[snd-pcm].text.lock.pcm_native+69/e5>
Trace; d2922cf0 <[snd-pcm]snd_pcm_playback_ioctl1+80/330>
Trace; c015c809 <sys_ioctl+c9/250>
Trace; c010789f <system_call+33/38>

Oddly enough, applications using OSS emulation seem to survive the
suspend.

My hardware is Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97
Audio Controller (rev 02), or more specifically, Cirrus Logic CS4299 rev 4
for the AC'97 codec, though from what I've seen this bug seems to be
common for all the intel8x0 users (bug id https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000024 might be a duplicate). Any
updates on that issue?

----------------------------------------------------------------------
 tiwai - 04-30-2004 10:39 CEST 
----------------------------------------------------------------------
the PM bug (including mutex deadlock) has been fixed recently on CVS.
please give a try.

----------------------------------------------------------------------
 sziwan - 04-30-2004 11:49 CEST 
----------------------------------------------------------------------
I tried today's (20040430) snapshot -- it's actually worse, as it won't
play anything at all after resume. The following might be the cause:
# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Cirrus Logic CS4299 rev 4

Capabilities     : -headphone out-
DAC resolution   : 20-bit
ADC resolution   : 18-bit
3D enhancement   : Crystal Semi 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+0dB]
POP path         : post 3D
Sim. stereo      : on
3D enhancement   : on
Loudness         : on
Mono output      : Mic
Mic select       : Mic2
ADC/DAC loopback : on
Extended ID      : codec=3 rev=3 AMAP LDAC SDAC CDAC DSA=3 VRM SPDIF DRA
VRA
Extended status  : PRL PRK PRJ PRI SPCV MADC LDAC SDAC CDAC SPDIF=res VRM
SPDIF DRA VRA
PCM front DAC    : 65535Hz
PCM Surr DAC     : 65535Hz
PCM LFE DAC      : 65535Hz
PCM ADC          : 65535Hz
PCM MIC ADC      : 65535Hz
SPDIF Control    : PRO Non-audio Preemph50/15 Category=0x7f Generation=1
Rate=res Validity Enabled
Extended modem ID: codec=3 CID2 CID1 HSET LIN2 LIN1
Modem status     : GPIO MREF ADC1 DAC1 ADC2 DAC2 HADC HDAC PRA(GPIO)
PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2) PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 65535Hz
Line2 rate       : 65535Hz
Headset rate     : 65535Hz

Kernel log:
kernel: ALSA intel8x0.c:2028: AC'97 warm reset still in progress? [0x6]
kernel: ALSA intel8x0.c:611: codec_write 0: semaphore is not ready for
register 0x26
kernel: ALSA intel8x0.c:611: codec_write 0: semaphore is not ready for
register 0x0
kernel: ALSA intel8x0.c:611: codec_write 0: semaphore is not ready for
register 0x26
kernel: ALSA intel8x0.c:611: codec_write 0: semaphore is not ready for
register 0x20
kernel: ALSA intel8x0.c:611: codec_write 0: semaphore is not ready for
register 0x26
kernel: ALSA intel8x0.c:611: codec_write 0: semaphore is not ready for
register 0x2
kernel: ALSA intel8x0.c:627: codec_read 0: semaphore is not ready for
register 0x2
[...]

edited on: 04-30-04 11:49

----------------------------------------------------------------------
 tiwai - 05-01-2004 10:36 CEST 
----------------------------------------------------------------------
well but there is no longer lock up, right?

the error seems happening because of some incomplete initialization
sequence.
can you get the sound working again if you reload the driver
after resume?

----------------------------------------------------------------------
 sziwan - 05-21-2004 00:05 CEST 
----------------------------------------------------------------------
I retested with 2.6.6-mm4 and the problem seems resolved, sound is played
across both ACPI S1 and S3 suspends.

----------------------------------------------------------------------
 tiwai - 05-21-2004 12:17 CEST 
----------------------------------------------------------------------
ok, close this bug now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-23-04 17:44 chip           New Bug                                      
02-23-04 17:44 chip           File Added: REG1                             
02-26-04 19:52 tiwai          Bugnote Added: 0000366                       
02-26-04 19:52 tiwai          File Added: ac97-resume-fix.dif                    
03-01-04 03:48 chip           Bugnote Added: 0000398                       
03-02-04 12:32 tiwai          Bugnote Added: 0000440                       
03-02-04 12:32 tiwai          File Added: ac97-resume-fix2.dif                    
03-09-04 18:28 chip           Bugnote Added: 0000552                       
04-28-04 00:56 sziwan         Bugnote Added: 0000966                       
04-30-04 10:39 tiwai          Bugnote Added: 0000972                       
04-30-04 11:43 sziwan         Bugnote Added: 0000983                       
04-30-04 11:49 sziwan         Bugnote Edited: 0000983                      
05-01-04 10:36 tiwai          Bugnote Added: 0000994                       
05-21-04 00:05 sziwan         Bugnote Added: 0001158                       
05-21-04 12:17 tiwai          Bugnote Added: 0001162                       
05-21-04 12:17 tiwai          Assigned To               => tiwai           
05-21-04 12:17 tiwai          Resolution               open => fixed       
05-21-04 12:17 tiwai          Status                   new => resolved     
07-16-04 14:30 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
