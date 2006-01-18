From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001486]: headphone control disappeared
Date: Wed, 18 Jan 2006 09:12:10 +0100
Message-ID: <cfc0960e2ea13ac16c90de3c8691ad67@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6777D158
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2006 09:12:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1486> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1486
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             10-20-2005 11:07 CEST
Last Modified:              01-18-2006 09:12 CET
======================================================================
Summary:                    headphone control disappeared
Description: 
The submitter of Ubuntu bug report 18024 reports that the "Headphone"
control disappeared when he upgraded from linux-image-2.6.10-5-386
(2.6.10-34.7, from
hoary) to linux-image-2.6.12-9-386 (2.6.12-9.23, breezy).

$cat /proc/asound/cards
0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
                     Intel 82801DB-ICH4 with STAC9750,51 at 0xfaeff800,
irq 7

See

    http://bugzilla.ubuntu.com/show_bug.cgi?id=18024

for additional info.
======================================================================

----------------------------------------------------------------------
 jdthood - 01-17-06 17:57 
----------------------------------------------------------------------
There is a "Phone" control.  Am I right in assuming that this means
"Telephone"?

----------------------------------------------------------------------
 apeeters - 01-18-06 09:12 
----------------------------------------------------------------------
I guess it is, but it has nothing to do with Headphone, it only appears as
a capture control.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-20-05 11:07 jdthood        New Issue                                    
10-20-05 12:58 apeeters       Issue Monitored: apeeters                    
10-20-05 14:51 tiwai          Note Added: 0006503                          
11-06-05 16:58 apeeters       Note Added: 0006607                          
11-06-05 16:58 apeeters       File Added: alsa_headphone                    
11-08-05 18:34 tiwai          Note Added: 0006633                          
11-08-05 18:34 tiwai          File Added: ac97-check-fix.diff                   

11-09-05 13:44 apeeters       Note Added: 0006650                          
11-09-05 13:47 tiwai          Note Added: 0006651                          
11-09-05 13:57 apeeters       Note Added: 0006652                          
01-04-06 14:40 jdthood        Note Added: 0007421                          
01-17-06 17:56 jdthood        Note Added: 0007701                          
01-17-06 17:57 jdthood        Note Added: 0007702                          
01-18-06 09:12 apeeters       Note Added: 0007708                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
