From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001984]: Line in record level impossible with OSS compatibility
Date: Mon, 10 Apr 2006 17:06:11 +0200
Message-ID: <a09fe818188be562919501741ddcbd80@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AB4BF184
	for <alsa-devel@alsa-project.org>; Mon, 10 Apr 2006 17:06:11 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1984> 
======================================================================
Reported By:                croiset
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1984
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             03-31-2006 16:16 CEST
Last Modified:              04-10-2006 17:06 CEST
======================================================================
Summary:                    Line in record level impossible with OSS
compatibility
Description: 
it's impossible to adjust the analog input level by alsamixer except if you
use the "Line" fader. So when you record you always have the input on the
output.

It will be better if it's possible to use IGAIN.


======================================================================

----------------------------------------------------------------------
 tiwai - 04-10-06 17:06 
----------------------------------------------------------------------
OSS emulation can't work in 100% because it doesn't cover the all
functionality ALSA provides.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-31-06 16:16 croiset        New Issue                                    
04-10-06 17:06 tiwai          Status                   assigned => resolved
04-10-06 17:06 tiwai          Resolution               open => won't fix   
04-10-06 17:06 tiwai          Note Added: 0009204                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
