From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001452]: No Microphone input
Date: Thu, 20 Jul 2006 10:46:28 +0200
Message-ID: <897c55d2eadda7651dd35f71c91c84da@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 17EFE181
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 10:46:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1452> 
======================================================================
Reported By:                honschu
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1452
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Debian sarge
Kernel Version:             2.6.12
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             09-24-2005 17:12 CEST
Last Modified:              07-20-2006 10:46 CEST
======================================================================
Summary:                    No Microphone input
Description: 
Sound output works, but microphone input doesn't. I do not know why.

For Kernel 2.6.13 or 2.6.14-rc2 (Alsa: 1.0.10rc1) sound output doesn't
work.

I have a Aopen i915Gm-HFS Motherboard.
======================================================================

----------------------------------------------------------------------
 honschu - 09-24-05 17:30 
----------------------------------------------------------------------
it was due to a mixersetting, I rechecked it - and voila it works
sorry for bothering ;)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-05 17:12 honschu        New Issue                                    
09-24-05 17:12 honschu        Distribution              => Debian sarge    
09-24-05 17:12 honschu        Kernel Version            => 2.6.12          
09-24-05 17:30 honschu        Note Added: 0006372                          
07-20-06 10:46 Adrian Bunk    Status                   assigned => closed  
07-20-06 10:46 Adrian Bunk    Resolution               open => not an issue
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
