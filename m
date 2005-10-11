From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001451]: SPDF and Line out simultaneously
Date: Tue, 11 Oct 2005 21:30:35 +0200
Message-ID: <a010b55986c095d6ea84a1b10eaa66aa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2011F18E
	for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2005 21:30:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1451> 
======================================================================
Reported By:                anli
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1451
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-24-2005 15:46 CEST
Last Modified:              10-11-2005 21:30 CEST
======================================================================
Summary:                    SPDF and Line out simultaneously
Description: 
I tried to get the answer from user and dev lists to this question: how to
configure the driver to make SPDF and Line-out work simultaneously. I was
not lucky to get an answer. I have concluded, it's impossible. So -
reporting the bug.

It is almost impossible to do any serious mastering/editing work without
such opportunity.
======================================================================

----------------------------------------------------------------------
 tiwai - 10-11-05 17:24 
----------------------------------------------------------------------
As another thought: it's possible by sharing the same buffer for different
DMAs.  But it may not work reliablly enough...

----------------------------------------------------------------------
 anli - 10-11-05 21:30 
----------------------------------------------------------------------
Takashi,

I'll try to recognize how to do it via multi and route plugins. It will
take some time to learn and try.

Andrew

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-05 15:46 anli           New Issue                                    
10-05-05 19:01 tiwai          Note Added: 0006438                          
10-06-05 17:25 anli           Issue Monitored: anli                        
10-11-05 17:24 tiwai          Note Added: 0006456                          
10-11-05 21:30 anli           Note Added: 0006460                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
