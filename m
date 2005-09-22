From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000946]: Early playback DMA IRQ with CMI8738MC6 ==> extra noise
Date: Thu, 22 Sep 2005 19:24:53 +0200
Message-ID: <d1627456f3594ec425bd9f3a65eb4db9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F30A8151
	for <alsa-devel@alsa-project.org>; Thu, 22 Sep 2005 19:24:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=946> 
======================================================================
Reported By:                charles_levert
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   946
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.4.22
======================================================================
Date Submitted:             02-27-2005 14:20 CET
Last Modified:              09-22-2005 19:24 CEST
======================================================================
Summary:                    Early playback DMA IRQ with CMI8738MC6 ==> extra
noise
Description: 
This problem combines both a feature of the CMI8738MC6
hardware (alsa-kernel/pci/cmipci.c driver) and of the core
pcm kernel code (in alsa-kernel/core/pcm_lib.c).

It appears that the device produces an IRQ a little before
the end of its programmed period.

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000951 Fix bugs with early IRQs mishandling, m...
======================================================================

----------------------------------------------------------------------
 jdthood - 09-22-05 14:53 
----------------------------------------------------------------------
Submitter: What is the status of the issues you report here?

----------------------------------------------------------------------
 charles_levert - 09-22-05 19:24 
----------------------------------------------------------------------
Enquirer: The status is "being completely (and un-deservingly) ignored".  I
assume this intervention, just now, was an unintentional slip on your
part.  Same especially goes for associated issue 951.

Before you even bother with a generic and impulsive reply, take some
necessary time to reflect upon this situation and discuss it with your
comradeship.  And now, back to your regular programming.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-05 14:20 charles_levert New Issue                                    
02-27-05 14:20 charles_levert File Added: pcm_lib.c.diff                    
02-27-05 14:20 charles_levert Kernel Version            => 2.4.22          
02-28-05 14:02 charles_levert Note Added: 0003743                          
02-28-05 21:34 charles_levert Note Added: 0003749                          
03-01-05 09:36 perex          Relationship added       related to 0000951  
09-22-05 14:53 jdthood        Note Added: 0006336                          
09-22-05 19:24 charles_levert Note Added: 0006355                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
