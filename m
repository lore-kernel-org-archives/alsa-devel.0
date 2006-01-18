From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001664]: GTK2-patch for envy24control
Date: Wed, 18 Jan 2006 21:49:47 +0100
Message-ID: <b253308bcc0acf8207989a9d0b60ea3b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AF65A154
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2006 21:49:47 +0100 (MET)
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
Last Modified:              01-18-2006 21:49 CET
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

----------------------------------------------------------------------
 HaroldAling - 01-18-06 21:49 
----------------------------------------------------------------------
This is great!

I just needed to remove the alsa-tools/ prefix since the alsa-tools
package unpacks in alsa-tools-1.0.10/.

I'm about to file a bug(/featurerequest) in bugs.gentoo.org to get this
patch included into portage...

ALSA-devs: when is this going into the alsa-tools package???

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-05 01:56 electropura    New Issue                                    
12-21-05 01:56 electropura    File Added: envy24control-gtk2.patch              
     
01-18-06 21:49 HaroldAling    Note Added: 0007713                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
