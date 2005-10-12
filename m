From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001450]: SPDIF out is limited with 48KHz
Date: Wed, 12 Oct 2005 12:39:06 +0200
Message-ID: <3280dfdd594494d5f0f5a037667a0a71@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DFB8B197
	for <alsa-devel@alsa-project.org>; Wed, 12 Oct 2005 12:39:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1450> 
======================================================================
Reported By:                anli
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1450
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-24-2005 15:33 CEST
Last Modified:              10-12-2005 12:39 CEST
======================================================================
Summary:                    SPDIF out is limited with 48KHz
Description: 
Last the driver version which worked perfectly (i.e. with 96KHz SPDIF out
sample rate) is 1.04. And I was able to use SPDIF out with JACK at
96KHz/32bit mode _without_ any problems.

Now SPDIF out is limited with 48KHz srate. Long time ago developers
argumented 48KHz limit as it is SPDIF standard. On the other hand all
(semi)pro DACs suuport 96KHz. This is true for all ice1724 cards too.
Moreover, we are in the open source world at last :-)

Please, revert this limit back. I'm ready to test the driver from CVS
tree.

Andrew

======================================================================

----------------------------------------------------------------------
 anli - 10-11-05 21:23 
----------------------------------------------------------------------
Takashi,

I have applayed the patch, and - it is incredible! - 96KHz works: I have
loopbacked SPDIF out to SPDIF input, started JACK and jaaa, and now I am
observing at jaaa screen an accuracy of this SPDIF loopback :-)

Big-big thanks!

Andrew

----------------------------------------------------------------------
 tiwai - 10-12-05 12:39 
----------------------------------------------------------------------
Thanks for confirmation.  It's on CVS now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-05 15:33 anli           New Issue                                    
10-05-05 19:07 tiwai          Note Added: 0006441                          
10-06-05 16:36 anli           Note Added: 0006443                          
10-06-05 16:40 anli           Note Added: 0006444                          
10-06-05 17:14 anli           Note Edited: 0006443                         
10-06-05 17:25 anli           Issue Monitored: anli                        
10-06-05 20:40 anli           Note Edited: 0006444                         
10-07-05 11:16 anli           Note Edited: 0006443                         
10-11-05 17:22 tiwai          Note Added: 0006455                          
10-11-05 17:23 tiwai          File Added: ice1724-spdif-rate-fix.diff           
        
10-11-05 21:23 anli           Note Added: 0006459                          
10-12-05 12:39 tiwai          Status                   new => resolved     
10-12-05 12:39 tiwai          Resolution               open => fixed       
10-12-05 12:39 tiwai          Assigned To               => tiwai           
10-12-05 12:39 tiwai          Note Added: 0006462                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
