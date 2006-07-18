From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001661]: alsaconf gets everything
	working but mic input doesn't work after a reboot
Date: Tue, 18 Jul 2006 16:17:12 +0200
Message-ID: <c66e36bc536705657de9ab36a1233fe7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 43BC3198
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 16:17:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1661> 
======================================================================
Reported By:                amarsh04
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1661
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.14.2-686
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-20-2005 03:16 CET
Last Modified:              07-18-2006 16:17 CEST
======================================================================
Summary:                    alsaconf gets everything working but mic input
doesn't work after a reboot
Description: 
I've finally obtained a SB Live! card that works and alsaconf made
everything work. However, after a reboot, output still works but not
microphone input. krecord shows zero input level. Re-running alsaconf
restores microphone input to a working state.
======================================================================

----------------------------------------------------------------------
 amarsh04 - 07-18-06 15:53 
----------------------------------------------------------------------
I am now running ALSA 1.0.11 including compiling source and using those
modules in kernel 2.6.17 (up-to-date with Debian Unstable) and have not
noticed this problem in several months.

----------------------------------------------------------------------
 jcdutton - 07-18-06 16:17 
----------------------------------------------------------------------
User reports problem solved.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 03:16 amarsh04       New Issue                                    
12-20-05 03:16 amarsh04       Distribution              => Debian          
12-20-05 03:16 amarsh04       Kernel Version            => 2.6.14.2-686    
12-20-05 12:44 amarsh04       Note Added: 0007104                          
12-20-05 20:58 rlrevell       Note Added: 0007105                          
12-21-05 22:20 amarsh04       File Added: amixerworking.txt                    
12-21-05 22:21 amarsh04       File Added: amixernotworking.txt                  
 
12-21-05 22:23 amarsh04       Note Added: 0007112                          
12-21-05 22:24 amarsh04       File Added: lsmodworking.txt                    
12-21-05 22:25 amarsh04       File Added: lsmodnotworking.txt                   

12-26-05 07:49 amarsh04       Note Added: 0007148                          
07-18-06 14:43 jcdutton       Status                   new => assigned     
07-18-06 14:43 jcdutton       Assigned To               => jcdutton        
07-18-06 15:53 amarsh04       Note Added: 0011062                          
07-18-06 15:53 amarsh04       Issue Monitored: amarsh04                    
07-18-06 16:17 jcdutton       Status                   assigned => closed  
07-18-06 16:17 jcdutton       Note Added: 0011064                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
