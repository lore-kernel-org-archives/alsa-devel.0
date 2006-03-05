From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001884]: alsaconf don't find Realtek ALC850 onboard soundchip on ASUS A8V Deluxe when Creative X-Fi XtremeMusic is pluged in
Date: Sun, 5 Mar 2006 21:39:21 +0100
Message-ID: <524e026304d4aa2529712033f0f7882c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8766C1D6
	for <alsa-devel@alsa-project.org>; Sun,  5 Mar 2006 21:39:21 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1884> 
======================================================================
Reported By:                bergwiesel
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1884
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Debian 4.0.2-5
Kernel Version:             2.6.12
Resolution:                 reopened
Fixed in Version:           
======================================================================
Date Submitted:             02-28-2006 15:18 CET
Last Modified:              03-05-2006 21:39 CET
======================================================================
Summary:                    alsaconf don't find Realtek ALC850 onboard soundchip
on ASUS A8V Deluxe when Creative X-Fi XtremeMusic is pluged in
Description: 
Hi!

I have an Asus A8V Deluxe mainboard with its Realtek ALC850 soundchip,
which is fine for its own, but if I plug in my new Soundblaster X-Fi
alsaconf don't find a thing.

Do you need some more informations?
======================================================================

----------------------------------------------------------------------
 tiwai - 03-02-06 13:21 
----------------------------------------------------------------------
Closing now as this is no bug.

----------------------------------------------------------------------
 rlrevell - 03-05-06 21:39 
----------------------------------------------------------------------
Actually this can be disabled - someone just posted a patch to LKML that
fixes the problem.

The subject line was "PCI quirk for Asus A8V and A8V Deluxe motherboards"

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-28-06 15:18 bergwiesel     New Issue                                    
02-28-06 15:18 bergwiesel     Distribution              => Debian 4.0.2-5  
02-28-06 15:18 bergwiesel     Kernel Version            => 2.6.12          
02-28-06 15:20 er-ku          Note Added: 0008243                          
02-28-06 15:52 vsu            Note Added: 0008244                          
02-28-06 16:14 bergwiesel     Note Added: 0008245                          
03-02-06 13:21 tiwai          Status                   new => resolved     
03-02-06 13:21 tiwai          Resolution               open => not an issue
03-02-06 13:21 tiwai          Assigned To               => tiwai           
03-02-06 13:21 tiwai          Note Added: 0008304                          
03-05-06 21:39 rlrevell       Status                   resolved => feedback
03-05-06 21:39 rlrevell       Resolution               not an issue => reopened
03-05-06 21:39 rlrevell       Note Added: 0008358                          
03-05-06 21:39 rlrevell       Status                   feedback => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
