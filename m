From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001277]: Choosing of default playback device on the fly
Date: Wed, 22 Mar 2006 03:06:16 +0100
Message-ID: <d168ebba168982d71516e9e7e183953e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3E19C1A1
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:06:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1277> 
======================================================================
Reported By:                oldium
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1277
Category:                   0_general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-23-2005 10:42 CEST
Last Modified:              03-22-2006 03:06 CET
======================================================================
Summary:                    Choosing of default playback device on the fly
Description: 
Situation: There is on-board sound card and one pluggable (USB/PCMCIA)
sound card which is preferred to play the sound.

Problem: If the preferred sound card is plugged-in before the boot time,
it is taken as the default output card (as of snd-card-0 settings and
driver is loaded first), but when the sound card is plugged after the
boot, it gets index 1 and is not the default.

Suggestion: Please consider creating plugin to use preferred sound card as
default output whenever it is plugged in and use fallback card whenever it
is not available, or let the user space program (shell script) decide
which card is default.

Usage: This is good for laptops using external sound card at home and
built-in on the way.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:06 
----------------------------------------------------------------------
Not a bug (feature requests should be discussed on alsa-devel ML)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-23-05 10:42 oldium         New Issue                                    
03-22-06 03:06 rlrevell       Status                   new => closed       
03-22-06 03:06 rlrevell       Note Added: 0008795                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
