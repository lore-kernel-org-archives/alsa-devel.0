From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000591]: Please allow control of shm gid
Date: Mon, 30 May 2005 12:55:46 +0200
Message-ID: <b3b48fe6b6ddb1e2ace27feb9fcb4599@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C815318B
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 12:55:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=591> 
======================================================================
Reported By:                jdthood
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   591
Category:                   general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             10-21-2004 10:49 CEST
Last Modified:              05-30-2005 12:55 CEST
======================================================================
Summary:                    Please allow control of shm gid
Description: 
A Debian user requested:

> ALSA provides options to specify shm permissions, but it 
> is currently not possible to specify a shm gid.
> So, if I want to use dmix system-wide I have to use 
> shm_perm 0666, but I'd rather use shm_perm 0660 and 
> shm_gid audio if that were possible.

Please see Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=277539 "Please allow
control of shm gid" for
the whole submission.

    http://bugs.debian.org/277539
======================================================================

----------------------------------------------------------------------
 perex - 05-30-05 12:19 
----------------------------------------------------------------------
I have added ipc_gid support to alsa-lib. Could you test it?

----------------------------------------------------------------------
 jdthood - 05-30-05 12:55 
----------------------------------------------------------------------
Where and when will the new feature appear?  E.g.: CVS, tomorrow?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-21-04 10:49 jdthood        New Issue                                    
10-21-04 17:25 Tobias DiedrichIssue Monitored: Tobias Diedrich                  
 
05-30-05 12:19 perex          Note Added: 0004801                          
05-30-05 12:19 perex          Assigned To               => perex           
05-30-05 12:19 perex          Status                   new => feedback     
05-30-05 12:55 jdthood        Note Added: 0004804                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
