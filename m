From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000776]: desynchronization, xruns when running mplayer
Date: Wed, 22 Mar 2006 03:14:34 +0100
Message-ID: <6e3eab250955cb52de1b0fed25945bb0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D71381A6
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 03:14:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=776> 
======================================================================
Reported By:                SergeS
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   776
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.4.28
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-02-2005 13:14 CET
Last Modified:              03-22-2006 03:14 CET
======================================================================
Summary:                    desynchronization, xruns when running mplayer
Description: 
some times sound repeates bit
from MPlayer log
alsa-space: xrun of at least xx.xxxx msecs. resseting stream

if i run MPlayer with oss emulation - all is ok, when i try oss - all is
ok 

all software witch uses alsa do same error

hardwate: Dell Latitude CSx, NeoMagick NM256ZX
if need more information - send me email to sergesb@mail.ru
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000583 xruns when playing audio or video files
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-15-05 01:39 
----------------------------------------------------------------------
I get the exact same results - I just use OSS emulation with mplayer.  Even
so I still have to run it like:

nice -n -10 gmplayer movie.avi

to avoid massive audio and video dropouts when another app hogs the CPU.

Anyway it looks like the bug might be fixed in MPlayer dev-CVS--4.0.2.  I
can no longer reproduce the xruns.

----------------------------------------------------------------------
 rlrevell - 03-22-06 03:14 
----------------------------------------------------------------------
Mplayer bug, confirmed fixed in mplayer CVS

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-05 13:14 SergeS         New Issue                                    
01-02-05 13:14 SergeS         Kernel Version            => 2.4.28          
01-02-05 13:24 SergeS         Note Added: 0003045                          
01-02-05 13:25 SergeS         Issue Monitored: SergeS                      
09-14-05 16:14 jdthood        Summary                  dissynchronization =>
desynchronization, xruns when running mplayer
09-14-05 16:14 jdthood        Relationship added       duplicate of 0000583
09-14-05 16:15 jdthood        Note Added: 0006178                          
09-15-05 01:39 rlrevell       Note Added: 0006190                          
03-22-06 03:14 rlrevell       Status                   assigned => resolved
03-22-06 03:14 rlrevell       Resolution               open => fixed       
03-22-06 03:14 rlrevell       Note Added: 0008804                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
