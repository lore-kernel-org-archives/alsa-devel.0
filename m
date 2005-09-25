From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001456]: some Realtek ALC861 hda-intel problems
Date: Sun, 25 Sep 2005 12:35:52 +0200
Message-ID: <2635681b1c6a4f562f62c4ec7eb5d829@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1273918A
	for <alsa-devel@alsa-project.org>; Sun, 25 Sep 2005 12:35:52 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1456> 
======================================================================
Reported By:                kaloian
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1456
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.13
======================================================================
Date Submitted:             09-25-2005 12:35 CEST
Last Modified:              09-25-2005 12:35 CEST
======================================================================
Summary:                    some Realtek ALC861 hda-intel problems
Description: 
First I'm not sure that chip 861 is suported?...Alsa rekognize it like
880....and therfore there are some unusable sliders at mixer control -
like 3 input controls instead one...and Master volume is missing. Also
have problem with straching sound reported already here but it's not big
problem while work fine with OSS. Other big problem for me is that when
start Linux from system halt alsa dont work at all - alsamixer shows only
1 or two controls - front or pcm but they dont realy work...even I try
remove and load module hda-intel but..... To resolve this I need to start
first windows(XP) and then reboot(not halt) system - now alsa work. I'm
not sure where to look for problem - alsa or bios. 

Motherboard is ASUS  P5RD1-V Deluxe with ATI  XPRESS NBridge and Uli 1573
SBridge with integrated sound - Realtek ALC861. Bios is newest version -
0802. Kernel 2.6.13, alsa-driver 1.0.9b.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 12:35 kaloian        New Issue                                    
09-25-05 12:35 kaloian        Kernel Version            => 2.6.13          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
