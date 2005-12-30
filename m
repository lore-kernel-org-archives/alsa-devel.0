From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000206]: Segmentation fault when trying to start envy24control
Date: Fri, 30 Dec 2005 04:03:07 +0100
Message-ID: <35507f8b69ac05a5f5bc47ef8ffeb429@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AC19C19E
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 04:03:07 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=206> 
======================================================================
Reported By:                vulture99
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   206
Category:                   envy24control
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-13-2004 04:56 CEST
Last Modified:              12-30-2005 04:03 CET
======================================================================
Summary:                    Segmentation fault when trying to start
envy24control
Description: 
envy24control was working fine for me yesterday (not sure which version of
alsa I was using - probably 1.0.3 or 1.0.2).  Today I updated to 1.0.4 via
apt-get using the standard Fedora packages from the kernel.org mirror, and
when I try to run envy24control, I get a segmentation fault.  I am using
an M-Audio Audiophile 2496 sound card.
======================================================================

----------------------------------------------------------------------
 tiwai - 12-07-04 18:36 
----------------------------------------------------------------------
Yes, the culprit seems different because -m option was introduced far after
this original report.

----------------------------------------------------------------------
 rlrevell - 12-30-05 04:03 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-13-04 04:56 vulture99      New Issue                                    
04-13-04 04:58 vulture99      Note Added: 0000786                          
04-13-04 22:37 vulture99      Note Added: 0000799                          
04-16-04 12:03 tiwai          Note Added: 0000835                          
12-05-04 12:44 shadow         Note Added: 0002720                          
12-07-04 18:36 tiwai          Note Added: 0002756                          
12-30-05 04:03 rlrevell       Note Added: 0007198                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
