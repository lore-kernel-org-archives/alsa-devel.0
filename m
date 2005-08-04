From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000879]: (snd_)opl3sa2 (isa) doesn't work (fails on playback) on 2.6.x kernels
Date: Thu, 4 Aug 2005 13:25:49 +0200
Message-ID: <e195ea1f845feadce2edb1dd50d88e45@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1A188202
	for <alsa-devel@alsa-project.org>; Thu,  4 Aug 2005 13:25:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=879> 
======================================================================
Reported By:                iive
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   879
Category:                   ISA - opl3sa2
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Slackware 10
Kernel Version:             all 2.6.x kernel version (current 2.6.10)
======================================================================
Date Submitted:             02-03-2005 03:42 CET
Last Modified:              08-04-2005 13:25 CEST
======================================================================
Summary:                    (snd_)opl3sa2 (isa) doesn't work (fails on playback)
on 2.6.x kernels
Description: 
It doesn't work on all 2.6.x kernel I have tried (current 2.6.10)
alsaconf doesn't detect the card as PnP, and fails to find it with
bruteforce.

When module is loaded by hand it shows no error, but on `aplay samle.wav`
I got
"ALSA /work/install/alsa-driver-1.0.5a/alsa-kernel/core/pcm_lib.c:2172:
playback
write error (DMA or IRQ trouble?"

on boot with 2.4.x kernel, everything magically works (alsaconf, aplay
etc..)

the bug is reported 4 months ago on
http://bugzilla.kernel.org/show_bug.cgi?id=3117
that's why some versions are old (but I had tried alsa-1.0.8 before
reposting this bug here)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001296 isapnp is incompatible with pnpbios and...
======================================================================

----------------------------------------------------------------------
 ahaning - 08-04-05 12:52 
----------------------------------------------------------------------
When I compile all drivers (not just --with-cards=opl3sa2) none of them
work.

I have now enabled kernel and BIOS support for PnP. With
alsa-driver-1.0.9b compiled with --with-cards=opl3sa2, no PnP or PCI cards
are found.

I don't see why I should need drivers other than opl3sa2.

----------------------------------------------------------------------
 perex - 08-04-05 13:25 
----------------------------------------------------------------------
Please, follow my instructions. I have not written to recompile other
drivers. I meant that in alsaconf should be selected the pnp card not
probing of legacy cards.

Also, follow ALL requests from
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=879#5608 and
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=879#5641. If you do
only partial steps, it avoids me to do proper conclusions. I don't have
opl3sa2 system around, so I rely on your input.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-05 03:42 iive           New Issue                                    
02-03-05 03:42 iive           File Added: isa_opl3sa2.tgz                    
02-03-05 03:42 iive           Distribution              => Slackware 10    
02-03-05 03:42 iive           Kernel Version            => all 2.6.x kernel
version (current 2.6.10)
04-13-05 21:59 jdthood        Note Added: 0004478                          
04-14-05 00:02 iive           Note Added: 0004485                          
07-09-05 06:26 ahaning        Note Added: 0005438                          
07-09-05 06:38 ahaning        Note Edited: 0005438                         
07-09-05 11:13 jdthood        Note Added: 0005439                          
07-09-05 11:14 jdthood        Note Added: 0005440                          
07-28-05 05:17 ahaning        Note Added: 0005577                          
08-02-05 00:02 iive           Note Added: 0005599                          
08-02-05 03:00 ahaning        Note Added: 0005600                          
08-02-05 03:05 ahaning        Note Added: 0005601                          
08-02-05 03:05 ahaning        Note Deleted: 0005600                        
08-02-05 22:08 perex          File Added: alsaconf-isapnp-2.6.patch             
      
08-02-05 22:14 perex          Note Added: 0005607                          
08-02-05 22:16 perex          Note Added: 0005608                          
08-03-05 02:46 ahaning        Note Added: 0005610                          
08-03-05 11:42 perex          File Added: alsaconf                         
08-03-05 11:42 perex          Note Added: 0005615                          
08-03-05 13:42 ahaning        Note Added: 0005625                          
08-03-05 15:17 ahaning        Note Added: 0005631                          
08-04-05 08:51 perex          Note Added: 0005641                          
08-04-05 08:52 perex          Relationship added       related to 0001296  
08-04-05 12:52 ahaning        Note Added: 0005644                          
08-04-05 13:25 perex          Note Added: 0005645                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
