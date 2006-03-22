From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001462]: Internal OSS emulation doesn't use the hardware mixer?
Date: Wed, 22 Mar 2006 01:45:59 +0100
Message-ID: <a445c6b2d2fb67d40f6d3881d62851b4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 629A4179
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 01:45:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1462> 
======================================================================
Reported By:                mador
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1462
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1456_FC4smp #1 SMP Thu Sep 22 02:23:57 EDT
2005 x86_64 x86_64 x86_64 GNU/Linux
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             09-26-2005 16:38 CEST
Last Modified:              03-22-2006 01:45 CET
======================================================================
Summary:                    Internal OSS emulation doesn't use the hardware
mixer?
Description: 
When using the alsa hardware device (not dmix) I can play multiple sounds
in parallel but not with the OSS device. In addition, the OSS device shows
as in use while Alsa device is used and vice-versa, the Alsa device is
blocked when the OSS device is used. More then that the alsa
infrastructure reports that there is only one available subdevice as if
hardware mixing wasn't available. But when playing on hw:0 with aplay, I
can have multiple sound files mixed.
On ESS cards with 4 hardware mixed channels I was able to use in parallel
the alsa  and the oss devices and I would like to be possible to use the
emulated oss and not the aoss wrapper for the oss only applications.
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-26-05 19:10 
----------------------------------------------------------------------
You card does not support hardware mixing so this is not possible.  You'll
have to use aoss.

----------------------------------------------------------------------
 rlrevell - 03-22-06 01:45 
----------------------------------------------------------------------
Not a bug

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-05 16:38 mador          New Issue                                    
09-26-05 16:38 mador          Distribution              => Fedora Core 4   
09-26-05 16:38 mador          Kernel Version            => 2.6.12-1.1456_FC4smp
#1 SMP Thu Sep 22 02:23:57 EDT 2005 x86_64 x86_64 x86_64 GNU/Linux
09-26-05 19:10 rlrevell       Note Added: 0006395                          
03-22-06 01:45 rlrevell       Status                   assigned => closed  
03-22-06 01:45 rlrevell       Note Added: 0008770                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
