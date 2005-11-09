From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001535]: The sound card is detected. No sound from the speakers or headphones.
Date: Wed, 9 Nov 2005 13:34:47 +0100
Message-ID: <8df71d95faa87373a459878221a89202@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 718911A8
	for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2005 13:34:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1535> 
======================================================================
Reported By:                h4ndr3s
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1535
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Slackware
Kernel Version:             2.6.13
======================================================================
Date Submitted:             11-08-2005 12:17 CET
Last Modified:              11-09-2005 13:34 CET
======================================================================
Summary:                    The sound card is detected. No sound from the
speakers or headphones.
Description: 
I have a Motherboard Intel D915GAV with a sound card Intel HDA onboard,
chipset Realtek ALC880. The Sound Card is detected, the modules are
loaded, but no sound come from the speakers or headphones. 
======================================================================

----------------------------------------------------------------------
 h4ndr3s - 11-09-05 12:24 
----------------------------------------------------------------------
Ok, I try the latest version of ALSA, with kernel 2.6.14. At the beginning
was the same, no sound... So, I read ALSA-Configuration.txt and pass to
the module the appropiate model option to snd_hda_intel. That was
model=3stack-digout, and the sound began to flow! :D
After that, i reboot the machine, and no problem, so the problem was
resolved. Now, i only can hear sound with the root user, with normal user
the sound system gives me an error, and alsamixer too (it is a problem of
permissions, right?), but if the problem goes on after a few trys, I'll
come back. 
Thanks!!!



----------------------------------------------------------------------
 tiwai - 11-09-05 13:34 
----------------------------------------------------------------------
Yes, the problem is likely the permission of your sound device.  There are
different methods to control them, dependong on the distro and setup.

Does 3stack-digout support all the function on your board?  If yes, please
provide the output of "lspci -nv", so that this model is chosen
automatically.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-08-05 12:17 h4ndr3s        New Issue                                    
11-08-05 12:17 h4ndr3s        Distribution              => Slackware       
11-08-05 12:17 h4ndr3s        Kernel Version            => 2.6.13          
11-08-05 17:46 tiwai          Note Added: 0006627                          
11-09-05 12:18 h4ndr3s        Note Added: 0006645                          
11-09-05 12:24 h4ndr3s        Note Edited: 0006645                         
11-09-05 13:34 tiwai          Note Added: 0006648                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
