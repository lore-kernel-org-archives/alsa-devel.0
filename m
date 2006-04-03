From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001998]: Audigy 2 ZS Platinum's hardware AC3/DD decoder isn't supported?
Date: Mon, 3 Apr 2006 18:45:52 +0200
Message-ID: <ca72487ff3dab39d029bc211ac04e6bb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA7C5175
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 18:45:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1998> 
======================================================================
Reported By:                pmn
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1998
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.16
======================================================================
Date Submitted:             04-03-2006 13:34 CEST
Last Modified:              04-03-2006 18:45 CEST
======================================================================
Summary:                    Audigy 2 ZS Platinum's hardware AC3/DD decoder isn't
supported?
Description: 
If I have understood right this card should be able to decode AC3/DD by
itself when sent into SPDIF/IN...

Well Sending AC3/DD signal to card's SPDIF/IN results in crackling noise
from my 7.1 analog speakers that are connected to card. Sending PCM into
SPDIF/IN works fine, but it would be nice to get AC3 (and by that way DD
sounds) alive and kicking.

Am I doing something wrong or is it just that emu10k1 doesn't support
Audigy2ZS's hardware AC3 decoder? If so please tell me what I am
doing/have understood wrong or are there any plans to get hardware AC3
decoder to work?
======================================================================

----------------------------------------------------------------------
 pzad - 04-03-06 17:18 
----------------------------------------------------------------------
Are you sure Audigy 2 ZS has hardware ac3 decoder (AFAIK there is none) ?

AFAIK ac3 spdif input is not suported for now.

----------------------------------------------------------------------
 rlrevell - 04-03-06 18:45 
----------------------------------------------------------------------
These devices have no hardware AC3 decoder - Creative is lying.  It's
implemented in software in the Windows driver.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-03-06 13:34 pmn            New Issue                                    
04-03-06 13:34 pmn            Distribution              => Gentoo          
04-03-06 13:34 pmn            Kernel Version            => 2.6.16          
04-03-06 17:18 pzad           Note Added: 0009100                          
04-03-06 18:45 rlrevell       Note Added: 0009101                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
