From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001800]: Input signal from analog input in snd-ca0106 with audigy SE distorted!
Date: Thu, 13 Apr 2006 21:51:17 +0200
Message-ID: <e7d8c72c2a38625557eeb8af07431d82@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CDFCF150
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 21:51:17 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1800> 
======================================================================
Reported By:                AnarSoul
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1800
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               Slackware
Kernel Version:             2.6.15
======================================================================
Date Submitted:             01-31-2006 15:56 CET
Last Modified:              04-13-2006 21:51 CEST
======================================================================
Summary:                    Input signal from analog input in snd-ca0106 with
audigy SE distorted!
Description: 
Recorded signal from my audigy SE from analog MIC input badly distorted! =(
======================================================================

----------------------------------------------------------------------
 AnarSoul - 02-07-06 21:55 
----------------------------------------------------------------------
Recorded signal distorted only if number of channels set to 2.
If number of capture channels set to 1 there's no distortion :)

Probably bug with setting up number of capture channels in driver?

----------------------------------------------------------------------
 jcdutton - 04-13-06 21:51 
----------------------------------------------------------------------
Please try alsa-driver 1.0.11rc5 or above and report back.


Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-31-06 15:56 AnarSoul       New Issue                                    
01-31-06 15:56 AnarSoul       Distribution              => Slackware       
01-31-06 15:56 AnarSoul       Kernel Version            => 2.6.15          
02-05-06 17:38 AnarSoul       Issue Monitored: AnarSoul                    
02-07-06 21:55 AnarSoul       Note Added: 0007961                          
04-13-06 21:51 jcdutton       Note Added: 0009273                          
04-13-06 21:51 jcdutton       Status                   assigned => feedback
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
