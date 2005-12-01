From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001195]: alsa-lib 1.0.9 crashes artsd
Date: Thu, 1 Dec 2005 16:28:58 +0100
Message-ID: <d82f61b2c2f69db4ba4bf7722b6a5d89@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 029B618F
	for <alsa-devel@alsa-project.org>; Thu,  1 Dec 2005 16:28:58 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1195> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1195
Category:                   0_general
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-15-2005 17:21 CEST
Last Modified:              12-01-2005 16:28 CET
======================================================================
Summary:                    alsa-lib 1.0.9 crashes artsd
Description: 
The submitter of Debian bug report #312577 says that after upgrading his
ALSA library to 1.0.9 his artsd process crashes after a number of hours.

The submitter provided a backtrace which I attach (artsd.crash).
======================================================================

----------------------------------------------------------------------
 tiwai - 06-17-05 14:24 
----------------------------------------------------------------------
The patch is maybe not enough since it fixes only the dmix.  The rest
problem is in rate plugin.  Will check rate plugin later.

The workaround fixes the problem because it skips the rate plugin and it
avoids the mismatch of source/destination period sizes.

----------------------------------------------------------------------
 jdthood - 12-01-05 16:28 
----------------------------------------------------------------------
Has there been any progress on this?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-15-05 17:21 jdthood        New Issue                                    
06-15-05 17:21 jdthood        File Added: artsd.crash                      
06-15-05 17:52 tiwai          Note Added: 0005038                          
06-15-05 17:58 pzad           Note Added: 0005039                          
06-15-05 18:17 tiwai          Note Added: 0005040                          
06-15-05 18:24 jdthood        Note Added: 0005041                          
06-15-05 19:47 tiwai          Note Added: 0005042                          
06-15-05 19:47 tiwai          File Added: dmix-boundary-fix.diff                
   
06-17-05 08:54 jdthood        Note Added: 0005064                          
06-17-05 14:24 tiwai          Note Added: 0005070                          
12-01-05 16:28 jdthood        Note Added: 0006883                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
