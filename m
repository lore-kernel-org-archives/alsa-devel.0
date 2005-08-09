From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000879]: (snd_)opl3sa2 (isa) doesn't work (fails on playback) on 2.6.x kernels
Date: Tue, 9 Aug 2005 11:31:46 +0200
Message-ID: <0664090509539c8d4f2b041d4bf1c957@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A213D1CB
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 11:31:46 +0200 (MEST)
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
Last Modified:              08-09-2005 11:31 CEST
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
 ahaning - 08-09-05 04:39 
----------------------------------------------------------------------
Well, with the help of some people on LKML, I've successfully built
module-init-tools 3.2-pre7.

I've installed alsa-utils-1.0.9 with the above patch and installed the
above-attached alsaconf.

When I run alsaconf 1.0.9a, it does not detect my card as a PnP card. It
will brute-force detect the card, however. The dma1, dma2, and irq are
wrong, though.  When I fix them in the modprobe.conf file, I can do
'alsasound restart' and the card appears to be detected. When I go to play
something, I won't get sound until I touch the PCM mixer.

If it would help, I can repost my /sys directory.

Thanks.

Edit: FWIW, here's my modinfo -p snd-opl3sa2

# modinfo -p snd-opl3sa2
index:Index value for OPL3-SA soundcard.
id:ID string for OPL3-SA soundcard.
enable:Enable OPL3-SA soundcard.
isapnp:PnP detection for specified soundcard.
port:Port # for OPL3-SA driver.
sb_port:SB port # for OPL3-SA driver.
wss_port:WSS port # for OPL3-SA driver.
fm_port:FM port # for OPL3-SA driver.
midi_port:MIDI port # for OPL3-SA driver.
irq:IRQ # for OPL3-SA driver.
dma1:DMA1 # for OPL3-SA driver.
dma2:DMA2 # for OPL3-SA driver.
opl3sa3_ymode:Speaker size selection for 3D Enhancement mode:
Desktop/Large Notebook/Small Notebook/HiFi.
#



----------------------------------------------------------------------
 iive - 08-09-05 11:31 
----------------------------------------------------------------------
Well, I finnaly successed of making sound work.
The only thing that helped was setting BIOS to 'PNP OS = YES'.
This only comes to proove that the kernel is the reason of all problem.
The real question is where to look now.

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
08-06-05 18:32 ahaning        Note Added: 0005681                          
08-06-05 18:39 ahaning        Note Edited: 0005681                         
08-06-05 19:51 ahaning        Note Edited: 0005681                         
08-07-05 15:19 iive           File Added: opl3sa2_iive2.tgz                    
08-07-05 15:24 iive           Note Added: 0005694                          
08-08-05 13:45 perex          Note Added: 0005707                          
08-09-05 03:00 ahaning        Note Added: 0005716                          
08-09-05 04:39 ahaning        Note Edited: 0005716                         
08-09-05 11:31 iive           Note Added: 0005719                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
