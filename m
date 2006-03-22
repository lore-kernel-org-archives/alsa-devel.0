From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000918]: Behringer BCA-2000
Date: Wed, 22 Mar 2006 03:43:49 +0100
Message-ID: <2bfd2f9913397fcb075d8d0b43786259@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 75FE71A0
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:43:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=918> 
======================================================================
Reported By:                billwest00
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   918
Category:                   USB - usb-audio
Reproducibility:            N/A
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Demudi 1.2.1
Kernel Version:             2.4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             02-18-2005 00:43 CET
Last Modified:              03-22-2006 03:43 CET
======================================================================
Summary:                    Behringer BCA-2000
Description: 
My appologies if this is not the correct forum.  I use Agnula Demudi 1.2.1.
 I recently purchased Behringer's new usb2.0 interface.  I added
snd-usb-audio to the /etc/modules file.  The device is not claimed by any
driver on restart.  I actually did not expect it to work, being so new.  I
just wanted to let you know that this device does not appear to work with
Demudi.

--Thanks!
Bill West
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000941 Behringer BCA 2000 USB device not recog...
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 02-18-05 09:34 
----------------------------------------------------------------------
Please show the output of "lsusb -v".

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:43 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-18-05 00:43 billwest00     New Issue                                    
02-18-05 00:43 billwest00     Distribution              => Demudi 1.2.1    
02-18-05 00:43 billwest00     Kernel Version            => 2.4             
02-18-05 09:34 Clemens LadischNote Added: 0003648                          
02-18-05 16:28 billwest00     Issue Monitored: billwest00                    
02-28-05 18:15 Clemens LadischRelationship added       duplicate of 0000941
03-22-06 03:43 rlrevell       Status                   assigned => closed  
03-22-06 03:43 rlrevell       Note Added: 0008833                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
