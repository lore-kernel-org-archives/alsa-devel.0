From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0001214]: With Terratec DMX6fire, digital inputs cannot be selected correctly -always internal digital source
Date: Wed, 12 Apr 2006 23:11:35 +0200
Message-ID: <48cccbdc7e57307d30fa3940fce6c4bc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7460914F
	for <alsa-devel@alsa-project.org>; Wed, 12 Apr 2006 23:11:35 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1214> 
======================================================================
Reported By:                alanmann
Assigned To:                
======================================================================
Project:                    ALSA - tools
Issue ID:                   1214
Category:                   envy24control
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             06-27-2005 15:27 CEST
Last Modified:              04-12-2006 23:11 CEST
======================================================================
Summary:                    With Terratec DMX6fire, digital inputs cannot be
selected correctly -always internal digital source
Description: 
The DMX6fire sound card has onboard 'digital in' for direct connection from
a CD drive as well as coax and optical front panel in and out. 
Envy24control has no button to select the internal source, but in fact it
seems always selected and works fine.  Consequently the front panel inputs
never work,(I can only test optical, but internal source is always
working) although the selector 'SPDIF input' changes the panel lights
correctly, and the 'SPDIF on/off' swaps the lights whichever way they
were.
======================================================================

----------------------------------------------------------------------
 alanmann - 12-17-05 00:11 
----------------------------------------------------------------------
As an update:
Patches to fix this bug are now in alsa-1.0.11rc1 so should be included in
the final 1.0.11 release.

----------------------------------------------------------------------
 alanmann - 04-12-06 23:11 
----------------------------------------------------------------------
BTW this bug can be closed-resolved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-27-05 15:27 alanmann       New Issue                                    
06-27-05 16:05 tiwai          Note Added: 0005274                          
06-29-05 22:39 alanmann       Note Added: 0005318                          
07-08-05 14:48 tiwai          Note Added: 0005428                          
07-08-05 22:09 alanmann       Note Added: 0005435                          
08-23-05 18:52 alanmann       Note Added: 0005913                          
12-17-05 00:11 alanmann       Note Added: 0007062                          
04-12-06 23:11 alanmann       Note Added: 0009250                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
