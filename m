From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000996]: Noise when enabling dmix
Date: Fri, 28 Jul 2006 11:00:08 +0200
Message-ID: <ac4f5a935ab3cbb38d0c70318f7f2de5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DED4B171
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 11:00:08 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=996> 
======================================================================
Reported By:                daspooky
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   996
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-15-2005 16:25 CET
Last Modified:              07-28-2006 11:00 CEST
======================================================================
Summary:                    Noise when enabling dmix
Description: 
I get noise/static when i use the dmix plugin. When i use alsa without an
.asoundrc file there is no problem. I noticed this since i upgraded alsa
from 1.0.5 to 1.0.8. Version 1.0.5 didn't have this problem. I didn't try
versions between 1.0.5 and 1.0.8. The oise dissapears when i lower the
samplerate in asoundrc to 22000 KHz. Higher than that i get noise. 
======================================================================

----------------------------------------------------------------------
 daspooky - 03-16-05 13:21 
----------------------------------------------------------------------
It is there constantly, but only when software mixing is enabled it seems.
When i don't use an asoundrc file there is no static, but then of course i
can only play 1 sound at a time. 

In alsa 1.0.9rc1 it seems hardware mixing is enabled by default and no
asoundrc is needed. Here the static occurs all the time. 
So to conclude it happens when mixing is enabled.

----------------------------------------------------------------------
 jdthood - 12-13-05 12:41 
----------------------------------------------------------------------
Submitter: Any improvement in 1.0.10?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-05 16:25 daspooky       New Issue                                    
03-15-05 16:27 daspooky       Issue Monitored: daspooky                    
03-15-05 16:28 daspooky       Issue End Monitor: daspooky                    
03-16-05 12:52 tiwai          Note Added: 0003948                          
03-16-05 13:21 daspooky       Note Added: 0003955                          
12-13-05 12:41 jdthood        Note Added: 0006996                          
07-28-06 11:00 Adrian Bunk    Status                   assigned => closed  
07-28-06 11:00 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
