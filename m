From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001679]: Audigy 4 SE (SB_0570, ca0106) does not work correctly.
Date: Sun, 25 Dec 2005 21:54:40 +0100
Message-ID: <32a129f6d30513e17537821e22efaeea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7DAAA150
	for <alsa-devel@alsa-project.org>; Sun, 25 Dec 2005 21:54:40 +0100 (MET)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1679> 
======================================================================
Reported By:                moriak
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1679
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               standard
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-25-2005 17:05 CET
Last Modified:              12-25-2005 21:54 CET
======================================================================
Summary:                    Audigy 4 SE (SB_0570, ca0106) does not work
correctly.
Description: 
There is no sound, only noise (when sound must play), and somewhy it
detects as SB Audigy LS.
======================================================================

----------------------------------------------------------------------
 jcdutton - 12-25-05 21:54 
----------------------------------------------------------------------
You are correct. You sound card is not recognised, which is probably why it
does not work. We already have a fix for this problem, and in will be
fixed in alsa-driver 1.0.11rc2 or above, or in the current alsa-driver
CVS.


Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-25-05 17:05 moriak         New Issue                                    
12-25-05 17:05 moriak         Distribution              => standard        
12-25-05 17:05 moriak         Kernel Version            => 2.6.9           
12-25-05 21:54 jcdutton       Note Added: 0007145                          
12-25-05 21:54 jcdutton       Status                   assigned => feedback
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
