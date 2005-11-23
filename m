From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001573]: Automatically add card number to ipc_key?
Date: Wed, 23 Nov 2005 18:01:48 +0100
Message-ID: <78074497dfad9fc98fecdac2e432c7ef@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 089B71B1
	for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 18:01:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1573> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1573
Category:                   0_general
Reproducibility:            always
Severity:                   feature
Priority:                   low
Status:                     new
======================================================================
Date Submitted:             11-17-2005 17:30 CET
Last Modified:              11-23-2005 18:01 CET
======================================================================
Summary:                    Automatically add card number to ipc_key?
Description: 
In Debian bug report 335046 the submitter has two cards and wants to use
two instances of dmix, one for each.  It would be nice if the ipc_key was
automatically set to a different value for each card so that the user
could make use of the standard dmix definition; this feature could be
controlled with a ipc_key_add_card option.  For this to be compatible with
the ipc_key_add_uid, the uid could be added after a <<3 shift (assuming
that there can only be eight sound cards).

Another possibility is some sort of function.  If you have an idea of how
this could be implemented, please let me know.
======================================================================

----------------------------------------------------------------------
 tiwai - 11-23-05 18:01 
----------------------------------------------------------------------
Well, this is not too easy as it sounds.  To get a card number, we have to
open a slave PCM, but ipc key is required before opening the slave PCM.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 17:30 jdthood        New Issue                                    
11-23-05 18:01 tiwai          Note Added: 0006822                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
