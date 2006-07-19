From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002290]: Bad support for intel-hda
	mixer. Only get options for master and pcm. volume doesn't
	get that loud. card special features lost
Date: Thu, 20 Jul 2006 01:04:25 +0200
Message-ID: <de6762aded9bdf912b4574689f7f8288@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA80C196
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 01:04:25 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2290> 
======================================================================
Reported By:                linux2
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2290
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-18-2006 06:59 CEST
Last Modified:              07-20-2006 01:04 CEST
======================================================================
Summary:                    Bad support for intel-hda mixer. Only get options
for master and pcm. volume doesn't get that loud. card special features lost
Description: 
Now just to make a comparison. In windows this laptop gets very loud even
at a low volume. this is done through other mixer options not availible
yet in ALSA. Also previous versions of ALSA do not have support for this
card in my laptop (its an hpdv5000t). I believe that the sound on all hp
laptops is run through some sort of software to communicate with hardware
switches since in linux the hotkeys for muting do work but the lights do
not respond accordingly (in windows there is a short delay before they
change). The sound in windows does also sound much better because of all
the mixer options and the boosted volume.
======================================================================

----------------------------------------------------------------------
 linux2 - 07-20-06 01:04 
----------------------------------------------------------------------
Hey guys, Got an update. It appears that my laptop has some sort of
internal volume control other than master and pcm. In windows there is an
internal amp option in the normal volume control program. Along with wave
options also. I am willing to test any development source code to see if
problems are fixed as i would really like to get sound working on this
laptop. I do not believe that this sound issue is limited to this laptop
only though.

Finally I have been noticing a crackling in a couple of apps (doom 3) and
im not sure why this is. I think it uses openAL and that is what the
problem is. But no problems on my old desktop with openAL.

Keep me posted on any updates. Thanks

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-18-06 06:59 linux2         New Issue                                    
07-20-06 01:04 linux2         Note Added: 0011105                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
