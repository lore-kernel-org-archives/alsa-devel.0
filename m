From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000748]: Kernel 2.6.9 and 2.6.10 makes sound of Ali 5455 chipset choppy, plays to fast
Date: Wed, 12 Jan 2005 16:13:05 +0100
Message-ID: <ac68a900e9009a6f6e7b33639451ab8c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 331F4329
	for <alsa-devel@alsa-project.org>; Wed, 12 Jan 2005 16:13:06 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=748> 
======================================================================
Reported By:                pcmcginty
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   748
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Arch Linux
Kernel Version:             2.6.10
======================================================================
Date Submitted:             12-26-2004 06:50 CET
Last Modified:              01-12-2005 16:13 CET
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
 tiwai - 01-12-05 15:04 
----------------------------------------------------------------------
Please recreate the file attached there.  It contains all zero-size files. 
You can't create tar from proc files...

----------------------------------------------------------------------
 JonathanL - 01-12-05 16:13 
----------------------------------------------------------------------
I've tried version 1.0.5a and 1.0.6a with a kernel 2.6.7, and
1.0.7,1.0.8_rc1,1.0.8_rc2 and cvs(today) with a kernel 2.6.10 (I cannot
compile 1.0.5a with 2.6.10)

working versions are :
1.0.5a + 2.6.7
2.6.7 + modules included in the kernel 2.6.7 distribution

I've re-attached the files

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
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
