From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001634]: lack of mmap support with ice1724
Date: Sat, 10 Dec 2005 09:02:41 +0100
Message-ID: <9dada1a005973ab72c3a37a617051ba0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19751173
	for <alsa-devel@alsa-project.org>; Sat, 10 Dec 2005 09:02:41 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1634> 
======================================================================
Reported By:                joecool
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1634
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.14-mm2
======================================================================
Date Submitted:             12-10-2005 09:02 CET
Last Modified:              12-10-2005 09:02 CET
======================================================================
Summary:                    lack of mmap support with ice1724
Description: 
I've dug around for awhile now as to why my m-audio revolution 7.1 doesn't
work on enemy-territory because of an mmap error, and came to the
conclusion it must be because there is no working mmap support.  So
everything needs to run through arts, which is a poor, high-latency
workaround to a major problem.

This is a confirmable bug that 2 seconds of googling will pull up results.
 I do not want to hear of using a sound server (artsd, esd, jackd, etc.)
as a workaround.  However, if the mmap support can be emulated driver
level, then that would be fine.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 09:02 joecool        New Issue                                    
12-10-05 09:02 joecool        Distribution              => Gentoo Linux    
12-10-05 09:02 joecool        Kernel Version            => 2.6.14-mm2      
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
