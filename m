From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002093]: Mute mixer software switch not working
Date: Tue, 2 May 2006 20:17:51 +0200
Message-ID: <3a653ae9ad099781b4cd176f8fd20ad2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DFA4D1AC
	for <alsa-devel@alsa-project.org>; Tue,  2 May 2006 20:17:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2093> 
======================================================================
Reported By:                fdoffizi01
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2093
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             05-02-2006 19:41 CEST
Last Modified:              05-02-2006 20:17 CEST
======================================================================
Summary:                    Mute mixer software switch not working
Description: 
Trying to mute Master output from mixer (kmix, alsamixer and so on...) I
got no results, sound continue to be played as if channel is muted.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001890 Only the PCM channel in alsa mixer, unm...
======================================================================

----------------------------------------------------------------------
 tiwai - 05-02-06 20:01 
----------------------------------------------------------------------
Try the uploaded patch.

----------------------------------------------------------------------
 fdoffizi01 - 05-02-06 20:17 
----------------------------------------------------------------------
It works, now. Great. (I noticed applying this patch it disappear a
controller I had before (maybe cdrom one if I remember well, not know if
it worked or was useful, just to tell you about it...)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-02-06 19:41 fdoffizi01     New Issue                                    
05-02-06 20:00 tiwai          Relationship added       related to 0001890  
05-02-06 20:01 tiwai          File Added: vaio-master-sw-fix.diff               
    
05-02-06 20:01 tiwai          Note Added: 0009575                          
05-02-06 20:17 fdoffizi01     Note Added: 0009576                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
