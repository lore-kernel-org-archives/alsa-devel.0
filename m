From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001539]: alsa-lib make check: omixer does not build
Date: Thu, 22 Dec 2005 02:10:58 +0100
Message-ID: <6084d140eab064f17a8b434238c793df@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3550E1B9
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2005 02:10:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1539> 
======================================================================
Reported By:                Flameeyes
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - utils
Issue ID:                   1539
Category:                   aconnect
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-10-2005 12:37 CET
Last Modified:              12-22-2005 02:10 CET
======================================================================
Summary:                    alsa-lib make check: omixer does not build
Description: 
make check for alsa-lib does not complete correctly, as the omixer.c source
file does not build at all.

It tries to include mixer_ordinary.h header that is not present on alsa
1.0.10_rc3 (but it's present on 1.0.9), and then tries to use sndo_*
functions that are in that file). If that is gone, the test should go
away, too. I've worked this around on Portage by removing omixer test
entirely.

HTH,
Diego
======================================================================

----------------------------------------------------------------------
 Flameeyes - 12-22-05 02:01 
----------------------------------------------------------------------
Can someone close this? it's fixed in 1.0.11_rc1

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-10-05 12:37 Flameeyes      New Issue                                    
11-30-05 23:38 gjasny         Issue Monitored: gjasny                      
12-22-05 02:01 Flameeyes      Note Added: 0007115                          
12-22-05 02:10 rlrevell       Status                   new => resolved     
12-22-05 02:10 rlrevell       Resolution               open => fixed       
12-22-05 02:10 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
