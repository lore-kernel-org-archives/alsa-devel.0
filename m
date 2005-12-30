From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001295]: async capture doesn't seem to work
Date: Fri, 30 Dec 2005 23:48:30 +0100
Message-ID: <241b617636f2478ede9cd378409496f0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 27706168
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:48:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1295> 
======================================================================
Reported By:                arunarunarun
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1295
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-31-2005 22:28 CEST
Last Modified:              12-30-2005 23:48 CET
======================================================================
Summary:                    async capture doesn't seem to work
Description: 
I've got a little program up at
http://nemesis.accosted.net/misc/capture2.cpp that initialises pcm for
capture, sets up an async callback and then busy-waits. The callback never
gets called, even though everything else seems to be going fine. Any help
would be appreciated.
======================================================================

----------------------------------------------------------------------
 arunarunarun - 09-06-05 09:16 
----------------------------------------------------------------------
Hi there,
Remember me? Ford_Prefect on Freenode. Could you please help me find the
correct assignee for this bug? Thanks in advance!

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:48 
----------------------------------------------------------------------
Any improvement in later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-31-05 22:28 arunarunarun   New Issue                                    
07-31-05 22:28 arunarunarun   File Added: capture.cpp                      
09-06-05 09:09 arunarunarun   Issue Monitored: arunarunarun                    
09-06-05 09:16 arunarunarun   Issue Monitored: jcdutton                    
09-06-05 09:16 arunarunarun   Note Added: 0006042                          
12-30-05 23:48 rlrevell       Note Added: 0007298                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
