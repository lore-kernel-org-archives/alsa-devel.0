From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001134]: alsa 1.0.9rc4 + intel 82801FB/.../ = No sound (Benq 52-101)
Date: Fri, 3 Mar 2006 08:29:11 +0100
Message-ID: <0356bef644efc1acea467e14b8e79e71@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E6B7A1A9
	for <alsa-devel@alsa-project.org>; Fri,  3 Mar 2006 08:29:11 +0100 (MET)
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
Last Modified:              03-03-2006 08:29 CET
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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
