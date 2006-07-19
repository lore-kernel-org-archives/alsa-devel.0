From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002293]: M-Audio Delta 192 - Missing
	controls
Date: Wed, 19 Jul 2006 03:44:17 +0200
Message-ID: <dba126682c3d7bcfd26c4521d71f38ff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CC0CC243
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 03:44:17 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2293> 
======================================================================
Reported By:                cruiseoveride
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2293
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.17
======================================================================
Date Submitted:             07-19-2006 03:44 CEST
Last Modified:              07-19-2006 03:44 CEST
======================================================================
Summary:                    M-Audio Delta 192 - Missing controls
Description: 
The driver (ice1724) has buggy support for the the M-Audio Delta Audiophile
192.

The first noticeable thing i found was with the "Multi Track Peak" . Only
the first two values have any use (they represent RCA Main Out) the rest
do jack sh*t.

Please see attached files.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-06 03:44 cruiseoveride  New Issue                                    
07-19-06 03:44 cruiseoveride  File Added: amixer_contents.txt                   

07-19-06 03:44 cruiseoveride  Kernel Version            => 2.6.17          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
