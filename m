From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000387]: No soundcard detected on Chaintech ZNF3-250
Date: Fri, 22 Oct 2004 17:02:33 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a7d08bc54afcd5bccee3699b818e445d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 07FDD2AA
	for <alsa-devel@alsa-project.org>; Fri, 22 Oct 2004 17:02:33 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=387> 
======================================================================
Reported By:                silent_runner
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   387
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.7 kernel.org stock
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             07-13-2004 21:48 CEST
Last Modified:              10-22-2004 17:02 CEST
======================================================================
Summary:                    No soundcard detected on Chaintech ZNF3-250
Description: 
cat /proc/asound/cards gives --no souncards--
======================================================================

----------------------------------------------------------------------
 tiwai - 07-30-04 17:03 
----------------------------------------------------------------------
Try the attached patch (to cvs version)?

----------------------------------------------------------------------
 perex - 10-22-04 17:02 
----------------------------------------------------------------------
No response from user.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 21:48 silent_runner  New Issue                                    
07-13-04 21:48 silent_runner  File Added: command-outputs.tar.bz2               
    
07-13-04 21:48 silent_runner  Distribution              => Gentoo          
07-13-04 21:48 silent_runner  Kernel Version            => 2.6.7 kernel.org
stock
07-13-04 22:18 silent_runner  Issue Monitored: silent_runner                    
07-27-04 13:50 silent_runner  Issue Monitored: perex                       
07-27-04 13:50 silent_runner  Note Added: 0001476                          
07-30-04 17:03 tiwai          Note Added: 0001494                          
07-30-04 17:03 tiwai          File Added: chaintech.dif                    
10-22-04 17:02 perex          Status                   new => resolved     
10-22-04 17:02 perex          Resolution               open => suspended   
10-22-04 17:02 perex          Assigned To               => perex           
10-22-04 17:02 perex          Note Added: 0002251                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
