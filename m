From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000276]: envy24control crash
Date: Sat, 19 Mar 2005 19:44:00 +0100
Message-ID: <542a85dc6df1dab0e11a93ca31bf397e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0AA311FD
	for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2005 19:44:00 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=276> 
======================================================================
Reported By:                BugBuster
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   276
Category:                   envy24control
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-14-2004 19:09 CEST
Last Modified:              03-19-2005 19:44 CET
======================================================================
Summary:                    envy24control crash
Description: 
If you do:
"./envy24control --help" you get a segmentation fault in getopt_long...

======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 09:40 
----------------------------------------------------------------------
Submitter: Is the bug still present?

This should be reassigned to alsa-tools.

----------------------------------------------------------------------
 jdthood - 03-19-05 17:49 
----------------------------------------------------------------------
This was reported fixed in 1.0.7

* alsa-tools
  - envy24control
    - Fixed segfault when envy24control --help is called

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-14-04 19:09 BugBuster      New Issue                                    
05-14-04 19:09 BugBuster      Distribution              => Gentoo          
05-14-04 19:09 BugBuster      Kernel Version            => 2.6.5-gentoo-r1 
03-19-05 09:40 jdthood        Note Added: 0004024                          
03-19-05 17:49 jdthood        Note Added: 0004058                          
03-19-05 19:43 perex          Project                  ALSA - driver => ALSA -
tools
03-19-05 19:44 perex          Status                   new => resolved     
03-19-05 19:44 perex          Resolution               open => fixed       
03-19-05 19:44 perex          Category                 OTHERS => envy24control
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
