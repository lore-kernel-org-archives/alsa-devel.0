From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000879]: (snd_)opl3sa2 (isa) doesn't work (fails on playback) on 2.6.x kernels
Date: Mon, 8 Aug 2005 13:45:30 +0200
Message-ID: <adb52593d2f28b46594c6455891b6d8f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0BDF21CC
	for <alsa-devel@alsa-project.org>; Mon,  8 Aug 2005 13:45:30 +0200 (MEST)
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
Last Modified:              08-08-2005 13:45 CEST
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
 iive - 08-07-05 15:24 
----------------------------------------------------------------------
Hello,
perex I have tested your improved alsaconf, and yes it indeed detects 
my sound card. To help you I have included the result of
`bash -x ./alsaconf 2> alsaconf.log` so you can see the check that
succeeds.

Anyway, after alsaconf finds the right module updates the config files
and
says "your done", I try to play an sample and ... it hangs.

Well, I suspect that this is DMA->IRQ issue. 
As you could have probably seen in my very first archive posted here -
the number of trigered interrupts inclrase with 2 (I checked, this is
done when modules is inserted) but it never changes when I try to play 
something. The most obvious reason -> The sound card doesn't triger it or
doesn't handle it.

Now having in mind same source code is uses in 2.4 kernel and I do use
alsa in 2.4 kernel and it works flowlessly, I believe it is kernel bug.
Well... there may be something in the details.

To give you some light, I have enabled all debuging options and put
an more verbose output on register handling in opl3sa2.c and cs4231_lib.c
.
I have attached modified files and the result output log.
If you need something more specific... send it :P
(kernel 2.6.12, sorry): 

All files and logs are in opl3sa2_iive2.tgz, take a look and of the older
opl3sa2.tgz.

BTW While I was looking into the source I think i may have found bug 
(not related to this issue).
The snd_opl3sa2.single_dma is never zeroed. The structure(typedef
actually)
is declared static and assumed to be zeroed by the compiler.
Unfortunatelly this flag will persist if module is removed and reloaded 
with different parameters that doesn't set it.
small patch :
-if (xdma2 < 0)
-         chip->single_dma = 1;
+chip->single_dma = (xdma2 < 0);

----------------------------------------------------------------------
 perex - 08-08-05 13:45 
----------------------------------------------------------------------
iive: Thanks for testing. Please, could you send me related ALSA lines from
/etc/modules.conf or /etc/modprobe.d/sound (depending on distro) and
contents of /sys directory when snd-opl3sa2 module is loaded?

Also, please,try to override dma1, dma2 and irq parameters in the modprobe
configuration file. (For example: options snd-opl3sa2 dma1=3 dma2=1
irq=9). Check for free irqs in /proc/interrupts and for dmas in /proc/dma.

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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
