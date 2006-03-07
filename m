From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001892]: User-space _output_ devices
Date: Tue, 7 Mar 2006 15:24:48 +0100
Message-ID: <84d2f66093c600394f122010b614726c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4DC8614F
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 15:24:48 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1892> 
======================================================================
Reported By:                zeurkous
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1892
Category:                   1_OTHERS
Reproducibility:            N/A
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               N/A
Kernel Version:             N/A
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-05-2006 08:06 CET
Last Modified:              03-07-2006 15:24 CET
======================================================================
Summary:                    User-space _output_ devices
Description: 
This may sound a bit weird, but a feature i would like is a way for a
user-space program to access the ALSA output driver interface (preferably
as a device). Personally i'm designing a few simple sound output devices
such as via the parallel port and the like, and the current ALSA output
driver interface is AFAICS really heavily bloated for just getting an
8-bit sample and writing it as a simple value to a port....
======================================================================

----------------------------------------------------------------------
 tiwai - 03-07-06 15:24 
----------------------------------------------------------------------
Use extplug alsa-lib PCM plugin.  It's designed for an external user-space
driver.
You can find examples in alsa-plugins package.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-05-06 08:06 zeurkous       New Issue                                    
03-05-06 08:06 zeurkous       Distribution              => N/A             
03-05-06 08:06 zeurkous       Kernel Version            => N/A             
03-07-06 15:24 tiwai          Status                   new => resolved     
03-07-06 15:24 tiwai          Resolution               open => fixed       
03-07-06 15:24 tiwai          Assigned To               => tiwai           
03-07-06 15:24 tiwai          Note Added: 0008365                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
