From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000776]: desynchronization, xruns when running mplayer
Date: Wed, 14 Sep 2005 16:14:10 +0200
Message-ID: <f582a6ce604b5037f3359e982a00957d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5C0EE1A3
	for <alsa-devel@alsa-project.org>; Wed, 14 Sep 2005 16:14:11 +0200 (MEST)
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


The following issue has been UPDATED.
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
Status:                     assigned
Distribution:               
Kernel Version:             2.4.28
======================================================================
Date Submitted:             01-02-2005 13:14 CET
Last Modified:              09-14-2005 16:14 CEST
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

----------------------------------------------------------------------
 SergeS - 01-02-05 13:24 
----------------------------------------------------------------------
And when i try to unload it i got Segmentation Fault

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-02-05 13:14 SergeS         New Issue                                    
01-02-05 13:14 SergeS         Kernel Version            => 2.4.28          
01-02-05 13:24 SergeS         Note Added: 0003045                          
01-02-05 13:25 SergeS         Issue Monitored: SergeS                      
09-14-05 16:14 jdthood        Summary                  dissynchronization =>
desynchronization, xruns when running mplayer
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
