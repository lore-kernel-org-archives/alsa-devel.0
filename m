From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000819]: Patch to make Dummy driver a loopback device
Date: Thu, 20 Jan 2005 06:37:32 +0100
Message-ID: <dc6da21004a95f746b249119c8993f9b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 48D8D22D
	for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2005 06:37:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=819> 
======================================================================
Reported By:                tschneider
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   819
Category:                   GENERIC - dummy
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-15-2005 02:26 CET
Last Modified:              01-20-2005 06:37 CET
======================================================================
Summary:                    Patch to make Dummy driver a loopback device
Description: 
This patch updates the Dummy ALSA device to be a loopback device.  (i.e.
the sound played to the device is available on the capture output)  This
patch is against the dummy driver in the 2.6.10 linux kernel.
======================================================================

----------------------------------------------------------------------
 tiwai - 01-19-05 17:11 
----------------------------------------------------------------------
Thanks for the patch.  First, please provide a bit more detailed
description of the patch, and signed-off-by line, as described in News
page.

The internal buffer should be card specific and shouldn't be a static
array of such a big size.  Use vmalloc() and allocate/free it dynamically
for each card instance.

But, I think it'd be better to copy directly from the playback buffer to
the capture buffer without an intermediate buffer.

----------------------------------------------------------------------
 tschneider - 01-20-05 06:37 
----------------------------------------------------------------------
Ah, very good. Thank you for reviewing the patch.  I will submit a new
patch when I get these changes implemented and tested.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-15-05 02:26 tschneider     New Issue                                    
01-15-05 02:26 tschneider     File Added: loopback-alsa-dummy.v7.patch          
         
01-15-05 02:26 tschneider     Kernel Version            => 2.6.10          
01-19-05 17:11 tiwai          Note Added: 0003300                          
01-20-05 06:37 tschneider     Note Added: 0003323                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
