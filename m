From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001859]: request update intel8x0.c to support NVIDIA nForce 410
Date: Thu, 2 Mar 2006 16:03:52 +0100
Message-ID: <6acf35e65419002764e1911e476ef483@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A598F191
	for <alsa-devel@alsa-project.org>; Thu,  2 Mar 2006 16:03:52 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1859> 
======================================================================
Reported By:                nangate
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1859
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Fedora FC4
Kernel Version:             2.6.15-1.1831_FC4
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-19-2006 20:48 CET
Last Modified:              03-02-2006 16:03 CET
======================================================================
Summary:                    request update intel8x0.c to support NVIDIA nForce
410
Description: 
The nvidia proprietary driver does not support ALSA for the 410 south
bridge chip.

I patched the current intel8x0.c source as follows:

408a409
>       { 0x10de, 0x026b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, DEVICE_NFORCE },  
    /* NFORCE4 */

I made and replaced snd-intel8x0.ko for 2.6.15-1.1831_FC4 kernel. I
manually updated /etc/modprobe.conf. Sound works on both KDE and GNOME
desktops for me now.

======================================================================

----------------------------------------------------------------------
 tiwai - 03-02-06 16:03 
----------------------------------------------------------------------
It's already fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-19-06 20:48 nangate        New Issue                                    
02-19-06 20:48 nangate        File Added: patch.diff                       
02-19-06 20:48 nangate        Distribution              => Fedora FC4      
02-19-06 20:48 nangate        Kernel Version            => 2.6.15-1.1831_FC4
02-19-06 20:49 nangate        Issue Monitored: nangate                     
02-26-06 20:26 nangate        Issue End Monitor: nangate                    
03-02-06 16:03 tiwai          Status                   new => resolved     
03-02-06 16:03 tiwai          Resolution               open => fixed       
03-02-06 16:03 tiwai          Assigned To               => tiwai           
03-02-06 16:03 tiwai          Note Added: 0008318                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
