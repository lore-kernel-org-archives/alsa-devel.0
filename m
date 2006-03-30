From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001134]: alsa 1.0.9rc4 + intel 82801FB/.../ = No sound (Benq 52-101)
Date: Thu, 30 Mar 2006 15:47:17 +0200
Message-ID: <e2d9aed4f7eb1e929803becb62f21775@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98013184
	for <alsa-devel@alsa-project.org>; Thu, 30 Mar 2006 15:47:17 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Last Modified:              03-30-2006 15:47 CEST
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
 alessiodf - 03-26-06 20:15 
----------------------------------------------------------------------
Hi all!
I've a benq S53 and i have the same problem with the mute sound! :(

some informations...
---------------------------------------------------------------------
root@joybook[~]# cat /proc/asound/card0/intel8x0
Intel8x0

Global control        : 0xc0000002
Global status         : 0x00700100
SDM                   : 0x00000008
AC'97 codecs ready    : primary
AC'97 codecs SDIN     : 0 0 0

---------------------------------------------------------------------
root@joybook[~]# cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Conexant id 31

PCI Subsys Vendor: 0x17ff
PCI Subsys Device: 0x058b

Revision         : 0x00
Compat. Class    : 0x00
Subsys. Vendor ID: 0x0000
Subsys. ID       : 0x0000

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : No 3D Stereo Enhancement

Current setup
Mic gain         : +0dB [+0dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=2 AMAP LDAC SDAC CDAC DSA=0 SPDIF
Extended status  : PRL SPCV LDAC SDAC CDAC SPDIF=10/11
SPDIF Control    : Consumer PCM Copyright Category=0x22 Generation=1
Rate=48kHz
Extended modem ID: codec=0 LIN1
Modem status     : PRA(GPIO) PRB(res) PRC(ADC1) PRD(DAC1) PRE(ADC2)
PRF(DAC2) PRG(HADC) PRH(HDAC)
Line1 rate       : 48000Hz

---------------------------------------------------------------
root@joybook[~]# cat /proc/asound/cards
 0 [ICH6           ]: ICH4 - Intel ICH6
                      Intel ICH6 with unknown codec at 0xb0040800, irq 11

---------------------------------------------------------------



----------------------------------------------------------------------
 trava - 03-30-06 15:47 
----------------------------------------------------------------------
I've the same problem on benq s53y.01, the sound is mute. I tried also to
use snd-hda-intel, but this module don't work at all.
I don't know what to do... :(

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
03-17-06 04:10 Kooper         Note Added: 0008633                          
03-17-06 12:07 tiwai          Note Added: 0008641                          
03-17-06 12:32 Kooper         File Added: kooper-alsa-bugreport.tgz             
      
03-17-06 12:35 Kooper         Note Added: 0008644                          
03-21-06 02:38 JProgrammer    Note Added: 0008736                          
03-25-06 10:51 alessiodf      Note Added: 0008944                          
03-26-06 20:12 alessiodf      Note Edited: 0008944                         
03-26-06 20:15 alessiodf      Note Edited: 0008944                         
03-30-06 15:47 trava          Note Added: 0009034                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
