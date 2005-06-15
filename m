From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000578]:  No soundcard detected on Chaintech 9CJS
Date: Wed, 15 Jun 2005 15:30:38 +0200
Message-ID: <2779d234dedf01099d88dc13e5c046d1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1DF2A1D9
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2005 15:30:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=578> 
======================================================================
Reported By:                tarsi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   578
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     acknowledged
Distribution:               mandrake linux 10.1
Kernel Version:             2.6.8.1-10mdksmp
======================================================================
Date Submitted:             10-11-2004 12:58 CEST
Last Modified:              06-15-2005 15:30 CEST
======================================================================
Summary:                     No soundcard detected on Chaintech 9CJS
Description: 
 cat /proc/asound/cards don't stop and gives many lines "--no souncards--"

/etc/init.d/alsaconf found ice1724 card, but exiting gives:
.... 

/usr/sbin/alsactl: save_state:1066: No soundcards found...

======================================================================

----------------------------------------------------------------------
 tiwai - 04-19-05 18:15 
----------------------------------------------------------------------
The noise problem might have been fixed recently.  Try 1.0.9rc2.

The latest ice1724 driver already has an entry for Chaintech 9CJS.  So,
please make sure that the driver does _NOT_ work with the latest ALSA.

If the model=k8x800 works, it's simple to fix.  Please show the output of
lspci -nv.

----------------------------------------------------------------------
 tiwai - 06-15-05 15:30 
----------------------------------------------------------------------
Ping.  Any answer?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-11-04 12:58 tarsi          New Issue                                    
10-11-04 12:58 tarsi          File Added: command-outputs.tar.bz2               
    
10-11-04 12:58 tarsi          Distribution              => mandrake linux 10.1
10-11-04 12:58 tarsi          Kernel Version            => 2.6.8.1-10mdksmp
10-11-04 12:58 tarsi          Issue Monitored: tarsi                       
10-11-04 15:59 tiwai          Note Added: 0002081                          
04-09-05 16:09 jdthood        Note Added: 0004407                          
04-14-05 12:53 tarsi          Note Added: 0004491                          
04-14-05 22:00 jdthood        Note Added: 0004496                          
04-14-05 22:00 jdthood        Severity                 block => major      
04-14-05 22:00 jdthood        Status                   new => acknowledged 
04-14-05 22:00 jdthood        Additional Information Updated                    
04-19-05 18:15 tiwai          Note Added: 0004533                          
06-15-05 15:30 tiwai          Note Added: 0005034                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
