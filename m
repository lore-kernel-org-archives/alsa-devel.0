From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000748]: Kernel 2.6.9 and 2.6.10 makes sound of Ali 5455 chipset choppy, plays to fast
Date: Mon, 19 Sep 2005 09:12:19 +0200
Message-ID: <6a20fd82cece025cac2c571d23289655@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 46D7811B
	for <alsa-devel@alsa-project.org>; Mon, 19 Sep 2005 09:12:19 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=748> 
======================================================================
Reported By:                pcmcginty
Assigned To:                jdthood
======================================================================
Project:                    ALSA - driver
Issue ID:                   748
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Arch Linux
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-26-2004 06:50 CET
Last Modified:              09-19-2005 09:12 CEST
======================================================================
Summary:                    Kernel 2.6.9 and 2.6.10 makes sound of Ali 5455
chipset choppy, plays to fast
Description: 
I've been spending a lot of time getting sound to work on my Sharp Actius
MM20 laptop. The platform has an ALI 5455 chip that is using the intel8x0
ALSA driver. On a 2.6.7 kernel, the sound is 100% perfect. The 2.6.9 and
2.6.10 kernel series cause the sound to become garbled as if the song is
skipping through the music faster than it should. I have not tried ont he
2.6.8 series. I can compile and try out if required. It is possible this
is some other kernel issue, however I'm not sure how to track down where
the kernel might be breaking the ALSA driver.
======================================================================

----------------------------------------------------------------------
 JonathanL - 09-18-05 23:30 
----------------------------------------------------------------------
works fine now with recents kernel (gentoo-2.6.12-r8 for me)

----------------------------------------------------------------------
 jdthood - 09-19-05 09:12 
----------------------------------------------------------------------
OK, let's conclude that it is fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-04 06:50 pcmcginty      New Issue                                    
12-26-04 06:50 pcmcginty      Distribution              => Arch Linux      
12-26-04 06:50 pcmcginty      Kernel Version            => 2.6.10          
12-26-04 06:51 pcmcginty      Issue Monitored: pcmcginty                    
12-27-04 15:12 tiwai          Note Added: 0002961                          
12-27-04 19:26 pcmcginty      File Added: codec97#0_2.6.7                    
12-27-04 19:26 pcmcginty      File Added: codec97#0_2.6.10                    
12-27-04 19:28 pcmcginty      Note Added: 0002973                          
01-12-05 13:57 JonathanL      Issue Monitored: JonathanL                    
01-12-05 14:13 JonathanL      Note Added: 0003163                          
01-12-05 14:16 JonathanL      File Added: codec97#0_cvs_jonathanl               
    
01-12-05 15:02 tiwai          Note Added: 0003164                          
01-12-05 15:03 tiwai          Note Added: 0003165                          
01-12-05 15:04 tiwai          Note Added: 0003166                          
01-12-05 16:01 JonathanL      File Added: kernel-2.6.7                     
01-12-05 16:02 JonathanL      File Added: kernel-2.6.10_alsa-cvs                
   
01-12-05 16:13 JonathanL      Note Added: 0003174                          
01-12-05 20:45 tiwai          Note Added: 0003178                          
01-12-05 23:23 JonathanL      File Added: sub0                             
01-12-05 23:23 JonathanL      Note Added: 0003180                          
01-13-05 12:53 tiwai          Note Added: 0003184                          
01-22-05 02:02 bengan         Note Added: 0003371                          
01-22-05 02:03 bengan         Note Edited: 0003371                         
01-22-05 02:12 bengan         Note Edited: 0003371                         
01-23-05 01:38 JonathanL      Note Added: 0003384                          
01-27-05 18:20 spr            Issue Monitored: spr                         
01-27-05 18:22 spr            Note Added: 0003421                          
09-15-05 15:18 jdthood        Note Added: 0006207                          
09-15-05 20:29 spr            Note Added: 0006221                          
09-16-05 16:29 jdthood        Note Added: 0006245                          
09-18-05 23:30 JonathanL      Note Added: 0006273                          
09-19-05 09:12 jdthood        Status                   new => resolved     
09-19-05 09:12 jdthood        Resolution               open => fixed       
09-19-05 09:12 jdthood        Assigned To               => jdthood         
09-19-05 09:12 jdthood        Note Added: 0006275                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
