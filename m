From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001134]: alsa 1.0.9rc4 + intel 82801FB/.../ = No sound (Benq 52-101)
Date: Thu, 16 Mar 2006 19:34:55 +0100
Message-ID: <470398c4a72ceab8c6886106399ddc20@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 681C21A0
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 19:34:56 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The issue 0001931 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1134> 
======================================================================
Reported By:                liangalei
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1134
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.14
======================================================================
Date Submitted:             05-28-2005 08:49 CEST
Last Modified:              03-16-2006 15:05 CET
======================================================================
Summary:                    alsa 1.0.9rc4 + intel 82801FB/.../ = No sound (Benq
52-101)
Description: 
My notebook is Benq 52-101, update FC3 to kernel 2.6.11-1.14_FC3

alsamixer report: Card=intel ICH6, chip=Conexant id 3 (Question, Conexant
just support modem's AC-97 or else provide whole sound ? )

alsaconf: can find "Intel Corp 82801FB/.../ ICH6 family AC'97 Audio", and
will contine to "Have a lot fun".

I have ever, update linux kernel from 2.6.9 to 2.6.11(yum update, no
recompiling), and alsa driver from 0.9.0/1.0.8/1.0.9rc3/4.

Recomipling ALsa driver/lib/oss/tools/util.., with drive, ever try 
----- ./configure --with-cards=azx (error: no this card)
----- ./configure ; make; make install (no error report), not run
./snddevices

No sound ! So much days, so much test..... (if i915GM chipset + Conexant
chip...(see below lspci), will be powered by alsa-1.0.9rc4 ? --- if still
not, I will just wait for new alsa-driver.)

thanks
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001931 Unknown AC97 codec, digital sound works
======================================================================

----------------------------------------------------------------------
 liangalei - 05-28-05 09:17 
----------------------------------------------------------------------
[root@room-1109 ~]# /sbin/lsmod | grep snd
snd_intel8x0           34752  2
snd_ac97_codec         78588  1 snd_intel8x0
snd_mixer_oss          19072  1
snd_pcm                99848  2 snd_intel8x0,snd_ac97_codec
snd_timer              33668  1 snd_pcm
snd                    59396  7
snd_intel8x0,snd_ac97_codec,snd_mixer_oss,snd_pcm,snd_timer
soundcore              10785  2 snd
snd_page_alloc         10244  2 snd_intel8x0,snd_pcm
[root@room-1109 ~]#

----------------------------------------------------------------------
 liangalei - 05-30-05 03:29 
----------------------------------------------------------------------
hinted by https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1078
I have a look at my /proc/asound, it looks like following, ----- Is it
strange? I see many "off" ---- but I cannot turn-ONs them, by either
alsamixer or aumix, because in alsamixer jack-bars, them can not be seen
!

[lal@lal ~]$ cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Conexant id 31

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x0000
Subsys. ID       : 0x0000

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 AMAP LDAC SDAC CDAC DSA=0 SPDIF
Extended status  : PRL SPCV LDAC SDAC CDAC SPDIF=10/11
SPDIF Control    : Consumer PCM Category=0x2 Generation=1 Rate=48kHz
Extended modem ID: codec=0 LIN1
Modem status     : PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2)
PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 48000Hz
[lal@lal ~]$

----------------------------------------------------------------------
 tiwai - 06-01-05 16:58 
----------------------------------------------------------------------
I suspect it's not a Conexant codec.  The driver seems to fail detection of
the codec.

This kind of problems is often related with ACPI.  Try to tune the ACPI
boot setting.

----------------------------------------------------------------------
 liangalei - 06-02-05 10:42 
----------------------------------------------------------------------
Thanks for reply. Can you give more hints: about how to tune the ACPI boot
? (I have no idea at all).

By way, I call Benq's tech-support. Because they don't support Linux for
Benq S52, so no much valuable info from them, just they tell sound chip is
Conexant CS20551 (maybe mis-hear, it should be CX20551). And when I ask
him if it refers to modem chip, he don't know. --- I search this chip, but
no result. Q: is it a AMC'97 chip?

----------------------------------------------------------------------
 tiwai - 06-23-05 12:42 
----------------------------------------------------------------------
If the info is correct, yes, it sounds like an AMC97 chip.

Please attach /etc/asound.state and all /proc/asound/card0/codec97#*/*
files for checking the mixer state.

----------------------------------------------------------------------
 liangalei - 06-24-05 03:18 
----------------------------------------------------------------------
thanks for reply. 

I have attach three very long file, see above "attach files".

and here is some simply info, does any more info is needed ? 

[lal@lal ~]$ cat /proc/asound/card0/intel8x0
Intel8x0

Global control        : 0xc0000002
Global status         : 0x00700100
SDM                   : 0x00000008
AC'97 codecs ready    : primary
AC'97 codecs SDIN     : 0 0 0


