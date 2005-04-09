From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000562]: No AC3 sound playable through S/PDIF with certain amplifiers
Date: Sat, 9 Apr 2005 16:20:58 +0200
Message-ID: <80886b0e1be56aa8121256fecc69c484@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3EDF724F
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 16:20:58 +0200 (MEST)
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


The following issue has been set as DUPLICATE OF issue 0000481.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=562> 
======================================================================
Reported By:                herpes
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   562
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             10-03-2004 10:38 CEST
Last Modified:              04-09-2005 16:20 CEST
======================================================================
Summary:                    No AC3 sound playable through S/PDIF with certain
amplifiers
Description: 
This has already been on the mailing list, see also
http://www.mail-archive.com/alsa-user%40lists.sourceforge.net/msg13822.html.

When playing AC3 through the S/PDIF out on my Terratec 512i, I get no
sound at all. Normal PCM and DTS streams work.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000481 IEC958 Output doesn't work
======================================================================

----------------------------------------------------------------------
 tiwai - 10-06-04 12:14 
----------------------------------------------------------------------
Yes, it's a long-standing bug about AC3 on cs46xx.
cs46xx driver seems not passing the IEC958 status bits correctly.

----------------------------------------------------------------------
 tiwai - 10-12-04 14:48 
----------------------------------------------------------------------
One possibility is that the board uses the SPDIF output through
AC97 codec.  In this case, the IEC958 status must be updated on
AC97 chip.

Could you show /proc/asound/card0/codec97#*/* files during
AC3 playback?

----------------------------------------------------------------------
 herpes - 10-19-04 00:58 
----------------------------------------------------------------------
I added two files: the AC97 codec details as requested. The AC3 file was
generated during sound replay with ac3dec -6 -C ac3test.ac3. I can hear
sound, but no center and surround channels. The dts is played perfectly.

The question is: Both files are exactly the same. But why does dts work,
and AC3 not?

----------------------------------------------------------------------
 tiwai - 10-19-04 12:37 
----------------------------------------------------------------------
Some receiver requires the non-audio bit in IEC958 status for AC3
but not for DTS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-03-04 10:38 herpes         New Issue                                    
10-03-04 10:38 herpes         Distribution              => Debian          
10-03-04 10:38 herpes         Kernel Version            => 2.6.8.1         
10-06-04 12:14 tiwai          Note Added: 0002023                          
10-12-04 14:48 tiwai          Note Added: 0002097                          
10-19-04 00:46 herpes         File Added: codec-details-while-playing-dts.txt   
                
10-19-04 00:46 herpes         File Added: codec-details-while-playing-AC3.txt   
                
10-19-04 00:58 herpes         Note Added: 0002201                          
10-19-04 12:37 tiwai          Note Added: 0002203                          
04-09-05 16:20 jdthood        Relationship added       duplicate of 0000481
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
