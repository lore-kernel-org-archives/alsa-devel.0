From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000651]: via82xxx No Sound Kernel 2.6.10-rc2
Date: Thu, 18 Nov 2004 19:48:55 +0100
Message-ID: <98884a2646c930a39476942b40d1db73@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C0371205
	for <alsa-devel@alsa-project.org>; Thu, 18 Nov 2004 19:48:55 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=651> 
======================================================================
Reported By:                glen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   651
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.0 + Dropline Gnome 2.8.0
Kernel Version:             2.6.10-rc2
======================================================================
Date Submitted:             11-17-2004 19:03 CET
Last Modified:              11-18-2004 19:48 CET
======================================================================
Summary:                    via82xxx No Sound Kernel 2.6.10-rc2
Description: 
Upgraded to kernel 2.6.10-rc2 from 2.6.10-rc1 with identical config.  No
compile problems.  No boot up problems.  No sound.
======================================================================

----------------------------------------------------------------------
 glen - 11-17-04 19:05 
----------------------------------------------------------------------
Added output from lspci.

----------------------------------------------------------------------
 tiwai - 11-18-04 19:48 
----------------------------------------------------------------------
What is the exact symptom?  Is the playback DMA working?

More info required, too, for example, the mixer configuration
(/etc/asound.state) and codec information (/proc/asound/card0/codec97#0/*
files).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-04 19:03 glen           New Issue                                    
11-17-04 19:03 glen           File Added: config-2.6.10-rc2                    
11-17-04 19:03 glen           Distribution              => Slackware 10.0 +
Dropline Gnome 2.8.0
11-17-04 19:03 glen           Kernel Version            => 2.6.10-rc2      
11-17-04 19:05 glen           Note Added: 0002439                          
11-17-04 19:06 glen           File Added: lspci.txt                        
11-18-04 19:48 tiwai          Note Added: 0002466                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
