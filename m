From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001994]: alsa-oss dont use dmix
Date: Sun, 2 Apr 2006 19:58:28 +0200
Message-ID: <7e3e99833e0ef90df96ccd869a7c3807@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1580719D
	for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2006 19:58:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1994> 
======================================================================
Reported By:                crissi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1994
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-02-2006 19:45 CEST
Last Modified:              04-02-2006 19:58 CEST
======================================================================
Summary:                    alsa-oss dont use dmix
Description: 
The alsa-oss module doesnt use the dmix module but it should.
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-02-06 19:58 
----------------------------------------------------------------------
Works for me:

$ ALSA_OSS_DEBUG=1 aoss /usr/bin/play /usr/share/sounds/error.wav 
Opened PCM dsp0 for stream 0 (result = -2)
Opened PCM default for stream 0 (result = 0)
           ^^^^^^^

'default' should be defined to use dmix with no need for .asoundrc.

The in-kernel OSS emulation can't be made to use dmix - you must use aoss.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-02-06 19:45 crissi         New Issue                                    
04-02-06 19:58 rlrevell       Note Added: 0009069                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
