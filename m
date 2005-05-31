From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000980]: nforce4/alc850 line-in -> spdif out - solution ???
Date: Tue, 31 May 2005 18:03:36 +0200
Message-ID: <a47b8d0874c6a7a211c7160151bcf64d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 456051D5
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:36 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=980> 
======================================================================
Reported By:                dobromir
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   980
Category:                   PCI - intel8x0m
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-11-2005 01:17 CET
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    nforce4/alc850 line-in -> spdif out - solution ???
Description: 
I found in the alc850 spec that setting 12th bit in register 0x6a routes to
spdif all data from ADC. I write small program that sets this register,
and this works for me, but I use only 2 speakers configuration.
Unfortunately I don't have enough 
knowledge of alsa architecture to write a proper patch.
======================================================================

----------------------------------------------------------------------
 dobromir - 03-11-05 16:44 
----------------------------------------------------------------------
Yes, it works. Thank You for your help.

----------------------------------------------------------------------
 tiwai - 03-11-05 16:48 
----------------------------------------------------------------------
Thanks for the confirmation.  Applied to CVS.

BTW, you don't need to write a program to change the AC97 registers on the
fly.  You can do it by writing to proc file ac97#0-0+regs.  See
alsa-kernel/Documentation/Procfile.txt for details.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-05 01:17 dobromir       New Issue                                    
03-11-05 08:27 dobromir       Note Added: 0003880                          
03-11-05 10:19 dobromir       File Added: alc_850_mixer.patch                   

03-11-05 10:24 dobromir       Note Added: 0003883                          
03-11-05 12:11 tiwai          Note Added: 0003884                          
03-11-05 16:08 dobromir       Note Added: 0003889                          
03-11-05 16:15 tiwai          Note Added: 0003890                          
03-11-05 16:16 tiwai          File Added: alc655-spdif-route-fix.diff           
        
03-11-05 16:44 dobromir       Note Added: 0003892                          
03-11-05 16:48 tiwai          Status                   assigned => resolved
03-11-05 16:48 tiwai          Resolution               open => fixed       
03-11-05 16:48 tiwai          Note Added: 0003893                          
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
