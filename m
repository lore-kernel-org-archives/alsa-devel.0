From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002093]: Mute mixer software switch not working
Date: Wed, 3 May 2006 12:00:02 +0200
Message-ID: <5201cc933f271d9d57cff41a8f1a31e4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1BED7170
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 12:00:03 +0200 (MEST)
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


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-02-2006 19:41 CEST
Last Modified:              05-03-2006 12:00 CEST
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
 fdoffizi01 - 05-02-06 20:17 
----------------------------------------------------------------------
It works, now. Great. (I noticed applying this patch it disappear a
controller I had before (maybe cdrom one if I remember well, not know if
it worked or was useful, just to tell you about it...)

----------------------------------------------------------------------
 tiwai - 05-03-06 12:00 
----------------------------------------------------------------------
Committed to Hg repo.

The CD capture switch had been already removed in 1.0.11 release.  It
never worked.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-02-06 19:41 fdoffizi01     New Issue                                    
05-02-06 20:00 tiwai          Relationship added       related to 0001890  
05-02-06 20:01 tiwai          File Added: vaio-master-sw-fix.diff               
    
05-02-06 20:01 tiwai          Note Added: 0009575                          
05-02-06 20:17 fdoffizi01     Note Added: 0009576                          
05-03-06 12:00 tiwai          Status                   assigned => resolved
05-03-06 12:00 tiwai          Resolution               open => fixed       
05-03-06 12:00 tiwai          Note Added: 0009591                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
