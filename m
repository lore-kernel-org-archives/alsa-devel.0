From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002084]: If the PCM channel is being
	used and the same time that X is on-screen,
	... total hard crash of whole system.
Date: Sat, 5 Aug 2006 13:15:42 +0200
Message-ID: <723e6bf1c8e80e701921724784ccaaac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C140616B
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 13:15:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2084> 
======================================================================
Reported By:                terrym
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2084
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               ROCK Linux, both 2.0.3 and trunk
Kernel Version:             2.4.x and 2.6.x, currently running 2.6.16.2
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             04-29-2006 04:40 CEST
Last Modified:              08-05-2006 13:15 CEST
======================================================================
Summary:                    If the PCM channel is being used and the same time
that X is on-screen, ... total hard crash of whole system.
Description: 
X can be running as long as it is not on screen, that is, a text console is
in use. It does not matter if the sound app is console based or GUI (X
based), the result is the same: the moment sound plays via PCM and X is on
screen, there is a hard crash that instantly locks up the whole system,
the kernel it self crashes, as an already issued shutdown w/delay will not
finish.
======================================================================

----------------------------------------------------------------------
 tiwai - 05-02-06 18:06 
----------------------------------------------------------------------
Please elaborate the hardware details.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-29-06 04:40 terrym         New Issue                                    
04-29-06 04:40 terrym         Distribution              => ROCK Linux, both
2.0.3 and trunk
04-29-06 04:40 terrym         Kernel Version            => 2.4.x and 2.6.x,
currently running 2.6.16.2
05-02-06 18:06 tiwai          Note Added: 0009565                          
08-05-06 13:15 Adrian Bunk    Status                   new => closed       
08-05-06 13:15 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
