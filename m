From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001993]: duplex problems - other side cant hear my voice
Date: Sun, 2 Apr 2006 19:59:45 +0200
Message-ID: <f7e076e4f04f52d81b4af162e67811d3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7460819D
	for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2006 19:59:45 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1993> 
======================================================================
Reported By:                crissi
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1993
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             04-02-2006 19:15 CEST
Last Modified:              04-02-2006 19:59 CEST
======================================================================
Summary:                    duplex problems - other side cant hear my voice
Description: 
By using Skype with artsd via artsdsp and full duplex is enabled it works
with cvs from 23.03.06.
Now I try current cvs (02.04.06) and the other side cant hear me.
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-02-06 19:45 
----------------------------------------------------------------------
Can you try to narrow it down by testing some versions in between?

Also, that /etc/asound.conf is completely unnecessary since ALSA 1.0.9 -
it's best to remove it.

----------------------------------------------------------------------
 crissi - 04-02-06 19:59 
----------------------------------------------------------------------
I only have 2 trees with alsa cvs. How I can find out which version has the
working tree?


Yes, seems to work without that asound.conf.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-02-06 19:15 crissi         New Issue                                    
04-02-06 19:15 crissi         Distribution              => Debian          
04-02-06 19:15 crissi         Kernel Version            => 2.6.15.6        
04-02-06 19:45 rlrevell       Note Added: 0009067                          
04-02-06 19:59 crissi         Note Added: 0009070                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
