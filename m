From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000946]: Early playback DMA IRQ with CMI8738MC6 ==> extra noise
Date: Tue, 1 Mar 2005 09:36:09 +0100
Message-ID: <6da6a383d6f0102ca6628f31617fe0e5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B86FF205
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2005 09:36:09 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0000951.
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
Last Modified:              02-28-2005 21:34 CET
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
 charles_levert - 02-28-05 14:02 
----------------------------------------------------------------------
I devoted some time on investigating this issue, and
while the first proposed patch fixes part of the problem,
it doesn't fix everything involved.

I have developed a more extensive patch.  It still only
needs to cover the generic part of the kernel code.
It will probably be beneficial to all users, regardless
of their specific audio hardware.

In the process, I found a few unexpected existing bugs
with relevant code that I have also fixed.

I will test this new patch for a few days with various
sound programs to make sure that it works fine.  When I am
confident that it is of high quality, I will open another
bug issue in the pcm core section of the ALSA bugtracking
system and post it there, while providing a link to this
bug issue.

----------------------------------------------------------------------
 charles_levert - 02-28-05 21:34 
----------------------------------------------------------------------
A new bug issue has been opened under
"[ALSA - driver] CORE - pcm" and contains the new patch
to generic kernel code.

    <https://bugtrack.alsa-project.org/alsa-bug/view.php?id=951>

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-27-05 14:20 charles_levert New Issue                                    
02-27-05 14:20 charles_levert File Added: pcm_lib.c.diff                    
02-27-05 14:20 charles_levert Kernel Version            => 2.4.22          
02-28-05 14:02 charles_levert Note Added: 0003743                          
02-28-05 21:34 charles_levert Note Added: 0003749                          
03-01-05 09:36 perex          Relationship added       related to 0000951  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