[lal@lal ~]$ tree /proc/asound/card*
/proc/asound/card0
|-- codec97#0
|   |-- ac97#0-0
|   `-- ac97#0-0+regs
|-- id
|-- intel8x0
|-- oss_mixer
|-- pcm0c
|   |-- info
|   |-- oss
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm0p
|   |-- info
|   |-- oss
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm1c
|   |-- info
|   |-- oss
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm2c
|   |-- info
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
|-- pcm3c
|   |-- info
|   `-- sub0
|       |-- hw_params
|       |-- info
|       |-- prealloc
|       |-- status
|       `-- sw_params
`-- pcm4p
    |-- info
    `-- sub0
        |-- hw_params
        |-- info
        |-- prealloc
        |-- status
        `-- sw_params
/proc/asound/cards [error opening dir]

----------------------------------------------------------------------
 ybar - 08-28-05 15:28 
----------------------------------------------------------------------
i ran alsamixer and set External amplifier to "on" to listen to music
without headphone.

----------------------------------------------------------------------
 derek - 11-29-05 06:03 
----------------------------------------------------------------------
HI : guys

    i have the same issue. can any body help me out ?
    my notebook is benq s52 too.

HI  liangalei
    did you find the way out already?
    if you have some useful inf.  can you share with me ?
    thank you !!!  my email:   moonkyang+root@gmail.com  

best Rgds
Derek

----------------------------------------------------------------------
 gandhi - 02-17-06 23:43 
----------------------------------------------------------------------
same Laptop..same Problem...

are further infos needed?

problem still exist with alsa-driver 1.0.11_rc3


when i unmute IEC958 with alsamixer a red light goes on and off in the
headphone jack (light is on under windows)

when i turn mixer up und unmute microphone i hear every time i change a
value in alsamixer a cracking sound



----------------------------------------------------------------------
 gandhi - 02-18-06 02:05 
----------------------------------------------------------------------
this bug is assigned..but to nobody..isn't this a problem?

----------------------------------------------------------------------
 liangalei - 02-18-06 08:13 
----------------------------------------------------------------------
Many people inqure me, if I have solution.
My answer is NO, my S52 has been silent until now. 
I have used to its silent (no music, no movie), and used to alsa's silent
(without any response).

----------------------------------------------------------------------
 gandhi - 02-18-06 15:56 
----------------------------------------------------------------------
hi.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1134

this bug is assigned, but not to another person. i think that nobody will
see this bug as his task. is it possible to assign this bug to somebody?

i would be willed to code and get rid of this bug by my own, but i did
never before any programming for hardware (but i do for other things)..
neither didn't find a point to start :/

----------------------------------------------------------------------
 robitech - 03-03-06 08:29 
----------------------------------------------------------------------
HELLO. Please help me. I am using GENTOO LINUX. No sound on my BENQ
S52.Probed module snd-itel8x0. Thank you.

----------------------------------------------------------------------
 JProgrammer - 03-15-06 05:34 
----------------------------------------------------------------------
It appears to me that this is a problem with ac97_codec as it is not being
identified the id for this card is 0x43585431 I have tried it with
conexant_patch and with no patch however there is still no sound. I am
willing to help in delivering a patch however I am not familiar with
developing for alsa and the CX20551 is not even on the conexant website to
look for documentation like with some of their other chips.

----------------------------------------------------------------------
 Kooper - 03-15-06 06:39 
----------------------------------------------------------------------
The same hardware (BenQ Joybook S52), the same problem.
Kernel - 2.6.15-1.1833_1.rhfc4.cubbi_swsusp2 (no sound with standard FC4
kernels also)
alsa-utils-1.0.10-1.FC4

----------------------------------------------------------------------
 tiwai - 03-15-06 11:40 
----------------------------------------------------------------------
Well, the possible problems are:

- Some important codec-specific initialization is missing
- Conflict of audio and modem codec initialization, due to the combined
codec chip

The first one is hard to fix without a proper h/w information.

For the second point, make sure that you never load snd-intel8x0m (note
'm'), e.g. by removing the driver module file.  Then, comment out the
whole codes related with modem.

----------------------------------------------------------------------
 Kooper - 03-15-06 11:53 
----------------------------------------------------------------------
> The first one is hard to fix without a proper h/w information.

Can I help with it? You need a hardware information from me (customer) or
from BenQ?

> For the second point, make sure that you never load snd-intel8x0m (note
'm'), 
> e.g. by removing the driver module file. Then, comment out the whole
codes 
> related with modem.

# lsmod | grep intel
snd_intel8x0           32093  0
snd_ac97_codec         88161  1 snd_intel8x0
snd_pcm                86981  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
snd                    54309  9
snd_intel8x0,snd_ac97_codec,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
snd_page_alloc         10697  2 snd_intel8x0,snd_pcm

# dmesg | grep intel8x0
intel8x0_measure_ac97_clock: measured 55983 usecs
intel8x0: clocking to 48000

