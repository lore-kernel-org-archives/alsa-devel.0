From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000750]: no sound since 2.6.8.1
Date: Tue, 25 Jan 2005 15:22:41 +0100
Message-ID: <31b1e5422d8e094266705d475b5ca4d4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 649321AF
	for <alsa-devel@alsa-project.org>; Tue, 25 Jan 2005 15:22:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=750> 
======================================================================
Reported By:                aquarichy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   750
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10
Kernel Version:             2.6.9+
======================================================================
Date Submitted:             12-28-2004 02:20 CET
Last Modified:              01-25-2005 15:22 CET
======================================================================
Summary:                    no sound since 2.6.8.1
Description: 
Sound using a kernel.org 2.6.8.1 kernel with ALSA built-in worked.  When I
compile  any newer stable kernel, there is no sound.  Compilation executes
without complaints.  No Sound related options change.  I have even tried
saying No to all the new options 2.6.9 and .10 provided in fear that one
of those might be interfering, but nada.  
======================================================================

----------------------------------------------------------------------
 FrankS - 01-24-05 04:10 
----------------------------------------------------------------------
I have the same system, and am seeing the same problem on debian
distributions.  If I add a file to my /etc/modprobe.d that sets the
ac97_quirk=0 option, life is wonderful and there is sound.  I searched for
other files setting this option and found none.  I downloaded and compiled
other versions of the alsa drivers, for me  it broke between 1.0.5a and
1.0.6rc1 (kernel 2.6.7 ). I did not verify the fix on .6rc1, but I did on
.6a.  The fix worked on both MEPIS and Ubuntu beta releaes.  I have
several test partitions setup, and would be more than willing to test any
potential fixes and or run experiments.

Frank

----------------------------------------------------------------------
 tiwai - 01-25-05 15:22 
----------------------------------------------------------------------
Looks like the PCI sub ID confliction.  There is already the quirk entry
for ECS L7VMM2.  The h/w vendor assigned the identical ID without deep
consideration...

Sorry, no way to avoid this as default as the system appears identical
from the driver side.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-28-04 02:20 aquarichy      New Issue                                    
12-28-04 02:20 aquarichy      Distribution              => Slackware 10    
12-28-04 02:20 aquarichy      Kernel Version            => 2.6.9+          
12-29-04 08:23 aquarichy      Note Added: 0002993                          
12-29-04 14:12 tiwai          Note Added: 0002996                          
12-29-04 19:02 aquarichy      Note Added: 0003007                          
12-29-04 19:17 aquarichy      Note Added: 0003008                          
12-29-04 19:37 aquarichy      Note Added: 0003009                          
12-29-04 20:39 aquarichy      Note Added: 0003011                          
12-29-04 20:46 rlrevell       Note Added: 0003012                          
12-30-04 00:07 aquarichy      Note Added: 0003015                          
12-30-04 06:05 aquarichy      Note Edited: 0003015                         
12-30-04 06:36 aquarichy      Note Added: 0003017                          
12-30-04 13:02 tiwai          Note Added: 0003018                          
12-31-04 06:30 aquarichy      Note Added: 0003024                          
01-03-05 12:07 tiwai          Note Added: 0003053                          
01-03-05 20:30 aquarichy      Note Added: 0003074                          
01-24-05 04:10 FrankS         Note Added: 0003389                          
01-25-05 15:22 tiwai          Note Added: 0003403                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
