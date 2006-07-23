From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001376]: ens1370 gameport module
	stupidity
Date: Sun, 23 Jul 2006 19:36:03 +0200
Message-ID: <577b5ee1540e88acea76a8bc5b6810dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E19A5172
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 19:36:03 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1376> 
======================================================================
Reported By:                Hetfield
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1376
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             08-29-2005 11:59 CEST
Last Modified:              07-23-2006 19:36 CEST
======================================================================
Summary:                    ens1370 gameport module stupidity
Description: 
hi.

situation:
i have ens1370 built-in kernel and gameport too.
i have the lilo cmd line snd_ens1370.joystick=1 to enable gameport.
works perfectly.

the problem is if i add gameport as module.
the gameport command fails, and i can't use gameport.
this can be even normal..but the problem is i can't no more enable
gameport on audio card.

i checked the /sys and /proc fs to check a settable value. no luck
this forces gameport to be a module, only if snd is module (i can pass
values via modprobe)
and forces to be built-in if snd is built-in.

can be gameport init added via proc/sys or a specific alsa tool?

Thanks




======================================================================

----------------------------------------------------------------------
 Adrian Bunk - 07-23-06 19:36 
----------------------------------------------------------------------
This can't be easily done.

The solution is to simply build the gameport support statically into the
kernel if this driver is compiled statically.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-29-05 11:59 Hetfield       New Issue                                    
07-23-06 19:36 Adrian Bunk    Note Added: 0011203                          
07-23-06 19:36 Adrian Bunk    Status                   new => resolved     
07-23-06 19:36 Adrian Bunk    Resolution               open => won't fix   
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
