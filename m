From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000505]: SPDIF sound distorted on non-48000 rates
Date: Thu, 23 Sep 2004 18:37:05 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040923163705.21BA74500E@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8C54632A
	for <alsa-devel@alsa-project.org>; Thu, 23 Sep 2004 18:37:05 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000505
======================================================================
Reported By:                ramendik
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     505
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               RH-based
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             09-19-2004 10:03 CEST
Last Modified:              09-23-2004 18:37 CEST
======================================================================
Summary:                    SPDIF sound distorted on non-48000 rates
Description: 
I have an Intel ICH AC97 sound subsystem, on an Intel i865 motherboard(ASUS
P4P800). It has an analog output and an SPDIF output.When I play 48Khz
files, thinks are OK on all outputs. But when I play 44.1 Khz files, the
sound on the SPDIF output is audibly distorted. The analog output is OK.

I am using the 2.6.8.1 kernel, and tried both the ALSA inside it (1.0.4)
and newer alsa-driver 1.0.7rc1. This same problem shows up with 2.6.6 and
2.6.7 kernels. So apparently it's present across several versons of ALSA.

======================================================================

----------------------------------------------------------------------
 tiwai - 09-23-2004 18:37 CEST 
----------------------------------------------------------------------
Which ac97 codec?  Please attach /proc/asound/card0/codec97#0/* files.
Also, check the IEC958 status bits (run iecset) during playback of
44.1kHz samples.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 10:03 ramendik       New Bug                                      
09-19-04 10:03 ramendik       Distribution              => RH-based        
09-19-04 10:03 ramendik       Kernel Version            => 2.6.8.1         
09-19-04 10:05 ramendik       Bug Monitored: ramendik                      
09-23-04 18:37 tiwai          Bugnote Added: 0001831                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
