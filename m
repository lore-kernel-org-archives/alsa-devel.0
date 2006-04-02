From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001993]: duplex problems - other side cant hear my voice
Date: Sun, 2 Apr 2006 21:28:35 +0200
Message-ID: <f82265524f555c57b3be4aaffb014c0d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 89A9C16E
	for <alsa-devel@alsa-project.org>; Sun,  2 Apr 2006 21:28:35 +0200 (MEST)
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
Last Modified:              04-02-2006 21:28 CEST
======================================================================
Summary:                    duplex problems - other side cant hear my voice
Description: 
By using Skype with artsd via artsdsp and full duplex is enabled it works
with cvs from 23.03.06.
Now I try current cvs (02.04.06) and the other side cant hear me.
======================================================================

----------------------------------------------------------------------
 crissi - 04-02-06 21:00 
----------------------------------------------------------------------
I do make install of the alsa driver (modules) and do alsa force-reload
after that it wont work. make install in old dir install the old modules,
force reload -> works again

> You can use "cvs update -A -D 2006-03-30" for example to search by date
I still have a tree with the date. I can tar it and send to you both trees
of nessary.

----------------------------------------------------------------------
 rlrevell - 04-02-06 21:28 
----------------------------------------------------------------------
You should still check the mixer settings after force-reload, some might
have changed.

I think you misunderstand "search by date" - I suggest you try to identify
the last working version, by:

cvs update -A -D 2006-03-23
cvs update -A -D 2006-03-27
cvs update -A -D 2006-03-31

etc

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
04-02-06 21:28 rlrevell       Note Added: 0009073                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
