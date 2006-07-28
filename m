From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001904]: No Sound At All
Date: Fri, 28 Jul 2006 22:24:10 +0200
Message-ID: <d6557a47249075bda4786e6d1537d6d5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E3EE116E
	for <alsa-devel@alsa-project.org>;
	Fri, 28 Jul 2006 22:24:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1904> 
======================================================================
Reported By:                niels
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1904
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.15-i686
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             03-10-2006 14:24 CET
Last Modified:              07-28-2006 22:24 CEST
======================================================================
Summary:                    No Sound At All
Description: 
Hi There!
Unfortunately I have to report that I am not getting a single sound out of
my SB24Bit Live Sounbcard!
All dependencies are fulfilled, the right kernel is installed, the actual
libasound2 is installed, Alsaconf builds the driver, on alsamixer the
Volumes are up - but still no sound!
Well it could be the DSP, thats true, but thats pretty much unusual as it
is a brandnew card!
If you, the developer crew does have any suggestions what you want me to
test tzo verify if it is a bug or not, don`t hesitate to contact me!
If I am on the console and try aplay /usr/share/sounds/pop.wav nothing
happens either. And yes I have disabled the artsd in the control menu of
KDE!

Thanks
Niels
======================================================================

----------------------------------------------------------------------
 jcdutton - 04-13-06 21:49 
----------------------------------------------------------------------
please post the output of the following commands:
cat /proc/asound/version
cat /proc/asound/cards
amixer

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-10-06 14:24 niels          New Issue                                    
03-10-06 14:24 niels          Distribution              => Debian          
03-10-06 14:24 niels          Kernel Version            => 2.6.15-i686     
04-13-06 21:49 jcdutton       Note Added: 0009272                          
04-13-06 21:49 jcdutton       Status                   assigned => feedback
07-28-06 22:24 Adrian Bunk    Status                   feedback => closed  
07-28-06 22:24 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
