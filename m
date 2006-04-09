From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001944]: 0001491: Onboard sound of HP Kayak workstation isn't detected properly
Date: Sun, 9 Apr 2006 21:12:12 +0200
Message-ID: <6cbf8a24873e4e6ddc0d388f434045f5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BDDEF158
	for <alsa-devel@alsa-project.org>; Sun,  9 Apr 2006 21:12:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1944> 
======================================================================
Reported By:                axion
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1944
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               slackware
Kernel Version:             2.6.16
======================================================================
Date Submitted:             03-20-2006 13:56 CET
Last Modified:              04-09-2006 21:12 CEST
======================================================================
Summary:                    0001491: Onboard sound of HP Kayak workstation isn't
detected properly
Description: 
Detection of AD1816AJS chip contained on the board of HP Kayak workstation
(chipset i440LX) is not detected by ALSA - tested in both PnP and non-PnP
mode. With legacy OSS driver it works fine in non-PnP mode (PnP probably
doesn't work), but there's need to hard-write all parameters like io, irq,
dma and so...
======================================================================

----------------------------------------------------------------------
 axion - 03-20-06 13:58 
----------------------------------------------------------------------
alsa version is 1.0.11rc2 ( builtinto kernel 2.6.16 )

----------------------------------------------------------------------
 axion - 04-09-06 21:12 
----------------------------------------------------------------------
also tried driver version rc4

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-20-06 13:56 axion          New Issue                                    
03-20-06 13:56 axion          Distribution              => slackware       
03-20-06 13:56 axion          Kernel Version            => 2.6.16          
03-20-06 13:58 axion          Note Added: 0008720                          
04-09-06 21:12 axion          Note Added: 0009184                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
