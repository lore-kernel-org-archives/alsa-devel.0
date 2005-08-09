From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001068]: enable dmix by default
Date: Tue, 9 Aug 2005 13:44:19 +0200
Message-ID: <69e47b36d7cd86a7fcb02f51f275e6f8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5A08F1BD
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:44:19 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1068> 
======================================================================
Reported By:                mandreiana
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   1068
Category:                   2_mixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-21-2005 06:49 CEST
Last Modified:              08-09-2005 13:44 CEST
======================================================================
Summary:                    enable dmix by default
Description: 
Please see this bug report:
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155421

Someone suggested to change /etc/asound.conf so dmix is turned on, but
please enable it by default.
======================================================================

----------------------------------------------------------------------
 pzad - 05-24-05 09:35 
----------------------------------------------------------------------
dmix should be enabled for all cheap motherboards cards (except I think
envy24 based cards).

What other cards do you have ?

----------------------------------------------------------------------
 perex - 05-30-05 12:54 
----------------------------------------------------------------------
The sympthom has been resolved. Please, create another bug, if something
does not work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-05 06:49 mandreiana     New Issue                                    
04-21-05 07:59 pzad           Note Added: 0004546                          
04-21-05 08:39 mandreiana     Note Added: 0004547                          
04-21-05 08:42 mandreiana     Note Added: 0004548                          
04-29-05 09:08 mandreiana     Note Added: 0004578                          
05-24-05 09:29 Martin Pitt    Note Added: 0004707                          
05-24-05 09:35 pzad           Note Added: 0004708                          
05-30-05 12:54 perex          Status                   new => resolved     
05-30-05 12:54 perex          Resolution               open => fixed       
05-30-05 12:54 perex          Assigned To               => perex           
05-30-05 12:54 perex          Note Added: 0004803                          
08-09-05 13:44 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
