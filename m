From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001462]: Internal OSS emulation doesn't use the hardware mixer?
Date: Mon, 26 Sep 2005 16:38:49 +0200
Message-ID: <e0b5dda941b0201167ba146089dec39f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E1ED3178
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2005 16:38:49 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.12-1.1456_FC4smp #1 SMP Thu Sep 22 02:23:57 EDT
2005 x86_64 x86_64 x86_64 GNU/Linux
======================================================================
Date Submitted:             09-26-2005 16:38 CEST
Last Modified:              09-26-2005 16:38 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-05 16:38 mador          New Issue                                    
09-26-05 16:38 mador          Distribution              => Fedora Core 4   
09-26-05 16:38 mador          Kernel Version            => 2.6.12-1.1456_FC4smp
#1 SMP Thu Sep 22 02:23:57 EDT 2005 x86_64 x86_64 x86_64 GNU/Linux
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
