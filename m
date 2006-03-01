From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001713]: ALC260 no input
Date: Wed, 1 Mar 2006 17:56:24 +0100
Message-ID: <1dbbe21ced1f6c900103809ed9422ea8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 439A01C9
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 17:56:24 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1713> 
======================================================================
Reported By:                hweigel
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1713
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
Date Submitted:             01-04-2006 17:24 CET
Last Modified:              03-01-2006 17:56 CET
======================================================================
Summary:                    ALC260 no input
Description: 
My FSC Lifebook S-7020 has the ALC260. While 
all sound output seems to work fine with 
alsa 1.0.10, the microphone produces only very 
weak sound (just infinitesimally more than zero).
======================================================================

----------------------------------------------------------------------
 jwoithe - 03-01-06 06:16 
----------------------------------------------------------------------
hweigel: I bet the microphone you're using is a condensor type.  Most small
"made for computers" microphones fall into this category.  They require a
small DC bias to be supplied by the computer before they will operate.

The version of the ALC260 driver now in CVS includes support to turn this
bias on if you need it.  Get the latest CVS version or wait for 1.0.11 to
be released.  Get this compiled and loaded.  Then go to alsamixer, find
the control labeled "Mic/Line jack mode" and set it to "Mic 80pc bias". 
Once done, try capturing again; it should work much better.

Note that the "mic jack mode" control is not AFAIK in 1.0.11-rc3 - you
will need a reasonably recent CVS snapshot.

----------------------------------------------------------------------
 rlrevell - 03-01-06 17:56 
----------------------------------------------------------------------
should be fixed in CVS

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-04-06 17:24 hweigel        New Issue                                    
03-01-06 01:27 rlrevell       Note Added: 0008257                          
03-01-06 06:16 jwoithe        Note Added: 0008271                          
03-01-06 10:05 cartman        Issue Monitored: cartman                     
03-01-06 17:56 rlrevell       Status                   assigned => resolved
03-01-06 17:56 rlrevell       Resolution               open => fixed       
03-01-06 17:56 rlrevell       Note Added: 0008283                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
