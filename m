From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001993]: duplex problems - other side cant hear my voice
Date: Sun, 2 Apr 2006 21:00:48 +0200
Message-ID: <ed05d0a8d4332cadbfdd2e24e3c2964c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F2E9819D
	for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2006 21:00:48 +0200 (MEST)
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
Last Modified:              04-02-2006 21:00 CEST
======================================================================
Summary:                    duplex problems - other side cant hear my voice
Description: 
By using Skype with artsd via artsdsp and full duplex is enabled it works
with cvs from 23.03.06.
Now I try current cvs (02.04.06) and the other side cant hear me.
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-02-06 20:51 
----------------------------------------------------------------------
Are you sure it's not just a change in the mixer?  Did you double check all
settings after the upgrade?

You can use "cvs update -A -D 2006-03-30" for example to search by date

----------------------------------------------------------------------
 crissi - 04-02-06 21:00 
----------------------------------------------------------------------
I do make install of the alsa driver (modules) and do alsa force-reload
after that it wont work. make install in old dir install the old modules,
force reload -> works again

> You can use "cvs update -A -D 2006-03-30" for example to search by date
I still have a tree with the date. I can tar it and send to you both trees
of nessary.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-02-06 19:15 crissi         New Issue                                    
04-02-06 19:15 crissi         Distribution              => Debian          
04-02-06 19:15 crissi         Kernel Version            => 2.6.15.6        
04-02-06 19:45 rlrevell       Note Added: 0009067                          
04-02-06 19:59 crissi         Note Added: 0009070                          
04-02-06 20:51 rlrevell       Note Added: 0009071                          
04-02-06 21:00 crissi         Note Added: 0009072                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
