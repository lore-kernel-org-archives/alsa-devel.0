From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001935]: Adding support for other deviceclasses
Date: Tue, 21 Mar 2006 17:53:47 +0100
Message-ID: <17c45ccf22335ee80f149cae20b6f157@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E00481F7
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 17:53:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1935> 
======================================================================
Reported By:                Henne
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1935
Category:                   alsaconf
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-17-2006 13:43 CET
Last Modified:              03-21-2006 17:53 CET
======================================================================
Summary:                    Adding support for other deviceclasses
Description: 
alsaconf filters, in find_device_name(), unrelevant outputs from lspci.
If the classname of does not match "Multimedia audio controller", the
output becomes unreadable.
That is the case of the Sek'd ARC88, which classname is "Multimedia
controller".
This patch fixes that.
======================================================================

----------------------------------------------------------------------
 Henne - 03-17-06 14:26 
----------------------------------------------------------------------
It seems to me that no first patch is perfect... :)
Use patch_new.diff

----------------------------------------------------------------------
 tiwai - 03-21-06 17:53 
----------------------------------------------------------------------
Thanks for the patch.  I fixed differently on CVS, since the patch doesn't
handle class 0403 or other correctly.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 13:43 Henne          New Issue                                    
03-17-06 13:43 Henne          File Added: patch.diff                       
03-17-06 14:26 Henne          Note Added: 0008646                          
03-17-06 14:27 Henne          File Added: patch_new.diff                    
03-21-06 17:53 tiwai          Status                   new => resolved     
03-21-06 17:53 tiwai          Resolution               open => fixed       
03-21-06 17:53 tiwai          Assigned To               => tiwai           
03-21-06 17:53 tiwai          Note Added: 0008752                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
