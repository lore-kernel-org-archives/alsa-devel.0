From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001904]: No Sound At All
Date: Thu, 13 Apr 2006 21:49:26 +0200
Message-ID: <26e6a1ed8a165739a412bbad7af736c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C9810150
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 21:49:26 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.15-i686
======================================================================
Date Submitted:             03-10-2006 14:24 CET
Last Modified:              04-13-2006 21:49 CEST
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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
