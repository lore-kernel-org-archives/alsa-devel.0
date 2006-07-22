From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002293]: M-Audio Delta 192 - Missing
	controls
Date: Sat, 22 Jul 2006 22:57:18 +0200
Message-ID: <1220bcd64694d421ecc3f6417a71c142@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4328C140
	for <alsa-devel@alsa-project.org>;
	Sat, 22 Jul 2006 22:57:18 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0001831.
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
Last Modified:              07-22-2006 22:57 CEST
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001831 envy24control does not work with Hercul...
======================================================================

----------------------------------------------------------------------
 cruiseoveride - 07-22-06 03:00 
----------------------------------------------------------------------
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1831

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-06 03:44 cruiseoveride  New Issue                                    
07-19-06 03:44 cruiseoveride  File Added: amixer_contents.txt                   

07-19-06 03:44 cruiseoveride  Kernel Version            => 2.6.17          
07-19-06 03:44 cruiseoveride  File Added: lspci_vn.txt                     
07-19-06 03:44 cruiseoveride  File Added: proc_asound_cards.txt                 
  
07-19-06 03:45 cruiseoveride  File Added: proc_asound_ice1724.txt               
    
07-19-06 03:45 cruiseoveride  File Added: proc_asound_pcm.txt                   

07-19-06 03:51 cruiseoveride  Issue Monitored: cruiseoveride                    
07-22-06 03:00 cruiseoveride  Note Added: 0011162                          
07-22-06 22:57 rlrevell       Relationship added       related to 0001831  
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
