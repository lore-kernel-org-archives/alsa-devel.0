From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000879]: (snd_)opl3sa2 (isa) doesn't work (fails on playback) on 2.6.x kernels
Date: Sat, 6 Aug 2005 08:37:19 +0200
Message-ID: <fca36f1b63648892d1a28ead2d5ba12d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9C65E213
	for <alsa-devel@alsa-project.org>; Sat,  6 Aug 2005 08:37:19 +0200 (MEST)
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
Last Modified:              08-06-2005 08:37 CEST
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
 ahaning - 08-06-05 00:31 
----------------------------------------------------------------------
# modinfo -p snd-opl3sa2
#

I'm not sure whether to be :-D or :-(

Edit: FWIW, modinfo snd-opl3sa2 is slightly more interesting:

# modinfo snd-opl3sa2
author:         Jaroslav Kysela <perex@suse.cz>
description:    Yamaha OPL3SA2+
license:        GPL
parmtype:       index:array of int
parm:           index:Index value for OPL3-SA soundcard.
parmtype:       id:array of charp
parm:           id:ID string for OPL3-SA soundcard.
parmtype:       enable:array of bool
parm:           enable:Enable OPL3-SA soundcard.
parmtype:       isapnp:array of bool
parm:           isapnp:PnP detection for specified soundcard.
parmtype:       port:array of long
parm:           port:Port # for OPL3-SA driver.
parmtype:       sb_port:array of long
parm:           sb_port:SB port # for OPL3-SA driver.
parmtype:       wss_port:array of long
parm:           wss_port:WSS port # for OPL3-SA driver.
parmtype:       fm_port:array of long
parm:           fm_port:FM port # for OPL3-SA driver.
parmtype:       midi_port:array of long
parm:           midi_port:MIDI port # for OPL3-SA driver.
parmtype:       irq:array of int
parm:           irq:IRQ # for OPL3-SA driver.
parmtype:       dma1:array of int
parm:           dma1:DMA1 # for OPL3-SA driver.
parmtype:       dma2:array of int
parm:           dma2:DMA2 # for OPL3-SA driver.
parmtype:       opl3sa3_ymode:array of int
parm:           opl3sa3_ymode:Speaker size selection for 3D Enhancement
mode: Desktop/Large Notebook/Small Notebook/HiFi.
vermagic:       2.6.12.2 preempt PENTIUM4 gcc-3.2
depends:        snd-cs4231-lib,snd-opl3-lib,snd,snd-mpu401-uart,snd-pcm
alias:          pnp:cYMH0020dYMH0021*
alias:          pnp:cYMH0030dYMH0021*
alias:          pnp:cYMH0800dYMH0021*
alias:          pnp:cYMH0801dYMH0021*
alias:          pnp:cNMX2200dYMH2210*
#

Also FWIW:

# modinfo -V
module-init-tools version 0.9.14
#

I tried to install module-init-tools-3.1 but it requires docbook2man. I
found a newer version of docbook-tools on sources.redhat.com but it
requires the jade lib (which is in the same directory) but that won't
compile. :-/

Thanks.



----------------------------------------------------------------------
 perex - 08-06-05 08:37 
----------------------------------------------------------------------
Yes, you need new version of module-init-tools accepting -p parameter. I'm
using module-init-tools-3.2_pre1-7. It's not a worth to add support for
older versions to alsaconf.

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
08-04-05 13:28 perex          Note Added: 0005646                          
08-04-05 14:38 ahaning        File Added: sys-ahaning-0.1.tar.bz2               
    
08-04-05 14:42 ahaning        Note Added: 0005649                          
08-04-05 14:49 ahaning        Note Edited: 0005649                         
08-04-05 14:50 ahaning        File Added: asound-ahaning-0.1.tar.bz2            
       
08-04-05 14:51 perex          Note Added: 0005650                          
08-05-05 02:35 ahaning        Note Added: 0005655                          
08-05-05 03:18 ahaning        Note Edited: 0005655                         
08-05-05 08:44 perex          Note Added: 0005661                          
08-05-05 12:47 ahaning        Note Added: 0005665                          
08-05-05 13:47 perex          Note Added: 0005667                          
08-05-05 23:58 ahaning        Note Added: 0005678                          
08-06-05 00:31 ahaning        Note Edited: 0005678                         
08-06-05 08:37 perex          Note Added: 0005680                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
