From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001443]: ALSA Uses Space in Front of Name
Date: Thu, 22 Sep 2005 22:26:37 +0200
Message-ID: <626c88d55ecbcf6d07a12786aa9a0266@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 659A5147
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 22:26:37 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1443> 
======================================================================
Reported By:                b0ef
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   1443
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             09-22-2005 22:26 CEST
Last Modified:              09-22-2005 22:26 CEST
======================================================================
Summary:                    ALSA Uses Space in Front of Name
Description: 
The midi port, previously named "DSP MIDI" is now named " MIDI" with a
space in front. This causes problems with some applications, causing them
to not work. 

I don't think a space in front of the name is allowed even?

linux-2.6.13-rt13 with alsa 1.0.9b

I have the HDSP Multiface II, which is working fine, 100% firmware
compatible and should be added to the ALSA supported devices list. 
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-22-05 22:26 b0ef           New Issue                                    
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
