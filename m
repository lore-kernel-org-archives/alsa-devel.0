From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001664]: GTK2-patch for envy24control
Date: Wed, 21 Dec 2005 01:56:17 +0100
Message-ID: <003e47e27330501201ca78d882bb667d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 238521A6
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2005 01:56:18 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1664> 
======================================================================
Reported By:                electropura
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   1664
Category:                   envy24control
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             12-21-2005 01:56 CET
Last Modified:              12-21-2005 01:56 CET
======================================================================
Summary:                    GTK2-patch for envy24control
Description: 
Here is a simple patch to make it convenient to link envy24control against
GTK2.
This is essentially from a patch I found via google some year ago. I can't
find it anymore, so I don't know who made it in the first place.

I also changed the policy for scrolled windows from GTK_POLICY_ALWAYS to
GTK_POLICY_AUTOMATIC. This makes it look much nicer with cards that have
fewer channels (like m-audio audiophile).

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-05 01:56 electropura    New Issue                                    
12-21-05 01:56 electropura    File Added: envy24control-gtk2.patch              
     
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
