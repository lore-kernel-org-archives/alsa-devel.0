From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000562]: No AC3 sound playable through S/PDIF with certain amplifiers
Date: Tue, 19 Oct 2004 12:37:55 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041019103755.DDA6911030@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4E8B92FF
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2004 12:37:56 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000562
======================================================================
Reported By:                herpes
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     562
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             10-03-2004 10:38 CEST
Last Modified:              10-19-2004 12:37 CEST
======================================================================
Summary:                    No AC3 sound playable through S/PDIF with certain amplifiers
Description: 
This has already been on the mailing list, see also
http://www.mail-archive.com/alsa-user%40lists.sourceforge.net/msg13822.html.

When playing AC3 through the S/PDIF out on my Terratec 512i, I get no
sound at all. Normal PCM and DTS streams work.
======================================================================

----------------------------------------------------------------------
 tiwai - 10-06-2004 12:14 CEST 
----------------------------------------------------------------------
Yes, it's a long-standing bug about AC3 on cs46xx.
cs46xx driver seems not passing the IEC958 status bits correctly.

----------------------------------------------------------------------
 tiwai - 10-12-2004 14:48 CEST 
----------------------------------------------------------------------
One possibility is that the board uses the SPDIF output through
AC97 codec.  In this case, the IEC958 status must be updated on
AC97 chip.

Could you show /proc/asound/card0/codec97#*/* files during
AC3 playback?

----------------------------------------------------------------------
 herpes - 10-19-2004 00:58 CEST 
----------------------------------------------------------------------
I added two files: the AC97 codec details as requested. The AC3 file was
generated during sound replay with ac3dec -6 -C ac3test.ac3. I can hear
sound, but no center and surround channels. The dts is played perfectly.

The question is: Both files are exactly the same. But why does dts work,
and AC3 not?

----------------------------------------------------------------------
 tiwai - 10-19-2004 12:37 CEST 
----------------------------------------------------------------------
Some receiver requires the non-audio bit in IEC958 status for AC3
but not for DTS.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
10-03-04 10:38 herpes         New Bug                                      
10-03-04 10:38 herpes         Distribution              => Debian          
10-03-04 10:38 herpes         Kernel Version            => 2.6.8.1         
10-06-04 12:14 tiwai          Bugnote Added: 0002023                       
10-12-04 14:48 tiwai          Bugnote Added: 0002097                       
10-19-04 00:46 herpes         File Added: codec-details-while-playing-dts.txt                    
10-19-04 00:46 herpes         File Added: codec-details-while-playing-AC3.txt                    
10-19-04 00:58 herpes         Bugnote Added: 0002201                       
10-19-04 12:37 tiwai          Bugnote Added: 0002203                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
