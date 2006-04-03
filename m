From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001992]: Line2 LiveDrive has no capture settings / unable to record from 'AUX 2 IN'
Date: Mon, 3 Apr 2006 21:40:00 +0200
Message-ID: <f00691dee2d6f3d70de39bfe8f8f6a1b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B5052175
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 21:40:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1992> 
======================================================================
Reported By:                metaron
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1992
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo, gcc 3.3.5-20050130,
Kernel Version:             2.6.15.1
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-02-2006 17:59 CEST
Last Modified:              04-03-2006 21:39 CEST
======================================================================
Summary:                    Line2 LiveDrive has no capture settings / unable to
record from 'AUX 2 IN'
Description: 
I have been trying to use the front RCA inputs (Labled 'AUX IN 2') on my
LiveDrive to record sound, but have not been able to do so.

If I change the Line2 LiveDrive slider in kmix, I can change the monitor
volume, but running arecord results in 10 seconds of silence :-(.

I'm happy to re-compile with patches, or even try fixing it myself if
anyone can point me in the right direction in the code although I have no
alsa codeing experience...
======================================================================

----------------------------------------------------------------------
 metaron - 04-03-06 21:32 
----------------------------------------------------------------------
Oops. Sorry to waste your time. I've got it working now (using alsamixer
:-) - I'll raise a bug report on kmix. Thanks for your help!

----------------------------------------------------------------------
 rlrevell - 04-03-06 21:39 
----------------------------------------------------------------------
Kmix bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-02-06 17:59 metaron        New Issue                                    
04-02-06 17:59 metaron        Distribution              => Gentoo, gcc
3.3.5-20050130,
04-02-06 17:59 metaron        Kernel Version            => 2.6.15.1        
04-02-06 18:13 rlrevell       Note Added: 0009064                          
04-02-06 18:51 Raymond        Note Added: 0009065                          
04-02-06 18:54 Raymond        Note Edited: 0009065                         
04-02-06 19:01 rlrevell       Note Added: 0009066                          
04-02-06 19:51 pzad           Note Added: 0009068                          
04-03-06 21:32 metaron        Note Added: 0009106                          
04-03-06 21:39 rlrevell       Status                   new => closed       
04-03-06 21:39 rlrevell       Note Added: 0009107                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
