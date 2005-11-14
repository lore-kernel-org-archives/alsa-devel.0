From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001535]: The sound card is detected. No sound from the speakers or headphones.
Date: Mon, 14 Nov 2005 11:58:34 +0100
Message-ID: <08f61f520a423496c806c44317a2fced@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0C4C319E
	for <alsa-devel@alsa-project.org>; Mon, 14 Nov 2005 11:58:35 +0100 (MET)
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
Last Modified:              11-14-2005 11:58 CET
======================================================================
Summary:                    The sound card is detected. No sound from the
speakers or headphones.
Description: 
I have a Motherboard Intel D915GAV with a sound card Intel HDA onboard,
chipset Realtek ALC880. The Sound Card is detected, the modules are
loaded, but no sound come from the speakers or headphones. 
======================================================================

----------------------------------------------------------------------
 jrgns - 11-10-05 16:00 
----------------------------------------------------------------------
I'm still having this problem. Info as follows:
Distro: Gentoo
Kernel: 2.6.12-r10
Hardware: 0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW
(ICH6 Family) High Definition Audio Controller (rev 04) (This is a Fujitsu
Siemens Amilo Pro V2040 Laptop)
Software: ALSA Driver Version 1.0.9b

I tried with various model=xxx options and different combinations of
channels muted, etc.. No luck

----------------------------------------------------------------------
 h4ndr3s - 11-14-05 11:58 
----------------------------------------------------------------------
Sorry for not to post in the past few days, but i dont have any time, and i
only can post from my job. Well, the 3stack-digout its supporting all the
functions of my card, so in this days i gives you the out from "lspci
-nv". See you later.

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
11-09-05 14:22 h4ndr3s        Note Added: 0006653                          
11-10-05 16:00 jrgns          Note Added: 0006664                          
11-14-05 11:58 h4ndr3s        Note Added: 0006720                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
