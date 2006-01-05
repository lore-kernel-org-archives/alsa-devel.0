From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001228]: Skype Does not work with aoss
Date: Thu, 5 Jan 2006 21:40:08 +0100
Message-ID: <245f1eb500b9ea4064c6e5bb106591f9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 00281135
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2006 21:40:08 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1228> 
======================================================================
Reported By:                hil
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1228
Category:                   
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-03-2005 09:09 CEST
Last Modified:              01-05-2006 21:40 CET
======================================================================
Summary:                    Skype Does not work with aoss
Description: 
I downloaded alsa-oss-1.0.9rc2 and install by
# ./configure --with-aoss=yes && make && make install
as root. Virtually every program works except skype
(http://www.skype.com/) version 1.1.0.13_API. I downloaded the Fedora
version of skype from the skype official website. Skype only uses
/dev/dsp. I guess skype uses /dev/dsp as microphone input as well. I could
not hear anything and the microphone did not work as well if I run  skype
like aoss /usr/bin/skype. If I run skype without aoss, then skype works
just fine.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001224 artsd-like style
======================================================================

----------------------------------------------------------------------
 Hetfield - 01-05-06 21:36 
----------------------------------------------------------------------
broken in 2.6.15 and alsa-* 1.0.10

----------------------------------------------------------------------
 rlrevell - 01-05-06 21:40 
----------------------------------------------------------------------
We need more information about the exact hardware and ALSA version in use
because some people are reporting this works perfectly for them.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-05 09:09 hil            New Issue                                    
08-09-05 15:33 rapand         Note Added: 0005732                          
08-10-05 00:49 rlrevell       Relationship added       duplicate of 0001224
08-10-05 00:50 rlrevell       Note Added: 0005740                          
12-31-05 00:19 rlrevell       Note Added: 0007315                          
01-02-06 18:54 rlrevell       Relationship deleted     duplicate of 0001224
01-02-06 18:55 rlrevell       Relationship added       related to 0001224  
01-02-06 18:56 rlrevell       Note Added: 0007375                          
01-05-06 21:36 Hetfield       Note Added: 0007479                          
01-05-06 21:40 rlrevell       Note Added: 0007480                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