# grep intel /etc/modprobe.conf
alias snd-card-0 snd-intel8x0
options snd-intel8x0 index=0
remove snd-intel8x0 { /usr/sbin/alsactl store 0 >/dev/null 2>&1 || : ; };
/sbin/modprobe -r --ignore-remove snd-intel8x0

Which 'codes' I should comment out? Comment out from what?

----------------------------------------------------------------------
 JProgrammer - 03-15-06 12:13 
----------------------------------------------------------------------
intel8x0m is blacklisted on my system Ubuntu Dapper I should get in contact
with BenQ to confirm chip used and then get in contact with Conexant they
have detailed documents for other chips available we may be able to get a
hold of them

----------------------------------------------------------------------
 tiwai - 03-15-06 12:18 
----------------------------------------------------------------------
The technical detail would be really appreciated.

The code to be fixed is likely in ac97_codec.c.  You can find many
modem-related stuff there.

----------------------------------------------------------------------
 JProgrammer - 03-15-06 23:48 
----------------------------------------------------------------------
I received a response from BenQ today:

"BenQ does not support the use of Linux on our notebooks, therefor there
are no drivers or support documentation iswritten for this system.

Regards

BenQ Support"

However I phoned them up later and got them to confirm that it is the
CX20551 chip in this laptop. I then proceeded to contact Conexant from
their website literature@conexant.com however the delivery to this address
fails.

If someone in the US or Canada could contact them directly on a toll free
number that would be appreciated.

Headquarters
4000 MacArthur Blvd.
Newport Beach, CA., 92660
Phone: (949) 483-4600
(888) 855-4562 (Toll free U.S. & Canada)

----------------------------------------------------------------------
 tiwai - 03-16-06 15:04 
----------------------------------------------------------------------
The patch attached is just a blind shot to remove the modem part from
ac97_codec.c.  Give it a try.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-28-05 08:49 liangalei      New Issue                                    
05-28-05 08:49 liangalei      Distribution              => Fedora Core 3   
05-28-05 08:49 liangalei      Kernel Version            => 2.6.11-1.14     
05-28-05 09:17 liangalei      Note Added: 0004759                          
05-28-05 09:18 liangalei      Issue Monitored: liangalei                    
05-30-05 03:29 liangalei      Note Added: 0004795                          
06-01-05 16:58 tiwai          Note Added: 0004863                          
06-01-05 17:04 tiwai          Category                 0_compilation problem_!!!
=> PCI - intel8x0
06-02-05 10:42 liangalei      Note Added: 0004875                          
06-06-05 09:53 perex          Assigned To              perex =>            
06-23-05 12:42 tiwai          Note Added: 0005182                          
06-24-05 03:12 liangalei      File Added: asound.state                     
06-24-05 03:13 liangalei      File Added: ac97#0-0                         
06-24-05 03:14 liangalei      File Added: ac97#0-0+regs                    
06-24-05 03:18 liangalei      Note Added: 0005202                          
08-28-05 15:28 ybar           Note Added: 0005962                          
11-29-05 05:59 derek          Issue Monitored: derek                       
11-29-05 06:00 derek          Issue End Monitor: derek                     
11-29-05 06:03 derek          Note Added: 0006870                          
02-07-06 10:03 anhi1968       Issue Monitored: anhi1968                    
02-17-06 22:22 gandhi         Note Added: 0008110                          
02-17-06 23:26 gandhi         Issue Monitored: gandhi                      
02-17-06 23:28 gandhi         Note Edited: 0008110                         
02-17-06 23:43 gandhi         Note Edited: 0008110                         
02-18-06 02:05 gandhi         Note Added: 0008112                          
02-18-06 08:13 liangalei      Note Added: 0008116                          
02-18-06 15:56 gandhi         Issue Monitored: tiwai                       
02-18-06 15:56 gandhi         Note Added: 0008120                          
02-28-06 12:02 anhi1968       Issue End Monitor: anhi1968                    
03-03-06 08:29 robitech       Note Added: 0008336                          
03-15-06 05:34 JProgrammer    Note Added: 0008526                          
03-15-06 05:37 JProgrammer    Issue Monitored: JProgrammer                    
03-15-06 06:39 Kooper         Note Added: 0008527                          
03-15-06 11:40 tiwai          Note Added: 0008531                          
03-15-06 11:53 Kooper         Note Added: 0008535                          
03-15-06 12:13 JProgrammer    Note Added: 0008538                          
03-15-06 12:18 tiwai          Note Added: 0008540                          
03-15-06 23:48 JProgrammer    Note Added: 0008579                          
03-16-06 15:04 tiwai          Note Added: 0008606                          
03-16-06 15:05 tiwai          File Added: ac97-remove-modem.diff                
   
03-16-06 19:34 rlrevell       Relationship added       has duplicate 0001931
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
